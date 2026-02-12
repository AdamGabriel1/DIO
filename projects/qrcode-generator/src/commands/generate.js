/**
 * Comando de geração única de QR Code
 */

import QRCode from 'qrcode';
import fs from 'fs-extra';
import path from 'path';
import chalk from 'chalk';
import clipboardy from 'clipboardy';
import { logger } from '../utils/logger.js';
import { validateUrl } from '../utils/validator.js';

export async function generateSingle(options) {
  try {
    const { url, name, color, bg, size, type, output } = options;
    
    // Validações
    if (!validateUrl(url)) {
      logger.error('URL inválida! Use http:// ou https://');
      return;
    }

    // Cria pasta de saída se não existir
    await fs.ensureDir(output);
    
    const filePath = path.join(output, `${name}.${type}`);
    
    logger.info('Gerando QR Code...');
    logger.detail(`URL: ${url}`);
    logger.detail(`Arquivo: ${filePath}`);

    // Configurações do QR Code
    const qrOptions = {
      color: {
        dark: color,
        light: bg
      },
      width: parseInt(size) * 100, // Converte tamanho em pixels aproximados
      margin: 2,
      type: type === 'svg' ? 'svg' : 'png'
    };

    // Geração do QR Code
    if (type === 'svg') {
      const svgString = await QRCode.toString(url, { ...qrOptions, type: 'svg' });
      await fs.writeFile(filePath, svgString);
    } else {
      await QRCode.toFile(filePath, url, qrOptions);
    }

    // Sucesso
    logger.success('QR Code gerado com sucesso!');
    console.log('');
    logger.info('📁 Detalhes do arquivo:');
    console.log(`   Nome: ${chalk.cyan(name)}.${type}`);
    console.log(`   Caminho: ${chalk.cyan(path.resolve(filePath))}`);
    console.log(`   Dimensões: ~${qrOptions.width}px`);
    console.log(`   Cores: ${chalk.hex(color)('■')} QR / ${chalk.hex(bg)('■')} Fundo`);
    console.log('');

    // Pergunta se deseja copiar para clipboard
    if (process.stdout.isTTY) {
      const { copy } = await import('inquirer').then(m => 
        m.default.prompt([
          {
            type: 'confirm',
            name: 'copy',
            message: '📋 Copiar caminho do arquivo para área de transferência?',
            default: false
          }
        ])
      );
      
      if (copy) {
        await clipboardy.write(path.resolve(filePath));
        logger.success('Caminho copiado!');
      }
    }

    // Exibe QR Code no terminal (opcional para PNG pequenos)
    if (type === 'png' && parseInt(size) <= 6) {
      console.log('');
      logger.info('Pré-visualização:');
      await QRCode.toString(url, { type: 'terminal', small: true })
        .then(str => console.log(str));
    }

  } catch (error) {
    logger.error(`Erro ao gerar QR Code: ${error.message}`);
    process.exit(1);
  }
}
