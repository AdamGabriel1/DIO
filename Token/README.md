# Custom Token (CTK) - ERC-20 Token Contract

Este é um contrato básico de token ERC-20 chamado Custom Token (CTK). Ele segue o padrão ERC-20 e inclui funcionalidades adicionais como queima (burn) e criação (mint) de tokens.

## Detalhes do Token

- **Nome:** Custom Token
- **Símbolo:** CTK
- **Decimais:** 18
- **Fornecimento Inicial:** 1.000.000 CTK

## Funções Principais

### Transferência de Tokens

function transfer(address to, uint tokens) external returns (bool success);

Permite a transferência de tokens para outro endereço.

### Aprovação de Gastos

solidity
function approve(address spender, uint tokens) external returns (bool success);

Permite que um endereço gaste tokens em seu nome.

### Transferência Aprovada

function transferFrom(address from, address to, uint tokens) external returns (bool success);

Permite que um endereço gaste tokens em nome de outro, com base em aprovação prévia.

### Queima de Tokens

function burn(uint256 tokens) external returns (bool success);

Permite a queima (destruição) de tokens, reduzindo o fornecimento total.

### Criação de Novos Tokens

function mint(address to, uint256 tokens) external returns (bool success);

Permite a criação de novos tokens e atribui ao endereço especificado.

## Deploy e Testes

1. Clone este repositório.
2. Configure sua IDE (por exemplo, Remix) para interagir com o contrato.
3. Deploy o contrato na rede de teste para verificar seu funcionamento.
4. Execute testes adicionais conforme necessário.

## Contribuição

Sinta-se à vontade para contribuir ou abrir problemas (issues) neste repositório.
