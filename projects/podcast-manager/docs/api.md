# Documentação da API Podcast Manager

## Base URL
```
http://localhost:3333
```

## Endpoints

### GET /api/podcasts
Retorna todos os podcasts cadastrados.

**Resposta (200 OK):**
```json
{
  "statusCode": 200,
  "body": [
    {
      "id": "pod-001",
      "name": "PodDev",
      "description": "...",
      "category": "tecnologia",
      "episodes": [...],
      "createdAt": "2024-01-01T00:00:00Z",
      "updatedAt": "2024-01-22T10:00:00Z"
    }
  ]
}
```

### GET /api/episodes
Retorna episódios (todos ou filtrados por categoria).

**Query Params:**
- `category` (opcional): Filtra por categoria do podcast

**Exemplo:** `/api/episodes?category=tecnologia`

**Resposta (200 OK):**
```json
{
  "statusCode": 200,
  "body": {
    "episodes": [...],
    "meta": {
      "total": 2,
      "category": "tecnologia",
      "totalDuration": 6300
    }
  }
}
```

### POST /api/podcasts
Cria um novo podcast.

**Body:**
```json
{
  "name": "Meu Podcast",
  "description": "Descrição do podcast...",
  "category": "educacao",
  "episodes": []
}
```

**Resposta (201 Created):**
```json
{
  "statusCode": 201,
  "body": {
    "id": "pod-xxx",
    "name": "Meu Podcast",
    ...
  }
}
```

### PUT /api/podcasts/:id
Atualiza um podcast existente.

**Body:** (todos opcionais)
```json
{
  "name": "Novo Nome",
  "description": "Nova descrição",
  "category": "entretenimento"
}
```

**Resposta (200 OK):** Podcast atualizado

### DELETE /api/podcasts/:id
Remove um podcast.

**Resposta (204 No Content):** Sem body

## Categorias Válidas
- tecnologia
- educacao
- negocios
- entretenimento
- saude
- esportes
- outros
