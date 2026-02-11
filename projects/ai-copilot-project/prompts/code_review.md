# Prompt: Code Review Automatizado

## Contexto
Sistema de CI/CD precisa validar código Python antes de merge. Integração com GitHub Actions.

## Tarefa
Criar classe AICodeReviewer que:
1. Analisa código Python usando AST (análise estática local)
2. Opcionalmente usa OpenAI API para análise semântica profunda
3. Detecta: segurança, bugs, performance, estilo
4. Retorna estrutura de dados tipada (dataclasses)
5. Gera relatório em Markdown

## Requisitos Específicos
- Fallback gracioso se API não disponível
- Cache de resultados para arquivos não modificados
- Configuração de severidade por regra
- Ignorar padrões (glob patterns) configuráveis

## Formato de Saída
JSON estruturado com:
- line: número da linha
- severity: info/warning/critical
- category: style/security/performance/best_practice
- message: descrição clara
- suggestion: código corrigido (opcional)
