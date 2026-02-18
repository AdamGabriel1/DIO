# 🎵 Sistema de Recomendação de Músicas com Grafos

> Desafio DIO - Banco de Dados: Algoritmo de recomendação baseado em Neo4j e análise de grafos

## 🎯 Sobre o Projeto

Sistema completo de recomendação musical utilizando **Neo4j (Graph Database)** para identificar padrões de escuta e sugerir novas faixas. O projeto demonstra como grafos são superiores para sistemas de recomendação comparados a bancos relacionais tradicionais.

### ✨ Funcionalidades do Sistema

- 🎧 **Rastreamento de escutas** com propriedades (timestamp, plays, skip)
- ❤️ **Sistema de likes** para peso em recomendações
- 👥 **Rede social** entre usuários (follows)
- 🎸 **Análise por gênero** para recomendações contextuais
- 🔥 **Trending** baseado em centralidade de grafos
- 🎯 **Recomendações híbridas**: conteúdo + colaborativo + popularidade

## 🏗️ Modelo de Grafo

### Entidades (Nós)

| Entidade | Propriedades | Descrição |
|----------|-------------|-----------|
| **User** | userId, name, age, country, premium | Ouvintes |
| **Song** | songId, title, duration, releaseYear | Músicas |
| **Artist** | artistId, name, genre, popularity | Artistas |
| **Genre** | genreId, name, description | Gêneros musicais |

### Relacionamentos (Arestas)

| Relacionamento | Direção | Propriedades | Significado |
|----------------|---------|--------------|-------------|
| **LISTENED** | User → Song | plays, lastPlayed, skipRate | Histórico de escuta |
| **LIKED** | User → Song | timestamp, rating (1-5) | Curtidas |
| **FOLLOWS** | User → User | since, strength | Rede social |
| **CREATED_BY** | Song → Artist | - | Autoria |
| **BELONGS_TO** | Song → Genre | confidence (0-1) | Classificação |
| **SIMILAR_TO** | Song → Song | score, reason | Similaridade calculada |
| **INFLUENCED_BY** | Artist → Artist | era, style | Influência artística |

## 🚀 Como Executar

### Pré-requisitos
- Neo4j Desktop 5.x+ ou Neo4j Aura (cloud)
- Neo4j Browser para execução de queries

### Instalação

```bash
# Clone o repositório
git clone https://github.com/SEU-USUARIO/dio-music-recommendation-graph.git
cd dio-music-recommendation-graph

# Inicie o Neo4j e crie database: musicdb
# Execute os scripts na ordem numerada no Neo4j Browser
```

### Execução

No Neo4j Browser, execute:
```cypher
:source cypher/01-constraints.cypher
:source cypher/02-nodes-users.cypher
:source cypher/03-nodes-music-artists.cypher
:source cypher/04-relationships.cypher
:source cypher/05-recommendation-queries.cypher
```

## 🎮 Algoritmos de Recomendação

### 1. Recomendação por Gênero Favorito
```cypher
// "Artistas de rock mais ouvidos"
MATCH (u:User {userId: 'user-001'})-[:LISTENED]->(s:Song)-[:BELONGS_TO]->(g:Genre {name: 'Rock'})
MATCH (a:Artist)-[:CREATED_BY]-(rec:Song)-[:BELONGS_TO]->(g)
WHERE NOT (u)-[:LISTENED]->(rec)
RETURN a.name, count(rec) as songs, g.name as genre
ORDER BY songs DESC
```

### 2. Recomendação Colaborativa (User-User)
```cypher
// Usuários com gostos similares
MATCH (u1:User)-[l1:LISTENED]->(s:Song)<-[l2:LISTENED]-(u2:User)
WHERE u1 <> u2 
AND abs(l1.plays - l2.plays) <= 5
WITH u2, count(s) as commonSongs
ORDER BY commonSongs DESC
LIMIT 5
MATCH (u2)-[:LIKED]->(rec:Song)
WHERE NOT (u1)-[:LISTENED]->(rec)
RETURN rec.title, rec.artist
```

### 3. Recomendação por Influência Artística
```cypher
// Artistas que influenciaram os favoritos
MATCH (u:User)-[:LISTENED]->(:Song)-[:CREATED_BY]->(a:Artist)
MATCH (a)-[:INFLUENCED_BY]->(influencer:Artist)
MATCH (influencer)-[:CREATED_BY]-(rec:Song)
WHERE NOT (u)-[:LISTENED]->(rec)
RETURN influencer.name, rec.title
```

## 📊 Métricas de Sucesso

| Métrica | Descrição | Query |
|---------|-----------|-------|
| **Precision@K** | Acerto nas top-K recomendações | `MATCH (u)-[:RECOMMENDED]->(s) WHERE s.liked = true` |
| **Coverage** | % do catálogo recomendado | `count(DISTINCT recommended) / count(DISTINCT allSongs)` |
| **Diversity** | Variedade de gêneros | `avg(collect(DISTINCT genre))` |
| **Novelty** | Quão surpreendente | `1 / avg(popularity of recommendations)` |

## 🛠️ Tecnologias

| Tecnologia | Uso |
|------------|-----|
| Neo4j 5.x | Banco de dados em grafo |
| Cypher | Linguagem de consulta |
| GDS (Graph Data Science) | Algoritmos de centralidade |
| APOC | Procedimentos utilitários |

## 🔗 Links Úteis

- [Neo4j Graph Data Science](https://neo4j.com/docs/graph-data-science/current/)
- [Cypher Cheat Sheet](https://neo4j.com/docs/cypher-cheat-sheet/5/auradb-enterprise/)
- [Graph-Based Recommendation Engines](https://neo4j.com/use-cases/recommendations/)

## 👤 Autor

Desenvolvido para **DIO - Formação Banco de Dados**

**Adam Gabriel Garcia de Souza** - [https://www.linkedin.com/in/adam-gabriel-b9479b2a6/] - [https://github.com/AdamGabriel1]

---

> 💡 **Insight**: Grafos permitem consultas de recomendação em tempo real que seriam impossíveis ou muito lentas em SQL tradicional, especialmente para "amigos de amigos" e caminhos de influência.
