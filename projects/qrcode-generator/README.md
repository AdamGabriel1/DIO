# 📱 Gerador de QR Codes para E-commerce

> Desafio DIO - Node.js: Geração de QR Codes personalizados no terminal

## 🎯 Sobre o Projeto

Ferramenta de linha de comando (CLI) desenvolvida em **Node.js** para gerar QR Codes personalizados para e-commerces. Ideal para criar códigos rápidos para produtos, promoções e campanhas de marketing digital.

### ✨ Funcionalidades

- 🎯 Geração de QR Code a partir de URL
- 🎨 Personalização de cores (fundo e foreground)
- 📏 Múltiplos tamanhos (tamanho do módulo)
- 💾 Salvamento em PNG/SVG
- 📦 Geração em lote via arquivo JSON/CSV
- 🔗 Templates pré-definidos para produtos
- 📋 Cópia automática para área de transferência (opcional)

## 🚀 Como Executar

### Pré-requisitos
- Node.js 16+ instalado
- NPM ou Yarn

### Instalação

```bash
# Clone o repositório
git clone https://github.com/AdamGabriel1/dio-qrcode-generator.git
cd dio-qrcode-generator

# Instale as dependências
npm install

# Execute a CLI
npm start
# ou
node src/index.js
```

## 🎮 Modos de Uso

### Modo Interativo (Padrão)

```bash
npm start
```

Menu interativo no terminal para configurar todas as opções.

### Modo Comando Rápido

```bash
# Geração simples
node src/index.js generate --url "https://minhaloja.com/produto/123" --name "produto-123"

# Com personalização completa
node src/index.js generate \
  --url "https://minhaloja.com/promocao" \
  --name "black-friday" \
  --color "#FF6B00" \
  --bg "#FFFFFF" \
  --size 10 \
  --type png
```

### Geração em Lote

```bash
# Via arquivo JSON
node src/index.js batch --file produtos.json

# Via arquivo CSV
node src/index.js batch --file produtos.csv --output ./campanha-natal/
```

## 📋 Exemplos de Uso

### Exemplo 1: QR Code de Produto

```
========================================
📱 GERADOR DE QR CODE - E-COMMERCE
========================================

🎯 Modo: Geração Única

🔗 Digite a URL do produto: https://shopee.com.br/celular-xyz
🏷️  Digite o nome do arquivo: celular-promo
🎨 Cor do QR Code (hex): #EE4D2D
⬜ Cor de fundo (hex): #FFFFFF
📏 Tamanho (1-10): 8
💾 Formato (png/svg): png

✅ QR Code gerado com sucesso!
📁 Arquivo: ./output/celular-promo.png
📊 Dimensões: 800x800px
🔗 URL: https://shopee.com.br/celular-xyz
```

### Exemplo 2: Geração em Lote

Arquivo `produtos.json`:
```json
[
  {
    "url": "https://loja.com/produto/1",
    "name": "fone-bluetooth",
    "color": "#000000"
  },
  {
    "url": "https://loja.com/produto/2", 
    "name": "mouse-gamer",
    "color": "#FF0000"
  }
]
```

Comando:
```bash
node src/index.js batch --file produtos.json
```

Saída:
```
✅ Processando 2 produtos...

[1/2] ✅ fone-bluetooth.png gerado
[2/2] ✅ mouse-gamer.png gerado

📁 Todos os QR Codes salvos em: ./output/
```

## 🛠️ Opções de Personalização

| Opção | Descrição | Padrão |
|-------|-----------|--------|
| `--url` | URL do produto/página | Obrigatório |
| `--name` | Nome do arquivo de saída | `qrcode` |
| `--color` | Cor dos módulos do QR | `#000000` |
| `--bg` | Cor de fundo | `#FFFFFF` |
| `--size` | Tamanho do módulo (1-10) | `5` |
| `--type` | Formato de saída (png/svg) | `png` |
| `--margin` | Margem em módulos | `4` |
| `--output` | Pasta de saída | `./output/` |

## 🏗️ Estrutura do Código

```
src/
├── index.js              # CLI entry point (menu/comandos)
├── commands/
│   ├── generate.js       # Comando de geração única
│   └── batch.js          # Processamento em lote
├── services/
│   ├── qrService.js      # Integração com biblioteca qrcode
│   └── fileService.js    # Criação de diretórios, validação
├── utils/
│   ├── validator.js      # Validação de URLs e cores hex
│   ├── formatter.js      # Formatação de texto e datas
│   └── logger.js         # Cores e estilos no console
└── templates/
    └── products.js       # URLs de exemplo para teste
```

## 📦 Dependências

| Pacote | Versão | Função |
|--------|--------|--------|
| `qrcode` | ^1.5.3 | Geração dos QR Codes |
| `commander` | ^11.0.0 | CLI framework |
| `inquirer` | ^9.2.0 | Prompts interativos |
| `chalk` | ^5.3.0 | Cores no terminal |
| `clipboardy` | ^4.0.0 | Copiar para clipboard |
| `fs-extra` | ^11.1.0 | Manipulação de arquivos |

## 💡 Casos de Uso

### E-commerce
- QR Codes em embalagens para recompra rápida
- Links diretos para avaliações de produtos
- Acesso rápido a promoções e cupons

### Marketing
- Campanhas offline → online (panfletos, outdoors)
- Cartões de visita digitais
- Menu digital para restaurantes

### Logística
- Rastreamento de pedidos
- Etiquetas de envio
- Inventário rápido

## 🔗 Links Úteis

- [Documentação qrcode](https://www.npmjs.com/package/qrcode)
- [Commander.js](https://github.com/tj/commander.js/)
- [Inquirer.js](https://github.com/SBoudrias/Inquirer.js/)
- [Especificação QR Code](https://www.qrcode.com/en/about/standards.html)

## 👤 Autor

Desenvolvido para o desafio de projeto da **DIO - Formação Node.js**

**Adam Gabriel Garcia de Souza** - [https://www.linkedin.com/in/adam-gabriel-b9479b2a6/] - [https://github.com/AdamGabriel1]

---

> 💡 **Dica**: QR Codes gerados são salvos na pasta `output/` e podem ser usados imediatamente em materiais de marketing.
