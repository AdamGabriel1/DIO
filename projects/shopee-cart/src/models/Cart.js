/**
 * Modelo do Carrinho de Compras
 * Contém a estrutura de dados e estado do carrinho
 */

export class CartItem {
  constructor(product, quantity) {
    this.product = product;
    this.quantity = quantity;
    this.subtotal = product.price * quantity;
    this.addedAt = new Date();
  }

  updateQuantity(newQuantity) {
    this.quantity = newQuantity;
    this.subtotal = this.product.price * newQuantity;
  }
}

export class Cart {
  constructor() {
    this.items = [];
    this.favorites = [];
    this.coupon = null;
    this.shippingRegion = 'Sudeste';
    this.shippingBase = 15.00;
  }

  get subtotal() {
    return this.items.reduce((sum, item) => sum + item.subtotal, 0);
  }

  get shipping() {
    if (this.coupon?.freeShipping) return 0;
    if (this.subtotal >= 199) return 0; // Frete grátis acima de R$ 199
    
    // Regiões
    const multipliers = {
      'Sudeste': 1.0,
      'Sul': 1.3,
      'Nordeste': 1.5,
      'Centro-Oeste': 1.4,
      'Norte': 1.8
    };
    
    return this.shippingBase * (multipliers[this.shippingRegion] || 1.0);
  }

  get discount() {
    if (!this.coupon) return 0;
    
    const subtotal = this.subtotal;
    
    // Valor mínimo para cupom
    if (this.coupon.minValue && subtotal < this.coupon.minValue) {
      return 0;
    }
    
    if (this.coupon.type === 'percentage') {
      return subtotal * (this.coupon.value / 100);
    }
    
    if (this.coupon.type === 'fixed') {
      return Math.min(this.coupon.value, subtotal); // Não ultrapassa subtotal
    }
    
    return 0;
  }

  get total() {
    return Math.max(0, this.subtotal + this.shipping - this.discount);
  }

  addItem(product, quantity) {
    const existingItem = this.items.find(item => item.product.id === product.id);
    
    if (existingItem) {
      const newQuantity = existingItem.quantity + quantity;
      if (!product.isAvailable(newQuantity)) {
        return { success: false, message: 'Estoque insuficiente para quantidade total' };
      }
      existingItem.updateQuantity(newQuantity);
      return { success: true, message: `Quantidade atualizada: ${newQuantity}x ${product.name}` };
    }
    
    if (!product.isAvailable(quantity)) {
      return { success: false, message: 'Estoque insuficiente' };
    }
    
    const cartItem = new CartItem(product, quantity);
    this.items.push(cartItem);
    return { success: true, message: `Adicionado: ${quantity}x ${product.name}` };
  }

  removeItem(index) {
    if (index < 0 || index >= this.items.length) {
      return { success: false, message: 'Item não encontrado' };
    }
    
    const removed = this.items.splice(index, 1)[0];
    return { success: true, message: `Removido: ${removed.product.name}` };
  }

  updateItemQuantity(index, newQuantity) {
    if (index < 0 || index >= this.items.length) {
      return { success: false, message: 'Item não encontrado' };
    }
    
    if (newQuantity <= 0) {
      return this.removeItem(index);
    }
    
    const item = this.items[index];
    if (!item.product.isAvailable(newQuantity)) {
      return { success: false, message: `Estoque máximo: ${item.product.stock} unidades` };
    }
    
    item.updateQuantity(newQuantity);
    return { success: true, message: `Quantidade atualizada: ${newQuantity}x ${item.product.name}` };
  }

  addToFavorites(product) {
    if (this.favorites.some(f => f.id === product.id)) {
      return { success: false, message: 'Produto já está nos favoritos' };
    }
    
    if (this.favorites.length >= 50) {
      return { success: false, message: 'Limite de favoritos atingido (50)' };
    }
    
    this.favorites.push(product);
    return { success: true, message: `Adicionado aos favoritos: ${product.name}` };
  }

  applyCoupon(couponCode, availableCoupons) {
    const coupon = availableCoupons[couponCode];
    
    if (!coupon) {
      return { success: false, message: 'Cupom inválido ou expirado' };
    }
    
    // Verifica se cupom já aplicado
    if (this.coupon && this.coupon.code === couponCode) {
      return { success: false, message: 'Cupom já aplicado' };
    }
    
    this.coupon = { ...coupon, code: couponCode };
    return { success: true, message: `Cupom ${couponCode} aplicado!` };
  }

  clear() {
    this.items = [];
    this.coupon = null;
  }

  setShippingRegion(region) {
    const validRegions = ['Sudeste', 'Sul', 'Nordeste', 'Centro-Oeste', 'Norte'];
    if (validRegions.includes(region)) {
      this.shippingRegion = region;
    }
  }
}
