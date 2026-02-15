# 🎬 Modelagem de Dados em Grafos - Serviço de Streaming

> Desafio DIO - Banco de Dados: Modelagem de grafo para sistema de recomendação

## 🎯 Sobre o Projeto

Modelagem completa de um banco de dados em grafo (Graph Database) para um serviço de streaming, focado em **relacionamentos** para criar um sistema de recomendação poderoso utilizando **Neo4j**.

### ✨ Objetivos

- Modelar entidades como nós (Users, Movies, Series, Genres, Actors, Directors)
- Criar relacionamentos semânticos (WATCHED, ACTED_IN, DIRECTED, IN_GENRE)
- Implementar propriedades em relacionamentos (rating, timestamp)
- Preparar base para algoritmos de recomendação (collaborative filtering)

## 🏗️ Modelo de Dados

### Entidades (Nós)

| Entidade | Propriedades | Descrição |
|----------|-------------|-----------|
| **User** | userId, name, email, birthDate, country | Usuários do serviço |
| **Movie** | movieId, title, releaseYear, duration, rating | Filmes disponíveis |
| **Series** | seriesId, title, releaseYear, seasons, episodes | Séries disponíveis |
| **Genre** | genreId, name, description | Gêneros/categorias |
| **Actor** | actorId, name, birthDate, nationality | Atores |
| **Director** | directorId, name, birthDate, nationality | Diretores |

### Relacionamentos (Arestas)

| Relacionamento | De → Para | Propriedades | Descrição |
|----------------|-----------|--------------|-----------|
| **WATCHED** | User → Movie/Series | rating (1-5), timestamp, progress | Usuário assistiu |
| **ACTED_IN** | Actor → Movie/Series | role, screenTime | Atuação |
| **DIRECTED** | Director → Movie/Series | year | Direção |
| **IN_GENRE** | Movie/Series → Genre | weight | Pertence ao gênero |
| **FOLLOWS** | User → User | since | Rede social |
| **SIMILAR_TO** | Movie → Movie | score | Similaridade de conteúdo |

## 📊 Diagrama do Modelo

```
┌─────────────┐         WATCHED          ┌─────────────┐
│    User     │◄────────────────────────►│    Movie    │
│  (usuário)  │   rating, timestamp      │   (filme)   │
└──────┬──────┘                          └──────┬──────┘
       │                                         │
       │         ┌─────────────┐                 │
       │         │    Genre    │◄────────────────┘
       │         │   (gênero)  │    IN_GENRE
       │         └─────────────┘
       │
       │    ┌─────────────┐         ACTED_IN
       └───►│    Actor    │◄─────────────────────┐
            │   (ator)    │   role, screenTime   │
            └─────────────┘                      │
                                                 │
            ┌─────────────┐         DIRECTED     │
            │  Director   │◄─────────────────────┘
            │ (diretor)   │
            └─────────────┘
```

## 🚀 Como Executar

### Pré-requisitos
- Neo4j Desktop ou Neo4j Aura (cloud)
- Neo4j Browser ou Neo4j Bloom

### Instalação

1. **Inicie o Neo4j** e crie um novo database: `streamingdb`

2. **Execute os scripts Cypher** na ordem:
   ```cypher
   :source cypher/01-constraints.cypher
   :source cypher/02-nodes.cypher
   :source cypher/03-relationships.cypher
   ```

3. **Teste as consultas**:
   ```cypher
   :source cypher/04-queries-examples.cypher
   ```

## 🎮 Consultas de Exemplo

### Recomendação por Gênero
```cypher
// Filmes do mesmo gênero que o usuário assistiu
MATCH (u:User {userId: 'user-001'})-[w:WATCHED]->(m:Movie)-[:IN_GENRE]->(g:Genre)<-[:IN_GENRE]-(rec:Movie)
WHERE NOT (u)-[:WATCHED]->(rec)
RETURN rec.title, g.name, count(*) as score
ORDER BY score DESC
LIMIT 5
```

### Recomendação Colaborativa
```cypher
// Usuários com gostos similares
MATCH (u1:User {userId: 'user-001'})-[w1:WATCHED]->(m:Movie)<-[w2:WATCHED]-(u2:User)
WHERE u1 <> u2 AND abs(w1.rating - w2.rating) <= 1
WITH u2, count(m) as commonMovies
ORDER BY commonMovies DESC
LIMIT 5
MATCH (u2)-[w:WATCHED]->(rec:Movie)
WHERE w.rating >= 4
AND NOT (u1)-[:WATCHED]->(rec)
RETURN rec.title, avg(w.rating) as predictedRating
ORDER BY predictedRating DESC
```

### Atores mais Populares
```cypher
MATCH (a:Actor)-[:ACTED_IN]->(m:Movie)<-[w:WATCHED]-(u:User)
RETURN a.name, count(DISTINCT u) as popularity, collect(DISTINCT m.title)[0..3] as topMovies
ORDER BY popularity DESC
LIMIT 10
```

## 🛠️ Ferramentas Utilizadas

| Ferramenta | Uso |
|------------|-----|
| **Neo4j** | Banco de dados em grafo |
| **Neo4j Browser** | Execução de queries Cypher |
| **arrows.app** | Modelagem visual do grafo |
| **dbdiagram.io** | Diagrama ER complementar |

## 📁 Arquivos

```
cypher/
├── 01-constraints.cypher      # Constraints UNIQUE e índices
├── 02-nodes.cypher            # 10 usuários, 10 filmes/séries, gêneros, atores, diretores
├── 03-relationships.cypher    # Todos os relacionamentos
└── 04-queries-examples.cypher # Consultas analíticas e recomendações
```

## 🔗 Links Úteis

- [Neo4j Documentation](https://neo4j.com/docs/)
- [Cypher Query Language](https://neo4j.com/docs/cypher-manual/current/)
- [Graph Data Modeling](https://neo4j.com/docs/getting-started/current/data-modeling/)
- [arrows.app](https://arrows.app) - Ferramenta de modelagem visual

## 👤 Autor

Desenvolvido para **DIO - Formação Banco de Dados**

**Adam Gabriel Garcia de Souza** - [https://www.linkedin.com/in/adam-gabriel-b9479b2a6/] - [https://github.com/AdamGabriel1]

---

> 💡 **Dica**: Este modelo está preparado para algoritmos de Graph Data Science como Node Similarity e PageRank para recomendações avançadas.
