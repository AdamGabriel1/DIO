# 📱 Social Network Analysis - Graph Database

> Desafio DIO - Banco de Dados: Análise de mídias sociais com Neo4j

## 🎯 Sobre o Projeto

Sistema completo de análise de redes sociais utilizando **Neo4j (Graph Database)** para fornecer insights sobre engajamento, conexões entre usuários, popularidade de conteúdo e detecção de comunidades.

### ✨ Funcionalidades do Sistema

- 👥 **Perfis de Usuários** com atributos demográficos e comportamentais
- 📝 **Gestão de Conteúdo** (posts, stories, reels)
- 💬 **Interações** (likes, comments, shares, views)
- 🔗 **Rede de Conexões** (follows, friends, blocks)
- 📊 **Análise de Engajamento** por usuário e conteúdo
- 🕸️ **Detecção de Comunidades** (clustering por interesses)
- ⭐ **Identificação de Influenciadores** (centralidade, PageRank)
- 🔥 **Trending Topics** em tempo real

## 🏗️ Modelo de Grafo

### Entidades (Nós)

| Entidade | Propriedades | Descrição |
|----------|-------------|-----------|
| **User** | userId, username, name, age, location, joinDate, verified | Usuários da plataforma |
| **Post** | postId, content, type, timestamp, likes, shares | Publicações |
| **Comment** | commentId, text, timestamp, likes | Comentários |
| **Hashtag** | tag, category, usageCount | Tags de conteúdo |
| **Topic** | topicId, name, trendingScore | Tópicos de interesse |
| **Location** | locationId, city, country, coordinates | Localizações |

### Relacionamentos (Arestas)

| Relacionamento | Direção | Propriedades | Significado |
|----------------|---------|--------------|-------------|
| **FOLLOWS** | User → User | since, strength | Seguir usuário |
| **FRIENDS_WITH** | User ↔ User | since, interactionCount | Amizade mútua |
| **POSTED** | User → Post | timestamp, device | Criar conteúdo |
| **LIKED** | User → Post/Comment | timestamp, reactionType | Curtir |
| **COMMENTED** | User → Comment | timestamp | Comentar |
| **REPLIED_TO** | Comment → Comment | timestamp | Responder |
| **SHARED** | User → Post | timestamp, platform | Compartilhar |
| **MENTIONS** | Post/Comment → User | - | Mencionar |
| **TAGGED_WITH** | Post → Hashtag | relevance | Hashtags |
| **ABOUT_TOPIC** | Post → Topic | confidence | Tópico do conteúdo |
| **LOCATED_AT** | User/Post → Location | - | Localização |
| **VIEWED** | User → Post | duration, timestamp | Visualização |
| **BLOCKED** | User → User | since, reason | Bloqueio |

## 🎮 Queries de Negócio

### 1. Feed Personalizado
```cypher
// Posts de quem o usuário segue, ordenados por engajamento
MATCH (u:User {userId: 'u001'})-[:FOLLOWS]->(friend:User)-[:POSTED]->(p:Post)
WHERE p.timestamp > datetime() - duration('P7D')
RETURN p.content, friend.name, p.likes + p.shares * 2 as score
ORDER BY score DESC
LIMIT 20
```

### 2. Sugestão de Amigos
```cypher
// Amigos de amigos que ainda não são conectados
MATCH (u:User {userId: 'u001'})-[:FRIENDS_WITH]-(friend)-[:FRIENDS_WITH]-(suggestion)
WHERE u <> suggestion AND NOT (u)-[:FRIENDS_WITH|BLOCKED]-(suggestion)
RETURN suggestion.name, count(friend) as mutualFriends
ORDER BY mutualFriends DESC
```

### 3. Análise de Sentimento por Tópico
```cypher
// Tópicos mais comentados nas últimas 24h
MATCH (p:Post)-[:ABOUT_TOPIC]->(t:Topic)
WHERE p.timestamp > datetime() - duration('PT24H')
RETURN t.name, count(p) as postCount, avg(p.sentimentScore) as avgSentiment
ORDER BY postCount DESC
```

## 📊 Algoritmos Implementados

| Algoritmo | Uso | Cypher |
|-----------|-----|--------|
| **PageRank** | Identificar influenciadores | `gds.pageRank.stream()` |
| **Betweenness** | Encontrar gatekeepers | `gds.betweenness.stream()` |
| **Louvain** | Detecção de comunidades | `gds.louvain.stream()` |
| **Triangle Count** | Medir coesão social | `gds.triangleCount.stream()` |
| **Degree Centrality** | Usuários mais conectados | `gds.degree.stream()` |

## 🛠️ Tecnologias

| Tecnologia | Uso |
|------------|-----|
| Neo4j 5.x | Banco de dados em grafo |
| Cypher | Linguagem de consulta |
| APOC | Procedimentos utilitários |
| GDS | Algoritmos de análise de grafos |

## 🔗 Links Úteis

- [Neo4j Graph Data Science](https://neo4j.com/docs/graph-data-science/current/)
- [Social Network Analysis](https://neo4j.com/use-cases/social-network/)
- [APOC Documentation](https://neo4j.com/docs/apoc/current/)

## 👤 Autor

Desenvolvido para **DIO - Formação Banco de Dados**

**Adam Gabriel Garcia de Souza** - [https://www.linkedin.com/in/adam-gabriel-b9479b2a6/] - [https://github.com/AdamGabriel1]

---

> 💡 **Insight**: Grafos permitem análise de 3º nível (amigos de amigos de amigos) em milissegundos, algo impossível em bancos relacionais para redes grandes.
