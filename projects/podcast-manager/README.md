# 🎙️ Podcast Manager API

> Desafio DIO - Node.js + TypeScript: API de gerenciamento de podcasts sem frameworks

## 🎯 Sobre o Projeto

API REST desenvolvida em **Node.js** com **TypeScript** para gerenciamento de podcasts, utilizando apenas módulos nativos do Node.js (sem Express, Fastify, etc.). O projeto demonstra como construir uma API robusta do zero, compreendendo fundamentos HTTP.

### ✨ Funcionalidades

- 🎙️ CRUD completo de podcasts
- 🔍 Filtro por categoria (episódios)
- 📊 Listagem com metadados (duração total, quantidade)
- 🏷️ Filtros por nome e categoria
- 📄 Resposta em JSON padronizada
- 🗄️ Persistência em arquivo JSON

## 🚀 Como Executar

### Pré-requisitos
- Node.js 18+ instalado
- NPM ou Yarn

### Instalação

```bash
# Clone o repositório
git clone https://github.com/AdamGabriel1/dio-podcast-manager.git
cd dio-podcast-manager

# Instale as dependências
npm install

# Execute em desenvolvimento
npm run dev

# Ou compile e execute
npm run build
npm start
```

## 🎮 Endpoints da API

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | `/api/podcasts` | Listar todos os podcasts |
| GET | `/api/episodes` | Listar todos os episódios |
| GET | `/api/episodes?category=tecnologia` | Filtrar por categoria |
| POST | `/api/podcasts` | Criar novo podcast |
| PUT | `/api/podcasts/:id` | Atualizar podcast |
| DELETE | `/api/podcasts/:id` | Remover podcast |

## 📋 Exemplos de Uso

### Listar Podcasts
```bash
curl http://localhost:3333/api/podcasts
```

**Resposta:**
```json
{
  "statusCode": 200,
  "body": [
    {
      "id": "pod-001",
      "name": "Podcast Dev",
      "description": "Tecnologia e programação",
      "category": "tecnologia",
      "episodes": [
        {
          "id": "ep-001",
          "name": "Introdução ao TypeScript",
          "duration": 3600,
          "videoUrl": "https://youtube.com/..."
        }
      ]
    }
  ]
}
```

### Filtrar por Categoria
```bash
curl "http://localhost:3333/api/episodes?category=tecnologia"
```

### Criar Podcast
```bash
curl -X POST http://localhost:3333/api/podcasts \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Novo Podcast",
    "description": "Descrição aqui",
    "category": "educacao",
    "episodes": []
  }'
```

## 🏗️ Arquitetura

```
src/
├── server.ts              # Servidor HTTP nativo
├── routes.ts              # Roteador de requisições
├── controllers/           # Handlers dos endpoints
├── services/              # Regras de negócio
├── repositories/          # Acesso a dados (JSON)
├── models/                # Interfaces TypeScript
└── utils/                 # Helpers HTTP
```

### Fluxo da Requisição

```
Request → server.ts → routes.ts → controller → service → repository → JSON
                                            ↓
Response ← JSON ← utils/httpHelpers ← controller ← service ← repository
```

## 🛠️ Tecnologias

| Tecnologia | Versão | Uso |
|------------|--------|-----|
| Node.js | 18+ | Runtime |
| TypeScript | 5.x | Tipagem estática |
| `http` | nativo | Servidor web |
| `fs/promises` | nativo | Persistência JSON |
| ts-node-dev | dev | Hot reload |

## 📊 Estrutura de Dados

### Podcast
```typescript
interface Podcast {
  id: string;
  name: string;
  description: string;
  category: string;
  episodes: Episode[];
  createdAt: Date;
  updatedAt: Date;
}
```

### Episode
```typescript
interface Episode {
  id: string;
  name: string;
  duration: number; // segundos
  videoUrl: string;
  podcastId: string;
}
```

## 🔗 Links Úteis

- [Documentação Node.js HTTP](https://nodejs.org/api/http.html)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/)
- [REST API Best Practices](https://restfulapi.net/)

## 👤 Autor

Desenvolvido para o desafio de projeto da **DIO - Formação Node.js**

**[Adam Gabriel Garcia de Souza]** - [https://www.linkedin.com/in/adam-gabriel-b9479b2a6/] - [https://github.com/AdamGabriel1]

---

> 💡 **Nota**: Este projeto demonstra fundamentos de HTTP, rotas e arquitetura limpa sem abstrações de frameworks.
