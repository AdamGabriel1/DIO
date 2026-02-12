/**
 * Utilitários de formatação
 */

export const COLORS = {
  RESET: '\x1b[0m',
  RED: '\x1b[31m',
  GREEN: '\x1b[32m',
  YELLOW: '\x1b[33m',
  BLUE: '\x1b[34m',
  MAGENTA: '\x1b[35m',
  CYAN: '\x1b[36m',
  WHITE: '\x1b[37m'
};

export function colorize(text, color) {
  return `${COLORS[color]}${text}${COLORS.RESET}`;
}

export function formatCurrency(value) {
  return new Intl.NumberFormat('pt-BR', {
    style: 'currency',
    currency: 'BRL'
  }).format(value);
}

export function formatDate(date) {
  return new Intl.DateTimeFormat('pt-BR').format(date);
}

export function truncate(text, length) {
  return text.length > length ? text.substring(0, length) + '...' : text;
}
