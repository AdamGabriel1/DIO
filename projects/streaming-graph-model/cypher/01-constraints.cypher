// ============================================
// CONSTRAINTS E ÍNDICES - StreamingDB
// ============================================

// Constraints de unicidade para IDs
CREATE CONSTRAINT user_id_unique IF NOT EXISTS
FOR (u:User) REQUIRE u.userId IS UNIQUE;

CREATE CONSTRAINT user_email_unique IF NOT EXISTS
FOR (u:User) REQUIRE u.email IS UNIQUE;

CREATE CONSTRAINT movie_id_unique IF NOT EXISTS
FOR (m:Movie) REQUIRE m.movieId IS UNIQUE;

CREATE CONSTRAINT series_id_unique IF NOT EXISTS
FOR (s:Series) REQUIRE s.seriesId IS UNIQUE;

CREATE CONSTRAINT genre_id_unique IF NOT EXISTS
FOR (g:Genre) REQUIRE g.genreId IS UNIQUE;

CREATE CONSTRAINT actor_id_unique IF NOT EXISTS
FOR (a:Actor) REQUIRE a.actorId IS UNIQUE;

CREATE CONSTRAINT director_id_unique IF NOT EXISTS
FOR (d:Director) REQUIRE d.directorId IS UNIQUE;

// Índices para performance de busca
CREATE INDEX user_name_index IF NOT EXISTS
FOR (u:User) ON (u.name);

CREATE INDEX movie_title_index IF NOT EXISTS
FOR (m:Movie) ON (m.title);

CREATE INDEX movie_year_index IF NOT EXISTS
FOR (m:Movie) ON (m.releaseYear);

CREATE INDEX actor_name_index IF NOT EXISTS
FOR (a:Actor) ON (a.name);

CREATE INDEX director_name_index IF NOT EXISTS
FOR (d:Director) ON (d.name);

// Verificar constraints criadas
SHOW CONSTRAINTS;

// Verificar índices criados
SHOW INDEXES;
