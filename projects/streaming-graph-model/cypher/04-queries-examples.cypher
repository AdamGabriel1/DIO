// ============================================
// CONSULTAS DE EXEMPLO - Sistema de Recomendação
// ============================================

// 1. FILMES MAIS ASSISTIDOS
MATCH (m:Movie)<-[w:WATCHED]-(u:User)
RETURN m.title, count(u) as views, avg(w.rating) as avgRating
ORDER BY views DESC
LIMIT 5;

// 2. RECOMENDAÇÃO POR GÊNERO (Conteúdo)
// Filmes do mesmo gênero que o usuário gostou
MATCH (u:User {userId: 'user-001'})-[w:WATCHED]->(m:Movie)-[:IN_GENRE]->(g:Genre)<-[:IN_GENRE]-(rec:Movie)
WHERE w.rating >= 4 AND NOT (u)-[:WATCHED]->(rec)
RETURN rec.title, collect(DISTINCT g.name) as genres, count(g) as score
ORDER BY score DESC
LIMIT 5;

// 3. RECOMENDAÇÃO COLABORATIVA (User-User)
// Usuários com gostos similares
MATCH (u1:User {userId: 'user-001'})-[w1:WATCHED]->(m:Movie)<-[w2:WATCHED]-(u2:User)
WHERE u1 <> u2 AND abs(w1.rating - w2.rating) <= 1
WITH u2, count(m) as commonMovies, avg(abs(w1.rating - w2.rating)) as similarity
ORDER BY commonMovies DESC, similarity ASC
LIMIT 5
MATCH (u2)-[w:WATCHED]->(rec:Movie)
WHERE w.rating >= 4 AND NOT (u1)-[:WATCHED]->(rec)
RETURN rec.title, avg(w.rating) as predictedRating, count(u2) as recommenders
ORDER BY predictedRating DESC, recommenders DESC
LIMIT 5;

// 4. ATORES MAIS POPULARES (Centralidade)
MATCH (a:Actor)-[:ACTED_IN]->(m:Movie)<-[w:WATCHED]-(u:User)
RETURN a.name, count(DISTINCT u) as popularity, collect(DISTINCT m.title)[0..3] as topMovies
ORDER BY popularity DESC
LIMIT 10;

// 5. CAMINHO ENTRE ATORES (Kevin Bacon Number)
// Conexão entre dois atores através de filmes
MATCH path = shortestPath(
  (a1:Actor {name: 'Brad Pitt'})-[:ACTED_IN|DIRECTED*]-(a2:Actor {name: 'Al Pacino'})
)
RETURN path;

// 6. GÊNEROS FAVORITOS DO USUÁRIO
MATCH (u:User {userId: 'user-001'})-[w:WATCHED]->()-[:IN_GENRE]->(g:Genre)
RETURN g.name, count(*) as watchedCount, avg(w.rating) as avgRating
ORDER BY watchedCount DESC;

// 7. FILMES BEM AVALIADOS MAS POUCO ASSISTIDOS (Niché)
MATCH (m:Movie)<-[w:WATCHED]-(u:User)
WITH m, count(u) as views, avg(w.rating) as rating
WHERE views < 3 AND rating >= 4.5
RETURN m.title, views, rating
ORDER BY rating DESC;

// 8. TENDÊNCIAS (Assistidos recentemente)
MATCH (u:User)-[w:WATCHED]->(m:Movie)
WHERE w.timestamp > datetime() - duration('P7D')
RETURN m.title, count(u) as recentViews
ORDER BY recentViews DESC
LIMIT 10;

// 9. RECOMENDAÇÃO BASEADA EM DIRETOR FAVORITO
MATCH (u:User {userId: 'user-001'})-[:WATCHED]->(m:Movie)<-[:DIRECTED]-(d:Director)
WITH d, count(m) as collaborations, avg(m.rating) as avgRating
ORDER BY collaborations DESC
LIMIT 1
MATCH (d)-[:DIRECTED]->(rec:Movie)
WHERE NOT (u)-[:WATCHED]->(rec)
RETURN rec.title, d.name as director
LIMIT 5;

// 10. COMUNIDADES DE USUÁRIOS (Clustering)
MATCH (u1:User)-[:WATCHED]->(g:Genre)<-[:WATCHED]-(u2:User)
WHERE u1 <> u2
WITH u1, u2, count(g) as commonGenres
WHERE commonGenres >= 2
RETURN u1.name, collect(u2.name)[0..5] as similarUsers;
