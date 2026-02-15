# Documentação do Modelo de Grafo

## Arquitetura do Grafo

### Nós (Nodes)

#### User
```cypher
(:User {
  userId: string,      // UUID único
  name: string,        // Nome completo
  email: string,       // E-mail (único)
  birthDate: date,     // Data de nascimento
  country: string,     // País
  createdAt: datetime  // Data de registro
})
```

#### Movie
```cypher
(:Movie {
  movieId: string,     // UUID único
  title: string,       // Título do filme
  releaseYear: integer,// Ano de lançamento
  duration: integer,   // Duração em minutos
  rating: float,       // Classificação média
  synopsis: string     // Sinopse
})
```

#### Series
```cypher
(:Series {
  seriesId: string,    // UUID único
  title: string,       // Título da série
  releaseYear: integer,// Ano de estreia
  seasons: integer,    // Número de temporadas
  episodes: integer,   // Total de episódios
  status: string       // ongoing, completed, cancelled
})
```

#### Genre
```cypher
(:Genre {
  genreId: string,     // Código do gênero
  name: string,        // Nome (Ação, Drama, etc)
  description: string  // Descrição

#### Actor
```cypher
(:Actor {
  actorId: string,     // UUID único
  name: string,        // Nome artístico
  birthDate: date,     // Data de nascimento
  nationality: string  // Nacionalidade
})
```

#### Director
```cypher
(:Director {
  directorId: string,  // UUID único
  name: string,        // Nome completo
  birthDate: date,     // Data de nascimento
  nationality: string  // Nacionalidade
})
```

### Relacionamentos (Relationships)

#### WATCHED
```cypher
(u:User)-[w:WATCHED {
  rating: integer,     // 1-5 estrelas
  timestamp: datetime, // Quando assistiu
  progress: integer,   // % assistido (0-100)
  device: string       // mobile, tv, web
}]->(m:Movie|Series)
```

#### ACTED_IN
```cypher
(a:Actor)-[r:ACTED_IN {
  role: string,        // Nome do personagem
  screenTime: integer, // Tempo em tela (min)
  isMainCast: boolean  // Elenco principal?
}]->(m:Movie|Series)
```

#### DIRECTED
```cypher
(d:Director)-[r:DIRECTED {
  year: integer        // Ano da direção
}]->(m:Movie|Series)
```

#### IN_GENRE
```cypher
(m:Movie|Series)-[r:IN_GENRE {
  weight: float        // Relevância do gênero (0.0-1.0)
}]->(g:Genre)
```

#### FOLLOWS (Rede social)
```cypher
(u1:User)-[r:FOLLOWS {
  since: datetime      // Desde quando segue
}]->(u2:User)
```

## Padrões de Consulta (Design Patterns)

### 1. Recomendação Baseada em Conteúdo
```cypher
MATCH (target:Movie {movieId: $id})-[:IN_GENRE]->(g:Genre)<-[:IN_GENRE]-(similar:Movie)
WITH similar, count(g) as commonGenres
ORDER BY commonGenres DESC
RETURN similar
```

### 2. Recomendação Colaborativa (User-User)
```cypher
MATCH (u:User {userId: $userId})-[w1:WATCHED]->(m:Movie)<-[w2:WATCHED]-(other:User)
WITH other, avg(abs(w1.rating - w2.rating)) as similarity
ORDER BY similarity
LIMIT 10
```

### 3. Caminhos de Influência (Actor-Director)
```cypher
MATCH path = (a:Actor)-[:ACTED_IN]->(m:Movie)<-[:DIRECTED]-(d:Director)
WHERE a.name = $actorName
RETURN path
```

## Otimizações

### Índices Recomendados
```cypher
CREATE INDEX user_email FOR (u:User) ON (u.email);
CREATE INDEX movie_title FOR (m:Movie) ON (m.title);
CREATE INDEX movie_year FOR (m:Movie) ON (m.releaseYear);
CREATE INDEX genre_name FOR (g:Genre) ON (g.name);
```

### Constraints de Integridade
```cypher
CREATE CONSTRAINT user_id_unique FOR (u:User) REQUIRE u.userId IS UNIQUE;
CREATE CONSTRAINT movie_id_unique FOR (m:Movie) REQUIRE m.movieId IS UNIQUE;
CREATE CONSTRAINT genre_id_unique FOR (g:Genre) REQUIRE g.genreId IS UNIQUE;
```
