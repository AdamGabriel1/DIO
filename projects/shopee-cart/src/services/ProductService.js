/**
 * Serviço de Produtos
 * Gerencia catálogo e buscas
 */

import { products } from '../data/products.js';

export class ProductService {
  constructor() {
    this.products = products;
  }

  getAllProducts() {
    return this.products;
  }

  getProductById(id) {
    return this.products.find(p => p.id === id);
  }

  getProductsByCategory(category) {
    return this.products.filter(p => p.category === category);
  }

  searchProducts(term) {
    const lowerTerm = term.toLowerCase();
    return this.products.filter(p => 
      p.name.toLowerCase().includes(lowerTerm) ||
      p.description.toLowerCase().includes(lowerTerm)
    );
  }

  getCategories() {
    return [...new Set(this.products.map(p => p.category))];
  }
}
