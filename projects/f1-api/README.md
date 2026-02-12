# 🏎️ Fórmula 1 API

> Desafio DIO - Node.js + Fastify: API REST para gerenciamento de Fórmula 1

## 🎯 Sobre o Projeto

API REST desenvolvida com **Node.js** e **Fastify** para gerenciamento de dados da Fórmula 1, incluindo pilotos, equipes e corridas. Foco em alta performance e arquitetura limpa.

### ✨ Funcionalidades

- 🏁 CRUD de Pilotos (Drivers)
- 🏎️ CRUD de Equipes (Teams)
- 🏆 CRUD de Corridas (Races)
- 📊 Classificação de pilotos e equipes
- 🔍 Filtros por temporada, equipe, etc.
- ⚡ Alta performance com Fastify

## 🚀 Como Executar

### Pré-requisitos
- Node.js 18+
- NPM ou Yarn

### Instalação

```bash
# Clone
git clone https://github.com/AdamGabriel1/dio-f1-api.git
cd dio-f1-api

# Instale dependências
npm install

# Execute em desenvolvimento
npm run dev

# Ou compile e execute
npm run build
npm start
```

## 🎮 Endpoints

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | `/drivers` | Listar pilotos |
| GET | `/drivers/:id` | Buscar piloto por ID |
| POST | `/drivers` | Criar piloto |
| PUT | `/drivers/:id` | Atualizar piloto |
| DELETE | `/drivers/:id` | Remover piloto |
| GET | `/teams` | Listar equipes |
| GET | `/teams/:id` | Buscar equipe |
| POST | `/teams` | Criar equipe |
| GET | `/races` | Listar corridas |
| POST | `/races` | Criar corrida |
| GET | `/standings/drivers` | Classificação pilotos |
| GET | `/standings/teams` | Classificação equipes |

## 📋 Exemplos

### Criar Piloto
```bash
curl -X POST http://localhost:3000/drivers \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Lewis Hamilton",
    "nationality": "British",
    "teamId": "mercedes",
    "number": 44,
    "points": 0
  }'
```

### Listar com Filtro
```bash
curl "http://localhost:3000/drivers?team=redbull"
```

### Classificação
```bash
curl http://localhost:3000/standings/drivers
```

## 🏗️ Arquitetura

```
Request → Routes → Controller → Service → Database (memória)
                ↓
         Response ← Utils
```

## 🛠️ Tecnologias

| Tecnologia | Uso |
|------------|-----|
| Fastify | Framework web rápido |
| TypeScript | Tipagem estática |
| tsx | Hot reload |
| Zod | Validação de schemas |

## 🔗 Links

- [Fastify Docs](https://www.fastify.io/)
- [Repositório Original DIO](https://github.com/digitalinnovationone/node-formula-1)

## 👤 Autor

- **Adam Gabriel Garcia de Souza**

Desenvolvido para **DIO - Formação Node.js**
