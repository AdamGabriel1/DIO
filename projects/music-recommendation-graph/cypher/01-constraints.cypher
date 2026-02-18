// ============================================
// CONSTRAINTS - Sistema de Recomendação Musical
// ============================================

// Constraints de unicidade
CREATE CONSTRAINT user_id_unique IF NOT EXISTS
FOR (u:User) REQUIRE u.userId IS UNIQUE;

CREATE CONSTRAINT user_email_unique IF NOT EXISTS
FOR (u:User) REQUIRE u.email IS UNIQUE;

CREATE CONSTRAINT song_id_unique IF NOT EXISTS
FOR (s:Song) REQUIRE s.songId IS UNIQUE;

CREATE CONSTRAINT artist_id_unique IF NOT EXISTS
FOR (a:Artist) REQUIRE a.artistId IS UNIQUE;

CREATE CONSTRAINT genre_id_unique IF NOT EXISTS
FOR (g:Genre) REQUIRE g.genreId IS UNIQUE;

// Índices para performance
CREATE INDEX user_name_index IF NOT EXISTS
FOR (u:User) ON (u.name);

CREATE INDEX song_title_index IF NOT EXISTS
FOR (s:Song) ON (s.title);

CREATE INDEX artist_name_index IF NOT EXISTS
FOR (a:Artist) ON (a.name);

CREATE INDEX genre_name_index IF NOT EXISTS
FOR (g:Genre) ON (g.name);

// Índice composto para queries temporais
CREATE INDEX listened_timestamp IF NOT EXISTS
FOR ()-[l:LISTENED]-() ON (l.lastPlayed);

SHOW CONSTRAINTS;
SHOW INDEXES;
