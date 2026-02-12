# Guia de Uso Avançado

## Formato de Arquivos para Lote

### JSON
```json
[
  {
    "url": "https://loja.com/produto/1",
    "name": "produto-1",
    "color": "#FF0000",
    "bg": "#FFFFFF",
    "size": "6"
  }
]
```

### CSV
```csv
url,name,color,bg,size
https://loja.com/p1,produto-1,#000000,#FFFFFF,5
https://loja.com/p2,produto-2,#FF0000,#FFFFFF,6
```

## Integração com E-commerce

### Exemplo: Gerar QR para todos os produtos de uma API

```javascript
// fetch-products.js
import fs from 'fs-extra';

const response = await fetch('https://api.sualoja.com/products');
const products = await response.json();

const qrData = products.map(p => ({
  url: `https://sualoja.com/produto/${p.id}`,
  name: p.slug,
  color: p.category === 'promo' ? '#FF0000' : '#000000'
}));

await fs.writeJson('produtos.json', qrData);
console.log('Arquivo gerado! Execute: npm run batch -- --file produtos.json');
```

## Dicas de Design

| Cenário | Cor QR | Cor Fundo | Tamanho |
|---------|--------|-----------|---------|
| Impressão escura | #FFFFFF | #000000 | 8-10 |
| Cartões de visita | #000000 | #FFFFFF | 4-5 |
| Display digital | #EE4D2D | #FFFFFF | 6-8 |
| Embalagens | #000000 | transparente | 5-7 |
