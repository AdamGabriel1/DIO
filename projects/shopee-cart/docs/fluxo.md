# Fluxo de Compra - Documentação

## Diagrama de Estados do Carrinho

```
[EMPTY] → (add item) → [WITH_ITEMS] → (add/remove/update) → [WITH_ITEMS]
   ↓                           ↓
(checkout)                  (checkout)
   ↓                           ↓
[CLEARED] ←─────────────── [CONFIRMED]
```

## Regras de Negócio Detalhadas

### 1. Adição de Itens
- Verificar disponibilidade em estoque
- Se item já existe: incrementar quantidade
- Se novo item: criar CartItem
- Recalcular subtotais automaticamente

### 2. Remoção de Itens
- Índice baseado em 1 para usuário (interno 0-based)
- Remoção física do array
- Recálculo automático de totais

### 3. Atualização de Quantidade
- Validação: quantidade > 0
- Se quantidade = 0: remover item
- Verificação de estoque antes de confirmar

### 4. Cálculo de Frete
| Região | Multiplicador | Exemplo (base R$15) |
|--------|--------------|---------------------|
| Sudeste | 1.0x | R$ 15,00 |
| Sul | 1.3x | R$ 19,50 |
| Centro-Oeste | 1.4x | R$ 21,00 |
| Nordeste | 1.5x | R$ 22,50 |
| Norte | 1.8x | R$ 27,00 |

- Frete grátis: compras >= R$ 199 ou cupom FRETEGRATIS

### 5. Sistema de Cupons
- Não cumulativos (apenas 1 ativo)
- Prioridade: maior desconto válido
- Validações:
  - Existência do cupom
  - Valor mínimo de compra
  - Não duplicidade

### 6. Limites do Sistema
- Máximo 50 favoritos por usuário
- Estoque não pode ficar negativo
- Quantidade mínima: 1 unidade
- Preço mínimo: R$ 0,01

## Casos de Uso

### UC1: Adicionar ao Carrinho
1. Usuário seleciona produto do catálogo
2. Sistema verifica estoque
3. Usuário informa quantidade
4. Sistema valida quantidade <= estoque
5. Sistema adiciona/atualiza item
6. Sistema exibe confirmação com subtotal

### UC2: Aplicar Cupom
1. Usuário informa código
2. Sistema valida existência
3. Sistema verifica valor mínimo
4. Sistema calcula desconto
5. Sistema atualiza total
6. Sistema exibe resumo atualizado

### UC3: Finalizar Compra
1. Usuário solicita checkout
2. Sistema valida carrinho não vazio
3. Sistema exibe resumo completo
4. Usuário seleciona forma de pagamento
5. Sistema gera número de pedido
6. Sistema limpa carrinho
7. Sistema exibe confirmação
