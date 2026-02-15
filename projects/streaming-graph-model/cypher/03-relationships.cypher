// ============================================
// CRIAÇÃO DOS RELACIONAMENTOS
// ============================================

// --------------------------------------------
// RELACIONAMENTOS: IN_GENRE (Filmes/Séries → Gêneros)
// --------------------------------------------
MATCH (m:Movie {movieId: 'movie-001'}), (g:Genre {genreId: 'drama'})
CREATE (m)-[:IN_GENRE {weight: 0.9}]->(g);

MATCH (m:Movie {movieId: 'movie-001'}), (g:Genre {genreId: 'action'})
CREATE (m)-[:IN_GENRE {weight: 0.6}]->(g);

MATCH (m:Movie {movieId: 'movie-002'}), (g:Genre {genreId: 'scifi'})
CREATE (m)-[:IN_GENRE {weight: 0.95}]->(g);

MATCH (m:Movie {movieId: 'movie-002'}), (g:Genre {genreId: 'drama'})
CREATE (m)-[:IN_GENRE {weight: 0.7}]->(g);

MATCH (m:Movie {movieId: 'movie-003'}), (g:Genre {genreId: 'drama'})
CREATE (m)-[:IN_GENRE {weight: 0.8}]->(g);

MATCH (m:Movie {movieId: 'movie-003'}), (g:Genre {genreId: 'thriller'})
CREATE (m)-[:IN_GENRE {weight: 0.9}]->(g);

MATCH (m:Movie {movieId: 'movie-004'}), (g:Genre {genreId: 'thriller'})
CREATE (m)-[:IN_GENRE {weight: 0.8}]->(g);

MATCH (m:Movie {movieId: 'movie-004'}), (g:Genre {genreId: 'action'})
CREATE (m)-[:IN_GENRE {weight: 0.7}]->(g);

MATCH (m:Movie {movieId: 'movie-005'}), (g:Genre {genreId: 'scifi'})
CREATE (m)-[:IN_GENRE {weight: 1.0}]->(g);

MATCH (m:Movie {movieId: 'movie-005'}), (g:Genre {genreId: 'action'})
CREATE (m)-[:IN_GENRE {weight: 0.9}]->(g);

MATCH (m:Movie {movieId: 'movie-006'}), (g:Genre {genreId: 'action'})
CREATE (m)-[:IN_GENRE {weight: 0.9}]->(g);

MATCH (m:Movie {movieId: 'movie-006'}), (g:Genre {genreId: 'drama'})
CREATE (m)-[:IN_GENRE {weight: 0.6}]->(g);

MATCH (s:Series {seriesId: 'series-001'}), (g:Genre {genreId: 'drama'})
CREATE (s)-[:IN_GENRE {weight: 0.95}]->(g);

MATCH (s:Series {seriesId: 'series-001'}), (g:Genre {genreId: 'thriller'})
CREATE (s)-[:IN_GENRE {weight: 0.8}]->(g);

MATCH (s:Series {seriesId: 'series-002'}), (g:Genre {genreId: 'action'})
CREATE (s)-[:IN_GENRE {weight: 0.9}]->(g);

MATCH (s:Series {seriesId: 'series-002'}), (g:Genre {genreId: 'drama'})
CREATE (s)-[:IN_GENRE {weight: 0.85}]->(g);

MATCH (s:Series {seriesId: 'series-003'}), (g:Genre {genreId: 'scifi'})
CREATE (s)-[:IN_GENRE {weight: 0.9}]->(g);

MATCH (s:Series {seriesId: 'series-003'}), (g:Genre {genreId: 'thriller'})
CREATE (s)-[:IN_GENRE {weight: 0.8}]->(g);

MATCH (s:Series {seriesId: 'series-004'}), (g:Genre {genreId: 'drama'})
CREATE (s)-[:IN_GENRE {weight: 0.9}]->(g);

// --------------------------------------------
// RELACIONAMENTOS: ACTED_IN (Atores → Filmes/Séries)
// --------------------------------------------
MATCH (a:Actor {actorId: 'actor-001'}), (m:Movie {movieId: 'movie-001'})
CREATE (a)-[:ACTED_IN {role: 'Don Vito Corleone', screenTime: 45, isMainCast: true}]->(m);

MATCH (a:Actor {actorId: 'actor-002'}), (m:Movie {movieId: 'movie-001'})
CREATE (a)-[:ACTED_IN {role: 'Michael Corleone', screenTime: 60, isMainCast: true}]->(m);

MATCH (a:Actor {actorId: 'actor-003'}), (m:Movie {movieId: 'movie-002'})
CREATE (a)-[:ACTED_IN {role: 'Cooper', screenTime: 120, isMainCast: true}]->(m);

MATCH (a:Actor {actorId: 'actor-004'}), (m:Movie {movieId: 'movie-003'})
CREATE (a)-[:ACTED_IN {role: 'Tyler Durden', screenTime: 90, isMainCast: true}]->(m);

MATCH (a:Actor {actorId: 'actor-004'}), (m:Movie {movieId: 'movie-004'})
CREATE (a)-[:ACTED_IN {role: 'Vincent Vega', screenTime: 80, isMainCast: true}]->(m);

MATCH (a:Actor {actorId: 'actor-005'}), (m:Movie {movieId: 'movie-005'})
CREATE (a)-[:ACTED_IN {role: 'Neo', screenTime: 125, isMainCast: true}]->(m);

MATCH (a:Actor {actorId: 'actor-006'}), (m:Movie {movieId: 'movie-006'})
CREATE (a)-[:ACTED_IN {role: 'Frodo Baggins', screenTime: 110, isMainCast: true}]->(m);

MATCH (a:Actor {actorId: 'actor-007'}), (s:Series {seriesId: 'series-001'})
CREATE (a)-[:ACTED_IN {role: 'Walter White', screenTime: 2400, isMainCast: true}]->(s);

MATCH (a:Actor {actorId: 'actor-008'}), (s:Series {seriesId: 'series-002'})
CREATE (a)-[:ACTED_IN {role: 'Daenerys Targaryen', screenTime: 1800, isMainCast: true}]->(s);

// --------------------------------------------
// RELACIONAMENTOS: DIRECTED (Diretores → Filmes/Séries)
// --------------------------------------------
MATCH (d:Director {directorId: 'director-001'}), (m:Movie {movieId: 'movie-001'})
CREATE (d)-[:DIRECTED {year: 1972}]->(m);

MATCH (d:Director {directorId: 'director-002'}), (m:Movie {movieId: 'movie-002'})
CREATE (d)-[:DIRECTED {year: 2014}]->(m);

MATCH (d:Director {directorId: 'director-003'}), (m:Movie {movieId: 'movie-003'})
CREATE (d)-[:DIRECTED {year: 1999}]->(m);

MATCH (d:Director {directorId: 'director-004'}), (m:Movie {movieId: 'movie-004'})
CREATE (d)-[:DIRECTED {year: 1994}]->(m);

MATCH (d:Director {directorId: 'director-005'}), (m:Movie {movieId: 'movie-005'})
CREATE (d)-[:DIRECTED {year: 1999}]->(m);

MATCH (d:Director {directorId: 'director-006'}), (m:Movie {movieId: 'movie-006'})
CREATE (d)-[:DIRECTED {year: 2001}]->(m);

// --------------------------------------------
// RELACIONAMENTOS: WATCHED (Usuários → Filmes/Séries)
// --------------------------------------------
MATCH (u:User {userId: 'user-001'}), (m:Movie {movieId: 'movie-001'})
CREATE (u)-[:WATCHED {rating: 5, timestamp: datetime(), progress: 100, device: 'tv'}]->(m);

MATCH (u:User {userId: 'user-001'}), (m:Movie {movieId: 'movie-002'})
CREATE (u)-[:WATCHED {rating: 5, timestamp: datetime(), progress: 100, device: 'tv'}]->(m);

MATCH (u:User {userId: 'user-001'}), (s:Series {seriesId: 'series-001'})
CREATE (u)-[:WATCHED {rating: 5, timestamp: datetime(), progress: 100, device: 'mobile'}]->(s);

MATCH (u:User {userId: 'user-002'}), (m:Movie {movieId: 'movie-001'})
CREATE (u)-[:WATCHED {rating: 4, timestamp: datetime(), progress: 100, device: 'web'}]->(m);

MATCH (u:User {userId: 'user-002'}), (m:Movie {movieId: 'movie-003'})
CREATE (u)-[:WATCHED {rating: 5, timestamp: datetime(), progress: 100, device: 'tv'}]->(m);

MATCH (u:User {userId: 'user-002'}), (s:Series {seriesId: 'series-002'})
CREATE (u)-[:WATCHED {rating: 4, timestamp: datetime(), progress: 85, device: 'tv'}]->(s);

MATCH (u:User {userId: 'user-003'}), (m:Movie {movieId: 'movie-002'})
CREATE (u)-[:WATCHED {rating: 5, timestamp: datetime(), progress: 100, device: 'tv'}]->(m);

MATCH (u:User {userId: 'user-003'}), (m:Movie {movieId: 'movie-005'})
CREATE (u)-[:WATCHED {rating: 4, timestamp: datetime(), progress: 100, device: 'mobile'}]->(m);

MATCH (u:User {userId: 'user-004'}), (m:Movie {movieId: 'movie-004'})
CREATE (u)-[:WATCHED {rating: 5, timestamp: datetime(), progress: 100, device: 'web'}]->(m);

MATCH (u:User {userId: 'user-004'}), (m:Movie {movieId: 'movie-006'})
CREATE (u)-[:WATCHED {rating: 4, timestamp: datetime(), progress: 100, device: 'tv'}]->(m);

MATCH (u:User {userId: 'user-005'}), (s:Series {seriesId: 'series-003'})
CREATE (u)-[:WATCHED {rating: 4, timestamp: datetime(), progress: 75, device: 'mobile'}]->(s);

MATCH (u:User {userId: 'user-006'}), (m:Movie {movieId: 'movie-003'})
CREATE (u)-[:WATCHED {rating: 5, timestamp: datetime(), progress: 100, device: 'tv'}]->(m);

MATCH (u:User {userId: 'user-006'}), (m:Movie {movieId: 'movie-005'})
CREATE (u)-[:WATCHED {rating: 5, timestamp: datetime(), progress: 100, device: 'tv'}]->(m);

MATCH (u:User {userId: 'user-007'}), (s:Series {seriesId: 'series-001'})
CREATE (u)-[:WATCHED {rating: 5, timestamp: datetime(), progress: 100, device: 'tv'}]->(s);

MATCH (u:User {userId: 'user-007'}), (m:Movie {movieId: 'movie-001'})
CREATE (u)-[:WATCHED {rating: 4, timestamp: datetime(), progress: 100, device: 'web'}]->(m);

MATCH (u:User {userId: 'user-008'}), (m:Movie {movieId: 'movie-006'})
CREATE (u)-[:WATCHED {rating: 5, timestamp: datetime(), progress: 100, device: 'tv'}]->(m);

MATCH (u:User {userId: 'user-009'}), (s:Series {seriesId: 'series-004'})
CREATE (u)-[:WATCHED {rating: 4, timestamp: datetime(), progress: 60, device: 'mobile'}]->(s);

MATCH (u:User {userId: 'user-010'}), (m:Movie {movieId: 'movie-004'})
CREATE (u)-[:WATCHED {rating: 5, timestamp: datetime(), progress: 100, device: 'tv'}]->(m);

// --------------------------------------------
// RELACIONAMENTOS: FOLLOWS (Rede social entre usuários)
// --------------------------------------------
MATCH (u1:User {userId: 'user-001'}), (u2:User {userId: 'user-002'})
CREATE (u1)-[:FOLLOWS {since: datetime()}]->(u2);

MATCH (u1:User {userId: 'user-001'}), (u2:User {userId: 'user-003'})
CREATE (u1)-[:FOLLOWS {since: datetime()}]->(u2);

MATCH (u1:User {userId: 'user-002'}), (u2:User {userId: 'user-001'})
CREATE (u1)-[:FOLLOWS {since: datetime()}]->(u2);

MATCH (u1:User {userId: 'user-003'}), (u2:User {userId: 'user-001'})
CREATE (u1)-[:FOLLOWS {since: datetime()}]->(u2);

MATCH (u1:User {userId: 'user-004'}), (u2:User {userId: 'user-005'})
CREATE (u1)-[:FOLLOWS {since: datetime()}]->(u2);

// Verificar relacionamentos criados
MATCH ()-[r]->() 
RETURN type(r) as tipo, count(r) as quantidade;
