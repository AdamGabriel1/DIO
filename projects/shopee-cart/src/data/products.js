/**
 * Base de dados simulada de produtos
 * Catálogo estilo Shopee
 */

import { Product } from '../models/Product.js';

export const products = [
  new Product(1, 'Fone de Ouvido Bluetooth TWS', 79.90, 15, 'Eletrônicos', 
    'Fone sem fio com qualidade de som premium, bateria de longa duração e touch control', 4.8, 1250),
  
  new Product(2, 'Mouse Gamer RGB 7200DPI', 129.90, 8, 'Eletrônicos', 
    'Mouse óptico profissional com 7 botões programáveis e iluminação RGB ajustável', 4.5, 890),
  
  new Product(3, 'Teclado Mecânico Switch Blue', 249.90, 5, 'Eletrônicos', 
    'Teclado gamer com switches mecânicos, anti-ghosting e keycaps double-shot', 4.7, 650),
  
  new Product(4, 'Webcam Full HD 1080p', 189.90, 12, 'Eletrônicos', 
    'Webcam com microfone estéreo, autofoco e correção de luz para videochamadas', 4.6, 2100),
  
  new Product(5, 'Camiseta Estampada Algodão', 39.90, 50, 'Moda', 
    'Camiseta 100% algodão com estampas exclusivas, disponível em vários tamanhos', 4.4, 3200),
  
  new Product(6, 'Tênis Esportivo Running', 159.90, 20, 'Moda', 
    'Tênis leve e confortável para corrida, com solado antiderrapante e respirável', 4.5, 1800),
  
  new Product(7, 'Mochila Laptop Impermeável', 89.90, 25, 'Acessórios', 
    'Mochila com compartimento acolchoado para notebook até 15.6" e múltiplos bolsos', 4.7, 950),
  
  new Product(8, 'Garrafa Térmica Inox 500ml', 45.90, 30, 'Casa', 
    'Garrafa térmica com parede dupla, mantém bebidas quentes por 12h ou frias por 24h', 4.8, 2800),
  
  new Product(9, 'Luminária LED de Mesa', 59.90, 18, 'Casa', 
    'Luminária articulada com 3 níveis de brilho e carregador USB integrado', 4.3, 750),
  
  new Product(10, 'Cabo USB-C Reforçado 2m', 29.90, 100, 'Eletrônicos', 
    'Cabo de carregamento rápido 3A com trançado de nylon e conectores reforçados', 4.6, 4500),
  
  new Product(11, 'Power Bank 20000mAh', 119.90, 10, 'Eletrônicos', 
    'Carregador portátil com 2 saídas USB, display LED e carregamento rápido', 4.5, 1300),
  
  new Product(12, 'Suporte Celular Mesa Ajustável', 24.90, 40, 'Acessórios', 
    'Suporte metálico articulado para smartphone, ideal para videochamadas', 4.4, 2100),
  
  new Product(13, 'Fone Gamer Headset 7.1', 199.90, 6, 'Eletrônicos', 
    'Headset com som surround virtual, microfone retrátil e almofadas de espuma', 4.7, 580),
  
  new Product(14, 'Mousepad Grande 80x30cm', 34.90, 35, 'Eletrônicos', 
    'Mousepad estendido com base antiderrapante e superfície otimizada para precisão', 4.5, 1600),
  
  new Product(15, 'Capinha iPhone Silicone', 19.90, 60, 'Acessórios', 
    'Capa protetora em silicone premium, forro de microfibra e bordas elevadas', 4.2, 3900)
];
