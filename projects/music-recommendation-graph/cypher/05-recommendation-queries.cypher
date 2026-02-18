// ============================================
// ALGORITMOS DE RECOMENDAÇÃO
// ============================================

// ------------------------------------------------
// 1. RECOMENDAÇÃO POR GÊNERO FAVORITO
// "Quais artistas de rock você recomendaria?"
// ------------------------------------------------

// Top gêneros do usuário
MATCH (u:User {userId: 'user-001'})-[l:LISTENED]->(s:Song)-[:BELONGS_TO]->(g:Genre)
WITH g, sum(l.plays) as totalPlays
ORDER BY totalPlays DESC
LIMIT 3
WITH g.name as favoriteGenre, totalPlays

// Artistas desse gênero que o usuário não ouve
MATCH (a:Artist)-[:CREATED_BY]-(s:Song)-[:BELONGS_TO]->(g:Genre {name: favoriteGenre})
WHERE NOT (u)-[:LISTENED]->(s)
RETURN favoriteGenre, 
       a.name as recommendedArtist, 
       count(s) as availableSongs,
       a.popularity as artistPopularity
ORDER BY availableSongs DESC, artistPopularity DESC
LIMIT 5;

// ------------------------------------------------
// 2. RECOMENDAÇÃO COLABORATIVA (User-User)
// Usuários com padrões de escuta similares
// ------------------------------------------------

MATCH (u1:User {userId: 'user-001'})-[l1:LISTENED]->(s:Song)<-[l2:LISTENED]-(u2:User)
WHERE u1 <> u2 
  AND abs(l1.plays - l2.plays) <= 20
  AND l1.skipRate < 0.2 
  AND l2.skipRate < 0.2
WITH u2, 
     count(s) as commonSongs,
     avg(abs(l1.plays - l2.plays)) as playDifference,
     sum(l1.plays + l2.plays) as totalEngagement
WHERE commonSongs >= 2
WITH u2, commonSongs, (commonSongs * 10) / (playDifference + 1) as similarityScore
ORDER BY similarityScore DESC
LIMIT 5

// Músicas que usuários similares gostaram
MATCH (u2)-[l:LIKED]->(rec:Song)-[:CREATED_BY]->(a:Artist)
WHERE l.rating >= 4
  AND NOT (u1)-[:LISTENED]->(rec)
RETURN rec.title as song,
       a.name as artist,
       collect(DISTINCT u2.name) as recommendedBy,
       avg(l.rating) as avgRating,
       count(u2) as recommenderCount
ORDER BY recommenderCount DESC, avgRating DESC
LIMIT 10;

// ------------------------------------------------
// 3. RECOMENDAÇÃO POR INFLUÊNCIA ARTÍSTICA
// Artistas que influenciaram os favoritos
// ------------------------------------------------

MATCH (u:User {userId: 'user-001'})-[:LISTENED]->(:Song)-[:CREATED_BY]->(fav:Artist)
MATCH (fav)-[:INFLUENCED_BY]->(influencer:Artist)
MATCH (influencer)-[:CREATED_BY]-(rec:Song)
WHERE NOT (u)-[:LISTENED]->(rec)
RETURN influencer.name as influencedBy,
       fav.name as originalFavorite,
       collect(rec.title)[0..3] as recommendedSongs,
       influencer.popularity as popularity
ORDER BY influencer.popularity DESC;

// ------------------------------------------------
// 4. RECOMENDAÇÃO POR REDE SOCIAL (FOLLOWS)
// O que amigos estão ouvindo
// ------------------------------------------------

MATCH (u:User {userId: 'user-001'})-[f:FOLLOWS]->(friend:User)
WHERE f.strength >= 0.7
MATCH (friend)-[l:LISTENED]->(s:Song)-[:CREATED_BY]->(a:Artist)
WHERE l.plays >= 30 AND l.skipRate < 0.1
  AND NOT (u)-[:LISTENED]->(s)
RETURN a.name as artist,
       s.title as song,
       friend.name as friendName,
       l.plays as friendPlays,
       f.strength as connectionStrength
ORDER BY friendPlays DESC, connectionStrength DESC
LIMIT 10;

// ------------------------------------------------
// 5. RECOMENDAÇÃO HÍBRIDA (Combinação de fatores)
// Peso: 40% conteúdo + 40% colaborativo + 20% popularidade
// ------------------------------------------------

MATCH (u:User {userId: 'user-001'})

// Score por gênero favorito (40%)
OPTIONAL MATCH (u)-[l1:LISTENED]->(:Song)-[:BELONGS_TO]->(g:Genre)<-[:BELONGS_TO]-(rec1:Song)
WHERE NOT (u)-[:LISTENED]->(rec1)
WITH u, rec1, g, sum(l1.plays) as genreScore
WHERE rec1 IS NOT NULL

// Score colaborativo (40%)
OPTIONAL MATCH (rec1)<-[l2:LISTENED]-(other:User)-[:LISTENED]->(:Song)<-[:LISTENED]-(u)
WHERE other <> u
WITH rec1, g, genreScore, count(DISTINCT other) as collabScore

// Popularidade do artista (20%)
MATCH (rec1)-[:CREATED_BY]->(a:Artist)
WITH rec1, g, a, genreScore, collabScore, a.popularity as popularityScore

// Score final ponderado
WITH rec1, a, g,
     (genreScore * 0.4) + (collabScore * 10 * 0.4) + (popularityScore * 0.2) as finalScore
ORDER BY finalScore DESC
LIMIT 10
RETURN rec1.title as song,
       a.name as artist,
       g.name as genre,
       round(finalScore, 2) as recommendationScore,
       'Híbrida' as algorithm;

// ------------------------------------------------
// 6. RECOMENDAÇÃO POR "VIBE" SIMILAR
// Músicas com características similares
// ------------------------------------------------

MATCH (u:User {userId: 'user-001'})-[l:LIKED {rating: 5}]->(fav:Song)-[:CREATED_BY]->(a:Artist)
WITH u, fav, a

// Músicas do mesmo artista
MATCH (a)-[:CREATED_BY]-(sameArtist:Song)
WHERE sameArtist <> fav AND NOT (u)-[:LISTENED]->(sameArtist)
WITH u, fav, sameArtist, 'Mesmo Artista' as reason, 1.0 as similarity

UNION

// Músicas do mesmo gênero por artistas similares
MATCH (fav)-[:BELONGS_TO]->(g:Genre)<-[:BELONGS_TO]-(similar:Song)-[:CREATED_BY]->(other:Artist)
WHERE NOT (u)-[:LISTENED]->(similar)
  AND other.popularity >= a.popularity - 10
WITH u, fav, similar, other, g, 'Gênero Similar' as reason, 0.8 as similarity
WHERE similar <> fav

RETURN similar.title as song,
       other.name as artist,
       g.name as genre,
       reason,
       similarity
ORDER BY similarity DESC
LIMIT 15;

// ------------------------------------------------
// 7. DISCOVERY (NOVIDADE) - Explorar novo conteúdo
// Músicas populares que o usuário nunca ouviu
// ------------------------------------------------

MATCH (s:Song)-[:CREATED_BY]->(a:Artist)
WHERE a.popularity > 85
  AND NOT (:User {userId: 'user-001'})-[:LISTENED]->(s)
OPTIONAL MATCH (u:User)-[l:LISTENED]->(s)
WITH s, a, count(l) as totalListeners, avg(l.plays) as avgPlays
WHERE totalListeners > 3
RETURN s.title as song,
       a.name as artist,
       a.popularity as artistPopularity,
       totalListeners,
       round(avgPlays, 1) as avgUserPlays,
       'Descoberta' as recommendationType
ORDER BY artistPopularity DESC, totalListeners DESC
LIMIT 10;

// ------------------------------------------------
// 8. REPLAY VALUE - Reescutar músicas esquecidas
// Músicas curtidas mas não ouvidas recentemente
// ------------------------------------------------

MATCH (u:User {userId: 'user-001'})-[l:LIKED {rating: 5}]->(s:Song)
WHERE NOT (u)-[recent:LISTENED]->(s) 
  OR recent.lastPlayed < datetime() - duration('P30D')
WITH u, s, l, recent
MATCH (s)-[:CREATED_BY]->(a:Artist)
RETURN s.title as song,
       a.name as artist,
       l.rating as yourRating,
       CASE 
         WHEN recent IS NULL THEN 'Nunca reouvida'
         ELSE 'Última vez: ' + duration.between(recent.lastPlayed, datetime()).days + ' dias atrás'
       END as status,
       'Replay' as recommendationType
ORDER BY l.rating DESC
LIMIT 10;
