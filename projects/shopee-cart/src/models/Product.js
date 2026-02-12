/**
 * Modelo de Produto
 * Representa um item do catálogo
 */

export class Product {
  constructor(id, name, price, stock, category, description, rating = 5.0, sales = 0) {
    this.id = id;
    this.name = name;
    this.price = parseFloat(price);
    this.stock = parseInt(stock);
    this.category = category;
    this.description = description;
    this.rating = parseFloat(rating);
    this.sales = parseInt(sales);
    this.createdAt = new Date();
  }

  isAvailable(quantity = 1) {
    return this.stock >= quantity;
  }

  decreaseStock(quantity) {
    if (this.isAvailable(quantity)) {
      this.stock -= quantity;
      return true;
    }
    return false;
  }

  increaseStock(quantity) {
    this.stock += quantity;
  }

  toString() {
    return `${this.name} - R$ ${this.price.toFixed(2)}`;
  }
}
