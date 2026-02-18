// ============================================
// ANÁLISES AVANÇADAS E MÉTRICAS
// ============================================

// ------------------------------------------------
// 1. CENTRALIDADE - Artistas mais conectados
// ------------------------------------------------

// Degree Centrality (mais músicas)
MATCH (a:Artist)-[:CREATED_BY]-(s:Song)
RETURN a.name, count(s) as songCount
ORDER BY songCount DESC;

// Betweenness (ponte entre gêneros)
MATCH (a:Artist)-[:CREATED_BY]-(:Song)-[:BELONGS_TO]->(g:Genre)
WITH a, count(DISTINCT g) as genreDiversity
WHERE genreDiversity > 1
RETURN a.name, genreDiversity, 'Artista Ponte' as category
ORDER BY genreDiversity DESC;

// ------------------------------------------------
// 2. COMUNIDADES DE USUÁRIOS
// ------------------------------------------------

// Clustering por gênero preferido
MATCH (u:User)-[l:LISTENED]->(:Song)-[:BELONGS_TO]->(g:Genre)
WITH u, g, sum(l.plays) as plays
ORDER BY u.userId, plays DESC
WITH u, collect(g.name)[0] as primaryGenre
RETURN primaryGenre, collect(u.name) as users, count(u) as userCount
ORDER BY userCount DESC;

// ------------------------------------------------
// 3. FUNIL DE CONVERSÃO
// ------------------------------------------------

// Escuta → Like → Reescuta
MATCH (u:User)-[l:LISTENED]->(s:Song)
OPTIONAL MATCH (u)-[lk:LIKED]->(s)
OPTIONAL MATCH (u)-[r:LISTENED]->(s) WHERE r.plays > l.plays
WITH count(DISTINCT l) as totalListens,
     count(DISTINCT lk) as totalLikes,
     count(DISTINCT CASE WHEN r IS NOT NULL THEN s END) as reListens
RETURN totalListens,
       totalLikes,
       round(100.0 * totalLikes / totalListens, 2) as likeRatePercent,
       reListens,
       round(100.0 * reListens / totalListens, 2) as replayRatePercent;

// ------------------------------------------------
// 4. ANÁLISE TEMPORAL
// ------------------------------------------------

// Horários de pico (simulado)
MATCH (u:User)-[l:LISTENED]->(s:Song)
RETURN l.lastPlayed.hour as hourOfDay,
       count(*) as listenCount
ORDER BY hourOfDay;

// ------------------------------------------------
// 5. CHURN PREDICTION
// Usuários inativos (não ouvem há 30+ dias)
// ------------------------------------------------

MATCH (u:User)-[l:LISTENED]->(:Song)
WITH u, max(l.lastPlayed) as lastListen
WHERE lastListen < datetime() - duration('P30D')
RETURN u.name, 
       duration.between(lastListen, datetime()).days as daysInactive,
       'Risco de Churn' as status
ORDER BY daysInactive DESC;

// ------------------------------------------------
// 6. COLLABORATIVE FILTERING MATRIX
// ------------------------------------------------

// Matriz usuário-item simplificada
MATCH (u:User), (s:Song)
OPTIONAL MATCH (u)-[l:LISTENED]->(s)
WITH u, s, coalesce(l.plays, 0) as plays
WHERE plays > 0
RETURN u.name as user,
       collect({song: s.title, plays: plays})[0..5] as topSongs
ORDER BY u.name;
