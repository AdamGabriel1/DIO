/**
 * Serviço de Carrinho
 * Orquestra operações e regras de negócio
 */

import { Cart } from '../models/Cart.js';

const AVAILABLE_COUPONS = {
  'SHOPEE10': {
    type: 'percentage',
    value: 10,
    description: '10% de desconto',
    minValue: 0
  },
  'FRETEGRATIS': {
    type: 'shipping',
    freeShipping: true,
    description: 'Frete grátis',
    minValue: 0
  },
  'PRIMEIRA20': {
    type: 'fixed',
    value: 20,
    description: 'R$ 20,00 de desconto',
    minValue: 50 // Mínimo R$ 50
  },
  'BLACKFRIDAY': {
    type: 'percentage',
    value: 25,
    description: '25% OFF (min R$ 200)',
    minValue: 200
  }
};

export class CartService {
  constructor() {
    this.cart = new Cart();
  }

  addItem(product, quantity) {
    return this.cart.addItem(product, quantity);
  }

  removeItem(index) {
    return this.cart.removeItem(index);
  }

  updateQuantity(index, newQuantity) {
    return this.cart.updateItemQuantity(index, newQuantity);
  }

  addToFavorites(product) {
    return this.cart.addToFavorites(product);
  }

  applyCoupon(code) {
    return this.cart.applyCoupon(code, AVAILABLE_COUPONS);
  }

  getCart() {
    return {
      items: this.cart.items,
      subtotal: this.cart.subtotal,
      shipping: this.cart.shipping,
      discount: this.cart.discount,
      total: this.cart.total,
      coupon: this.cart.coupon,
      shippingRegion: this.cart.shippingRegion,
      favorites: this.cart.favorites
    };
  }

  clearCart() {
    this.cart.clear();
  }

  setRegion(region) {
    this.cart.setShippingRegion(region);
  }
}
