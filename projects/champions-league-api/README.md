# ⚽ Champions League API

> Desafio DIO - Node.js + Express: API completa da UEFA Champions League

## 🎯 Sobre o Projeto

API REST desenvolvida com **Node.js** e **Express** para gerenciamento de dados da Champions League, incluindo equipes, jogadores, partidas e classificações de grupos.

### ✨ Funcionalidades

- 🏟️ CRUD de Equipes (clubes participantes)
- 👤 CRUD de Jogadores por equipe
- ⚽ CRUD de Partidas e resultados
- 📊 Classificação automática de grupos
- 🔍 Filtros por grupo, temporada, rodada
- 🏆 Estatísticas de artilheiros

## 🚀 Como Executar

### Pré-requisitos
- Node.js 18+
- NPM

### Instalação

```bash
# Clone
git clone https://github.com/AdamGabriel1/dio-champions-league-api.git
cd dio-champions-league-api

# Instale dependências
npm install

# Execute
npm start

# Modo desenvolvimento (nodemon)
npm run dev
```

## 🎮 Endpoints

### Equipes
| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | `/teams` | Listar equipes |
| GET | `/teams/:id` | Buscar equipe |
| GET | `/teams/:id/players` | Jogadores da equipe |
| POST | `/teams` | Criar equipe |
| PUT | `/teams/:id` | Atualizar equipe |
| DELETE | `/teams/:id` | Remover equipe |

### Jogadores
| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | `/players` | Listar jogadores |
| GET | `/players/:id` | Buscar jogador |
| GET | `/players/topscorers` | Artilheiros |
| POST | `/players` | Criar jogador |
| PUT | `/players/:id` | Atualizar jogador |
| DELETE | `/players/:id` | Remover jogador |

### Partidas
| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | `/matches` | Listar partidas |
| GET | `/matches?group=A` | Filtrar por grupo |
| GET | `/matches?matchday=1` | Filtrar por rodada |
| POST | `/matches` | Criar partida |
| PUT | `/matches/:id` | Atualizar resultado |
| DELETE | `/matches/:id` | Remover partida |

### Classificação
| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | `/standings` | Todas classificações |
| GET | `/standings?group=A` | Classificação grupo A |

## 📋 Exemplos

### Criar Equipe
```bash
curl -X POST http://localhost:3000/teams \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Real Madrid",
    "country": "Spain",
    "group": "A",
    "stadium": "Santiago Bernabéu"
  }'
```

### Registrar Partida
```bash
curl -X POST http://localhost:3000/matches \
  -H "Content-Type: application/json" \
  -d '{
    "homeTeamId": "real-madrid",
    "awayTeamId": "bayern",
    "matchday": 1,
    "group": "A",
    "date": "2024-09-17"
  }'
```

### Atualizar Resultado
```bash
curl -X PUT http://localhost:3000/matches/match-001 \
  -H "Content-Type: application/json" \
  -d '{
    "homeScore": 2,
    "awayScore": 1,
    "scorers": [
      {"playerId": "player-1", "goals": 2}
    ]
  }'
```

### Ver Classificação
```bash
curl "http://localhost:3000/standings?group=A"
```

## 🏗️ Arquitetura

```
Request → Routes → Controller → Service → Models (memória)
                ↓
         Response ← Middleware
```

## 🛠️ Tecnologias

| Tecnologia | Uso |
|------------|-----|
| Express | Framework web |
| Node.js | Runtime |
| UUID | Geração de IDs |
| Morgan | Logger HTTP |

## 🔗 Links

- [Express Docs](https://expressjs.com/)
- [Repositório Original DIO](https://github.com/digitalinnovationone/nodejs-express-api)

## 👤 Autor

- **Adam Gabriel Garcia de Souza**

Desenvolvido para **DIO - Formação Node.js**
