# 🛒 Sistema de Carrinho de Compras - Shopee Style

> Desafio DIO - Node.js: Sistema completo de e-commerce no terminal

## 🎯 Sobre o Projeto

Sistema de carrinho de compras desenvolvido em **Node.js** puro, executado 100% no terminal. Simula a experiência de compra da Shopee com:

- Catálogo de produtos com variações
- Carrinho com adição, remoção e alteração de quantidades
- Cálculos automáticos de subtotais, frete e totais
- Cupons de desconto
- Sistema de favoritos
- Resumo de compra antes da finalização

## 🚀 Como Executar

### Pré-requisitos
- Node.js 16+ instalado
- Terminal/Console

### Instalação

```bash
# Clone o repositório
git clone https://github.com/AdamGabriel1/dio-shopee-cart.git
cd dio-shopee-cart

# Execute o sistema
npm start
# ou
node src/index.js
```

## 📋 Funcionalidades

### 🏪 Catálogo de Produtos
- Listagem de produtos com nome, preço, estoque
- Categorias (Eletrônicos, Moda, Casa, etc.)
- Variações (tamanho, cor)
- Avaliações e vendas simuladas

### 🛒 Gerenciamento do Carrinho
- Adicionar produtos ao carrinho
- Remover produtos específicos
- Alterar quantidades (aumentar/diminuir)
- Visualizar resumo do carrinho
- Esvaziar carrinho

### 💰 Cálculos Automáticos
- Subtotal por produto (preço × quantidade)
- Total do carrinho
- Frete calculado por região
- Descontos por cupom
- Taxas de serviço

### 🎟️ Sistema de Cupons
- `SHOPEE10` - 10% de desconto
- `FRETEGRATIS` - Frete grátis
- `PRIMEIRACOMPRA` - R$ 20 off

## 🎮 Menu de Navegação

```
========================================
🛒  SHOPEE CART - TERMINAL EDITION
========================================

1. 📦 Ver catálogo de produtos
2. ➕ Adicionar produto ao carrinho
3. 🗑️ Remover produto do carrinho
4. 📝 Alterar quantidade
5. 🛒 Ver meu carrinho
6. 💝 Ver favoritos
7. 🎟️ Aplicar cupom de desconto
8. 💳 Finalizar compra
9. ❌ Sair

Escolha uma opção: _
```

## 🏗️ Estrutura do Código

```
src/
├── index.js              # Menu principal e fluxo de navegação
├── models/
│   ├── Product.js        # Classe Produto (dados e validações)
│   └── Cart.js           # Classe Carrinho (regras de negócio)
├── services/
│   ├── ProductService.js # Busca, filtros, catálogo
│   └── CartService.js    # Operações do carrinho
├── utils/
│   ├── formatter.js      # Formatação BRL, datas, texto
│   └── logger.js         # Cores e formatação de console
└── data/
    └── products.js       # Base de dados simulada (20+ produtos)
```

## 💡 Exemplo de Uso

```bash
$ npm start

========================================
🛒  SHOPEE CART - TERMINAL EDITION
========================================

1. 📦 Ver catálogo de produtos
...

Escolha uma opção: 1

📦 CATÁLOGO DE PRODUTOS

[1] Fone de Ouvido Bluetooth - R$ 79,90
    ⭐ 4.8 | 🛍️ 1.2k vendidos | 📦 Estoque: 15
[2] Mouse Gamer RGB - R$ 129,90
    ⭐ 4.5 | 🛍️ 890 vendidos | 📦 Estoque: 8
...

Escolha uma opção: 2

➕ ADICIONAR AO CARRINHO

Digite o ID do produto: 1
Quantidade: 2

✅ Adicionado: 2x Fone de Ouvido Bluetooth
Subtotal: R$ 159,80

Escolha uma opção: 5

🛒 MEU CARRINHO

Itens:
1. Fone de Ouvido Bluetooth
   2 un x R$ 79,90 = R$ 159,80

Resumo:
Subtotal:     R$ 159,80
Frete:        R$ 15,00 (Sudeste)
Desconto:     -R$ 0,00
TOTAL:        R$ 174,80
```

## 🛠️ Tecnologias

- **Node.js** - Runtime JavaScript
- **readline** - Interface de linha de comando nativa
- **Módulos ES6** - Import/Export
- **Classes ES6** - Modelagem de dados

## 📊 Regras de Negócio Implementadas

| Regra | Descrição |
|-------|-----------|
| Estoque | Não permite adicionar além do estoque disponível |
| Frete | Calculado por região (Sudeste: R$15, Sul: R$20, etc.) |
| Desconto | Cupons não cumulativos, maior benefício prevalece |
| Mínimo | Frete grátis em compras acima de R$ 199 |
| Favoritos | Limite de 50 itens, persistência em memória |

## 🔗 Links Úteis

- [Documentação Node.js readline](https://nodejs.org/api/readline.html)
- [Métodos de Array MDN](https://developer.mozilla.org/pt-BR/docs/Web/JavaScript/Reference/Global_Objects/Array)
- [Intl.NumberFormat](https://developer.mozilla.org/pt-BR/docs/Web/JavaScript/Reference/Global_Objects/Intl/NumberFormat)

## 👤 Autor

Desenvolvido para o desafio de projeto da **DIO - Formação Node.js**

**Adam Gabriel Garcia de Souza** - [https://www.linkedin.com/in/adam-gabriel-b9479b2a6/] - [https://github.com/AdamGabriel1]

---

> 💡 **Dica**: Este projeto demonstra lógica de negócio complexa, manipulação de dados e interação via console - fundamentais para backend development.
