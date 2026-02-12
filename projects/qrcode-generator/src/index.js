/**
 * CLI Gerador de QR Codes para E-commerce
 * Entry point principal
 */

import { Command } from 'commander';
import inquirer from 'inquirer';
import chalk from 'chalk';
import { generateSingle } from './commands/generate.js';
import { generateBatch } from './commands/batch.js';
import { showBanner, logger } from './utils/logger.js';

const program = new Command();

// Configuração do CLI
program
  .name('qrcode-gen')
  .description('Gerador de QR Codes para e-commerces')
  .version('1.0.0');

// Comando: generate
program
  .command('generate')
  .description('Gera um QR Code único')
  .option('-u, --url <url>', 'URL do produto')
  .option('-n, --name <name>', 'Nome do arquivo', 'qrcode')
  .option('-c, --color <color>', 'Cor do QR (hex)', '#000000')
  .option('-b, --bg <color>', 'Cor de fundo (hex)', '#FFFFFF')
  .option('-s, --size <size>', 'Tamanho do módulo', '5')
  .option('-t, --type <type>', 'Formato (png/svg)', 'png')
  .option('-o, --output <path>', 'Pasta de saída', './output')
  .action(async (options) => {
    // Se não passou opções, modo interativo
    if (!options.url) {
      await interactiveMode();
    } else {
      await generateSingle(options);
    }
  });

// Comando: batch
program
  .command('batch')
  .description('Gera múltiplos QR Codes via arquivo')
  .requiredOption('-f, --file <file>', 'Arquivo JSON ou CSV com dados')
  .option('-o, --output <path>', 'Pasta de saída', './output')
  .action(async (options) => {
    await generateBatch(options.file, options.output);
  });

// Modo interativo padrão (sem comandos)
if (process.argv.length === 2) {
  showBanner();
  interactiveMode();
} else {
  program.parse();
}

// Modo interativo com prompts
async function interactiveMode() {
  showBanner();
  
  const { mode } = await inquirer.prompt([
    {
      type: 'list',
      name: 'mode',
      message: 'Escolha o modo de operação:',
      choices: [
        { name: '🎯 Gerar QR Code único', value: 'single' },
        { name: '📦 Geração em lote (arquivo)', value: 'batch' },
        { name: '📋 Usar template de produto', value: 'template' }
      ]
    }
  ]);

  if (mode === 'single') {
    const answers = await inquirer.prompt([
      {
        type: 'input',
        name: 'url',
        message: '🔗 Digite a URL do produto:',
        validate: (input) => input.length > 0 || 'URL é obrigatória'
      },
      {
        type: 'input',
        name: 'name',
        message: '🏷️  Digite o nome do arquivo:',
        default: 'qrcode-produto'
      },
      {
        type: 'input',
        name: 'color',
        message: '🎨 Cor do QR Code (hex):',
        default: '#000000',
        validate: (input) => /^#([0-9A-F]{3}){1,2}$/i.test(input) || 'Cor hex inválida'
      },
      {
        type: 'input',
        name: 'bg',
        message: '⬜ Cor de fundo (hex):',
        default: '#FFFFFF',
        validate: (input) => /^#([0-9A-F]{3}){1,2}$/i.test(input) || 'Cor hex inválida'
      },
      {
        type: 'list',
        name: 'size',
        message: '📏 Tamanho:',
        choices: [
          { name: 'Pequeno (300px)', value: '4' },
          { name: 'Médio (500px)', value: '6' },
          { name: 'Grande (800px)', value: '8' },
          { name: 'Extra (1000px)', value: '10' }
        ]
      },
      {
        type: 'list',
        name: 'type',
        message: '💾 Formato:',
        choices: ['png', 'svg']
      }
    ]);

    await generateSingle(answers);
    
  } else if (mode === 'batch') {
    const { filePath } = await inquirer.prompt([
      {
        type: 'input',
        name: 'filePath',
        message: '📁 Caminho do arquivo (JSON ou CSV):',
        validate: (input) => input.length > 0 || 'Caminho é obrigatório'
      }
    ]);
    
    await generateBatch(filePath, './output');
    
  } else if (mode === 'template') {
    await templateMode();
  }
}

// Modo template com produtos pré-definidos
async function templateMode() {
  const { productTemplate } = await inquirer.prompt([
    {
      type: 'list',
      name: 'productTemplate',
      message: '📋 Escolha um template:',
      choices: [
        { name: '🛒 Produto Genérico', value: 'generic' },
        { name: '🎁 Promoção Black Friday', value: 'blackfriday' },
        { name: '📱 Lançamento Novo', value: 'launch' },
        { name: '🏷️  Cupom Desconto', value: 'coupon' }
      ]
    }
  ]);

  const templates = {
    generic: {
      url: 'https://sualoja.com/produto/exemplo',
      name: 'produto-generico',
      color: '#000000'
    },
    blackfriday: {
      url: 'https://sualoja.com/black-friday',
      name: 'promo-blackfriday',
      color: '#FF0000',
      bg: '#000000'
    },
    launch: {
      url: 'https://sualoja.com/lancamento',
      name: 'lancamento-novo',
      color: '#4A90E2'
    },
    coupon: {
      url: 'https://sualoja.com/cupom/BEMVINDO20',
      name: 'cupom-bemvindo',
      color: '#7B68EE'
    }
  };

  const template = templates[productTemplate];
  
  const { customUrl } = await inquirer.prompt([
    {
      type: 'input',
      name: 'customUrl',
      message: '🔗 Digite a URL específica (ou Enter para usar padrão):',
      default: template.url
    }
  ]);

  await generateSingle({
    ...template,
    url: customUrl,
    size: '6',
    type: 'png',
    output: './output'
  });
}
