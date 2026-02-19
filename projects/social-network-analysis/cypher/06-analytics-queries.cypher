// ============================================
// CONSULTAS ANALÍTICAS - Insights de Negócio
// ============================================

// ------------------------------------------------
// 1. FEED PERSONALIZADO (Posts de quem segue)
// ------------------------------------------------
MATCH (u:User {userId: 'u001'})-[:FOLLOWS]->(friend:User)-[:POSTED]->(p:Post)
WHERE p.timestamp > datetime() - duration('P7D')
WITH p, friend, (p.likes * 1 + p.shares * 2 + p.comments * 1.5) as engagementScore
ORDER BY engagementScore DESC, p.timestamp DESC
LIMIT 10
RETURN friend.name as author,
       p.content as post,
       p.timestamp as postedAt,
       engagementScore,
       p.likes + p.shares + p.comments as totalInteractions;

// ------------------------------------------------
// 2. SUGESTÃO DE AMIGOS (Amigos de amigos)
// ------------------------------------------------
MATCH (u:User {userId: 'u001'})-[:FRIENDS_WITH]-(friend)-[:FRIENDS_WITH]-(suggestion:User)
WHERE u <> suggestion 
  AND NOT (u)-[:FRIENDS_WITH|BLOCKED]-(suggestion)
  AND NOT (u)-[:FOLLOWS]->(suggestion)
WITH suggestion, count(friend) as mutualFriends, collect(friend.name) as via
ORDER BY mutualFriends DESC
LIMIT 5
RETURN suggestion.name as suggestedUser,
       suggestion.username,
       mutualFriends,
       via[0..3] as commonConnections;

// ------------------------------------------------
// 3. TRENDING TOPICS (Tópicos em alta)
// ------------------------------------------------
MATCH (p:Post)-[:ABOUT_TOPIC]->(t:Topic)
WHERE p.timestamp > datetime() - duration('PT24H')
WITH t, count(p) as postCount, avg(p.sentimentScore) as avgSentiment, sum(p.views) as totalViews
RETURN t.name as topic,
       postCount,
       round(avgSentiment, 2) as sentiment,
       totalViews,
       CASE 
         WHEN postCount > 5 AND avgSentiment > 0.7 THEN '🔥 Viral Positivo'
         WHEN postCount > 5 AND avgSentiment < 0.3 THEN '⚠️  Viral Negativo'
         ELSE '📊 Normal'
       END as status
ORDER BY postCount DESC, totalViews DESC;

// ------------------------------------------------
// 4. HASHTAGS EM ALTA
// ------------------------------------------------
MATCH (p:Post)-[:TAGGED_WITH]->(h:Hashtag)
WHERE p.timestamp > datetime() - duration('PT7D')
WITH h, count(p) as recentUsage, sum(p.likes) as totalLikes
RETURN h.tag as hashtag,
       h.category,
       recentUsage,
       totalLikes,
       h.usageCount + recentUsage as projectedTotal
ORDER BY recentUsage DESC
LIMIT 10;

// ------------------------------------------------
// 5. ANÁLISE DE SENTIMENTO POR USUÁRIO
// ------------------------------------------------
MATCH (u:User)-[:POSTED]->(p:Post)
WITH u, avg(p.sentimentScore) as avgSentiment, count(p) as postCount
WHERE postCount >= 2
RETURN u.username,
       u.name,
       round(avgSentiment, 2) as avgSentiment,
       postCount,
       CASE 
         WHEN avgSentiment > 0.7 THEN '😊 Positivo'
         WHEN avgSentiment < 0.4 THEN '😔 Negativo'
         ELSE '😐 Neutro'
       END as profile
ORDER BY avgSentiment DESC;

// ------------------------------------------------
// 6. ENGAGEMENT RATE POR TIPO DE CONTEÚDO
// ------------------------------------------------
MATCH (p:Post)
WITH p.type as contentType,
     avg(p.likes) as avgLikes,
     avg(p.comments) as avgComments,
     avg(p.shares) as avgShares,
     avg(p.views) as avgViews,
     count(p) as totalPosts
RETURN contentType,
       round(avgLikes, 1) as avgLikes,
       round(avgComments, 1) as avgComments,
       round(avgShares, 1) as avgShares,
       round((avgLikes + avgComments*2 + avgShares*3) / avgViews * 100, 2) as engagementRatePercent,
       totalPosts
ORDER BY engagementRatePercent DESC;

// ------------------------------------------------
// 7. USUÁRIOS MAIS INFLUENTES (Degree Centrality)
// ------------------------------------------------
MATCH (u:User)
OPTIONAL MATCH (u)<-[:FOLLOWS]-(follower)
OPTIONAL MATCH (u)<-[:LIKED]-(liker)
OPTIONAL MATCH (u)<-[:SHARED]-(sharer)
WITH u, 
     count(DISTINCT follower) as followers,
     count(DISTINCT liker) as likers,
     count(DISTINCT sharer) as sharers
RETURN u.username,
       u.name,
       followers,
       u.followersCount as declaredFollowers,
       likers,
       sharers,
       (followers * 1 + likers * 0.5 + sharers * 2) as influenceScore
ORDER BY influenceScore DESC
LIMIT 10;

// ------------------------------------------------
// 8. CAMINHO MAIS CURTO ENTRE USUÁRIOS
// ------------------------------------------------
MATCH path = shortestPath(
  (u1:User {userId: 'u001'})-[:FRIENDS_WITH|FOLLOWS*]-(u2:User {userId: 'u015'})
)
RETURN [node in nodes(path) | node.username] as connectionPath,
       length(path) as degreesOfSeparation;

// ------------------------------------------------
// 9. ECO CHAMBER DETECTION (Bolha de informação)
// ------------------------------------------------
MATCH (u:User)-[:FOLLOWS]->(followed:User)
WITH u, collect(DISTINCT followed.interests) as allInterests
UNWIND allInterests as interest
WITH u, interest, count(*) as interestCount
WHERE interestCount > 3
RETURN u.username,
       interest,
       interestCount,
       'Possível bolha de ' + interest as alert
ORDER BY interestCount DESC;

// ------------------------------------------------
// 10. CHURN PREDICTION (Usuários inativos)
// ------------------------------------------------
MATCH (u:User)-[r:POSTED|LIKED|COMMENTED]->()
WITH u, max(r.timestamp) as lastActivity
WHERE lastActivity < datetime() - duration('P30D')
RETURN u.username,
       u.name,
       duration.between(lastActivity, datetime()).days as daysInactive,
       u.joinDate,
       'Alto risco de churn' as status
ORDER BY daysInactive DESC;
