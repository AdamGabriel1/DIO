/**
 * Sistema de Carrinho de Compras - Shopee Style
 * Entry point e interface de linha de comando
 */

import readline from 'readline';
import { CartService } from './services/CartService.js';
import { ProductService } from './services/ProductService.js';
import { formatCurrency, colorize } from './utils/formatter.js';

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

const cartService = new CartService();
const productService = new ProductService();

function showMenu() {
  console.log('\n' + '='.repeat(50));
  console.log(colorize('🛒  SHOPEE CART - TERMINAL EDITION', 'CYAN'));
  console.log('='.repeat(50));
  console.log('1. 📦 Ver catálogo de produtos');
  console.log('2. ➕ Adicionar produto ao carrinho');
  console.log('3. 🗑️  Remover produto do carrinho');
  console.log('4. 📝 Alterar quantidade');
  console.log('5. 🛒 Ver meu carrinho');
  console.log('6. 💝 Adicionar aos favoritos');
  console.log('7. 🎟️  Aplicar cupom de desconto');
  console.log('8. 💳 Finalizar compra');
  console.log('9. ❌ Sair');
  console.log('='.repeat(50));
}

function askQuestion(question) {
  return new Promise((resolve) => {
    rl.question(question, (answer) => resolve(answer.trim()));
  });
}

async function showCatalog() {
  console.log('\n📦 CATÁLOGO DE PRODUTOS\n');
  const products = productService.getAllProducts();
  
  products.forEach(product => {
    console.log(`[${product.id}] ${colorize(product.name, 'YELLOW')}`);
    console.log(`    💰 ${formatCurrency(product.price)} | ⭐ ${product.rating} | 🛍️  ${product.sales} vendidos`);
    console.log(`    📦 Estoque: ${product.stock} unidades | 🏷️  ${product.category}`);
    console.log(`    ${product.description.substring(0, 60)}...`);
    console.log('');
  });
}

async function addToCart() {
  await showCatalog();
  const productId = await askQuestion('Digite o ID do produto: ');
  const product = productService.getProductById(parseInt(productId));
  
  if (!product) {
    console.log(colorize('❌ Produto não encontrado!', 'RED'));
    return;
  }
  
  if (product.stock <= 0) {
    console.log(colorize('❌ Produto fora de estoque!', 'RED'));
    return;
  }
  
  const quantity = await askQuestion(`Quantidade (max ${product.stock}): `);
  const qty = parseInt(quantity);
  
  if (isNaN(qty) || qty <= 0) {
    console.log(colorize('❌ Quantidade inválida!', 'RED'));
    return;
  }
  
  if (qty > product.stock) {
    console.log(colorize(`❌ Estoque insuficiente! Apenas ${product.stock} unidades.`, 'RED'));
    return;
  }
  
  const result = cartService.addItem(product, qty);
  if (result.success) {
    console.log(colorize(`\n✅ ${result.message}`, 'GREEN'));
    console.log(`Subtotal: ${formatCurrency(product.price * qty)}`);
  } else {
    console.log(colorize(`\n❌ ${result.message}`, 'RED'));
  }
}

async function removeFromCart() {
  const cart = cartService.getCart();
  if (cart.items.length === 0) {
    console.log(colorize('\n🛒 Carrinho vazio!', 'YELLOW'));
    return;
  }
  
  await showCart();
  const index = await askQuestion('Digite o número do item para remover: ');
  const idx = parseInt(index) - 1;
  
  const result = cartService.removeItem(idx);
  console.log(colorize(result.message, result.success ? 'GREEN' : 'RED'));
}

async function updateQuantity() {
  const cart = cartService.getCart();
  if (cart.items.length === 0) {
    console.log(colorize('\n🛒 Carrinho vazio!', 'YELLOW'));
    return;
  }
  
  await showCart();
  const index = await askQuestion('Digite o número do item: ');
  const idx = parseInt(index) - 1;
  
  const newQty = await askQuestion('Nova quantidade: ');
  const qty = parseInt(newQty);
  
  const result = cartService.updateQuantity(idx, qty);
  console.log(colorize(result.message, result.success ? 'GREEN' : 'RED'));
}

async function showCart() {
  const cart = cartService.getCart();
  console.log('\n🛒 MEU CARRINHO\n');
  
  if (cart.items.length === 0) {
    console.log('Seu carrinho está vazio 😢');
    console.log('Adicione produtos do catálogo!');
    return;
  }
  
  cart.items.forEach((item, index) => {
    console.log(`${index + 1}. ${colorize(item.product.name, 'YELLOW')}`);
    console.log(`   ${item.quantity} un x ${formatCurrency(item.product.price)} = ${formatCurrency(item.subtotal)}`);
  });
  
  console.log('\n' + '-'.repeat(40));
  console.log(`Subtotal:     ${formatCurrency(cart.subtotal)}`);
  console.log(`Frete:        ${formatCurrency(cart.shipping)} (${cart.shippingRegion})`);
  if (cart.discount > 0) {
    console.log(`Desconto:     -${formatCurrency(cart.discount)}`);
  }
  console.log('-'.repeat(40));
  console.log(`${colorize('TOTAL:', 'GREEN')}        ${colorize(formatCurrency(cart.total), 'GREEN')}`);
  
  if (cart.coupon) {
    console.log(`\n🎟️  Cupom aplicado: ${cart.coupon.code}`);
  }
}

async function addToFavorites() {
  await showCatalog();
  const productId = await askQuestion('Digite o ID do produto para favoritar: ');
  const product = productService.getProductById(parseInt(productId));
  
  if (!product) {
    console.log(colorize('❌ Produto não encontrado!', 'RED'));
    return;
  }
  
  const result = cartService.addToFavorites(product);
  console.log(colorize(result.message, result.success ? 'GREEN' : 'YELLOW'));
}

async function applyCoupon() {
  console.log('\n🎟️  CUPONS DISPONÍVEIS:');
  console.log('SHOPEE10      - 10% de desconto');
  console.log('FRETEGRATIS   - Frete grátis');
  console.log('PRIMEIRA20    - R$ 20,00 de desconto');
  console.log('BLACKFRIDAY   - 25% de desconto (mínimo R$ 200)');
  
  const code = await askQuestion('\nDigite o código do cupom: ');
  const result = cartService.applyCoupon(code.toUpperCase());
  
  console.log(colorize(result.message, result.success ? 'GREEN' : 'RED'));
  if (result.success) {
    await showCart();
  }
}

async function checkout() {
  const cart = cartService.getCart();
  
  if (cart.items.length === 0) {
    console.log(colorize('\n❌ Carrinho vazio! Adicione produtos antes de finalizar.', 'RED'));
    return;
  }
  
  await showCart();
  
  console.log('\n💳 FINALIZAÇÃO DA COMPRA');
  console.log('1. Cartão de Crédito');
  console.log('2. Pix');
  console.log('3. Boleto');
  
  const payment = await askQuestion('\nEscolha a forma de pagamento: ');
  
  console.log('\n' + '='.repeat(50));
  console.log(colorize('🎉 PEDIDO CONFIRMADO!', 'GREEN'));
  console.log('='.repeat(50));
  console.log(`Número do pedido: #${Math.floor(Math.random() * 1000000)}`);
  console.log(`Total pago: ${formatCurrency(cart.total)}`);
  console.log(`Forma: ${['Cartão', 'Pix', 'Boleto'][parseInt(payment) - 1] || 'Cartão'}`);
  console.log('\n📦 Previsão de entrega: 5-10 dias úteis');
  console.log('\nObrigado por comprar na Shopee! 🛒');
  console.log('='.repeat(50));
  
  // Limpa carrinho após compra
  cartService.clearCart();
}

async function main() {
  console.log(colorize('\n🚀 Bem-vindo ao Sistema de Carrinho Shopee!', 'CYAN'));
  console.log('Carregando catálogo de produtos...\n');
  
  let running = true;
  
  while (running) {
    showMenu();
    const option = await askQuestion('Escolha uma opção: ');
    
    switch (option) {
      case '1':
        await showCatalog();
        break;
      case '2':
        await addToCart();
        break;
      case '3':
        await removeFromCart();
        break;
      case '4':
        await updateQuantity();
        break;
      case '5':
        await showCart();
        break;
      case '6':
        await addToFavorites();
        break;
      case '7':
        await applyCoupon();
        break;
      case '8':
        await checkout();
        break;
      case '9':
        running = false;
        console.log(colorize('\n👋 Obrigado por usar o Shopee Cart! Volte sempre!', 'CYAN'));
        break;
      default:
        console.log(colorize('\n❌ Opção inválida!', 'RED'));
    }
    
    if (running && option !== '5') {
      await askQuestion('\nPressione ENTER para continuar...');
    }
  }
  
  rl.close();
}

main().catch(err => {
  console.error('Erro fatal:', err);
  rl.close();
  process.exit(1);
});
