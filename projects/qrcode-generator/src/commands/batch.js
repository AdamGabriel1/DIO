/**
 * Geração em lote de QR Codes via arquivo
 */

import fs from 'fs-extra';
import path from 'path';
import csv from 'csv-parse/sync';
import QRCode from 'qrcode';
import { logger } from '../utils/logger.js';
import { validateUrl } from '../utils/validator.js';

export async function generateBatch(filePath, outputDir) {
  try {
    // Verifica se arquivo existe
    if (!await fs.pathExists(filePath)) {
      logger.error(`Arquivo não encontrado: ${filePath}`);
      return;
    }

    // Lê e parseia o arquivo
    const ext = path.extname(filePath).toLowerCase();
    let products = [];

    if (ext === '.json') {
      const data = await fs.readJson(filePath);
      products = Array.isArray(data) ? data : [data];
    } else if (ext === '.csv') {
      const content = await fs.readFile(filePath, 'utf-8');
      products = csv.parse(content, {
        columns: true,
        skip_empty_lines: true
      });
    } else {
      logger.error('Formato não suportado. Use JSON ou CSV.');
      return;
    }

    if (products.length === 0) {
      logger.warning('Nenhum produto encontrado no arquivo.');
      return;
    }

    logger.info(`Processando ${products.length} QR Code(s)...`);
    await fs.ensureDir(outputDir);

    const results = {
      success: [],
      failed: []
    };

    for (let i = 0; i < products.length; i++) {
      const product = products[i];
      const current = i + 1;

      console.log(`\n[${current}/${products.length}] Processando: ${product.name || 'sem-nome'}`);

      // Validações básicas
      if (!product.url || !validateUrl(product.url)) {
        logger.error(`  URL inválida: ${product.url}`);
        results.failed.push({ product, error: 'URL inválida' });
        continue;
      }

      const fileName = product.name 
        ? product.name.replace(/[^a-z0-9]/gi, '-').toLowerCase()
        : `qrcode-${current}`;

      const filePath = path.join(outputDir, `${fileName}.png`);

      try {
        const options = {
          color: {
            dark: product.color || '#000000',
            light: product.bg || '#FFFFFF'
          },
          width: parseInt(product.size || '5') * 100,
          margin: 2
        };

        await QRCode.toFile(filePath, product.url, options);
        
        logger.success(`  ✅ ${fileName}.png gerado`);
        results.success.push({ name: fileName, path: filePath });

      } catch (err) {
        logger.error(`  ❌ Erro: ${err.message}`);
        results.failed.push({ product, error: err.message });
      }
    }

    // Relatório final
    console.log('\n' + '='.repeat(50));
    logger.info('RELATÓRIO DE GERAÇÃO');
    console.log('='.repeat(50));
    console.log(`✅ Sucesso: ${results.success.length}`);
    console.log(`❌ Falhas: ${results.failed.length}`);
    console.log(`📁 Pasta: ${path.resolve(outputDir)}`);
    
    if (results.failed.length > 0) {
      console.log('\nFalhas detalhadas:');
      results.failed.forEach((f, i) => {
        console.log(`  ${i + 1}. ${f.product.name || 'Desconhecido'}: ${f.error}`);
      });
    }

  } catch (error) {
    logger.error(`Erro no processamento em lote: ${error.message}`);
    process.exit(1);
  }
}
