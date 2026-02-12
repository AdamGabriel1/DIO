/**
 * Utilitários de logging com cores
 */

import chalk from 'chalk';

export const logger = {
  info: (msg) => console.log(chalk.blue('ℹ️  ') + msg),
  success: (msg) => console.log(chalk.green('✅ ') + msg),
  error: (msg) => console.log(chalk.red('❌ ') + msg),
  warning: (msg) => console.log(chalk.yellow('⚠️  ') + msg),
  detail: (msg) => console.log(chalk.gray('   ' + msg))
};

export function showBanner() {
  console.log('');
  console.log(chalk.cyan('========================================'));
  console.log(chalk.cyan('📱 ') + chalk.white.bold('GERADOR DE QR CODE - E-COMMERCE'));
  console.log(chalk.cyan('========================================'));
  console.log('');
}
