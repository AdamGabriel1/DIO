// ============================================
// ANÁLISE DE INFLUENCIADORES E IMPACTO
// ============================================

// ------------------------------------------------
// 1. SCORE DE INFLUÊNCIA COMPLETO
// ------------------------------------------------
MATCH (u:User)
OPTIONAL MATCH (u)<-[:FOLLOWS]-(f:User)
OPTIONAL MATCH (u)-[:POSTED]->(p:Post)
OPTIONAL MATCH (p)<-[l:LIKED]-()
OPTIONAL MATCH (p)<-[s:SHARED]-()
OPTIONAL MATCH (p)<-[c:COMMENTED]-()
OPTIONAL MATCH (p)<-[v:VIEWED]-()
WITH u,
     count(DISTINCT f) as followers,
     count(DISTINCT p) as posts,
     count(DISTINCT l) * 1.0 as likes,
     count(DISTINCT s) * 3.0 as shares,
     count(DISTINCT c) * 2.0 as comments,
     count(DISTINCT v) * 0.1 as views
WITH u, followers, posts, likes, shares, comments, views,
     (followers * 0.3 + likes * 0.2 + shares * 0.3 + comments * 0.15 + views * 0.05) as influenceScore
RETURN u.username,
       u.name,
       u.verified,
       followers,
       posts,
       round(likes) as likes,
       round(shares/3) as shares,
       round(comments/2) as comments,
       round(views*10) as views,
       round(influenceScore, 2) as influenceScore,
       CASE 
         WHEN influenceScore > 1000 THEN '⭐ Macro Influencer'
         WHEN influenceScore > 500 THEN '📢 Micro Influencer'
         WHEN influenceScore > 100 THEN '💬 Nano Influencer'
         ELSE '👤 Usuário Regular'
       END as tier
ORDER BY influenceScore DESC;

// ------------------------------------------------
// 2. ALCANCE DE CONTEÚDO (Viral Potential)
// ------------------------------------------------
MATCH (p:Post)-[:POSTED]->(u:User)
OPTIONAL MATCH (p)<-[l:LIKED]-(liker:User)
OPTIONAL MATCH (liker)-[:FOLLOWS]->(followerOfLiker:User)
WHERE followerOfLiker <> u
WITH p, u, count(DISTINCT liker) as directLikes,
     count(DISTINCT followerOfLiker) as potentialReach,
     (p.likes + p.shares * 3) / toFloat(p.views + 1) * 100 as viralCoefficient
RETURN p.postId,
       substring(p.content, 0, 50) + '...' as content,
       u.username as author,
       directLikes,
       potentialReach,
       round(viralCoefficient, 2) as viralScore,
       CASE 
         WHEN viralCoefficient > 10 THEN '🚀 Viral'
         WHEN viralCoefficient > 5 THEN '📈 Trending'
         ELSE '📊 Normal'
       END as status
ORDER BY viralCoefficient DESC
LIMIT 10;

// ------------------------------------------------
// 3. INFLUÊNCIA POR TÓPICO (Topic Authority)
// ------------------------------------------------
MATCH (u:User)-[:POSTED]->(p:Post)-[:ABOUT_TOPIC]->(t:Topic)
OPTIONAL MATCH (p)<-[i:LIKED|SHARED|COMMENTED]-()
WITH u, t, count(p) as postsOnTopic, count(i) as totalEngagement
WHERE postsOnTopic >= 2
WITH u, t, postsOnTopic, totalEngagement,
     (postsOnTopic * 10 + totalEngagement * 2) as authorityScore
ORDER BY authorityScore DESC
WITH t, collect({user: u.username, score: authorityScore})[0..3] as topAuthorities
RETURN t.name as topic,
       [a in topAuthorities | a.user + ' (' + round(a.score) + ')'] as authorities;

// ------------------------------------------------
// 4. NETWORK EFFECT - Multiplicador de rede
// ------------------------------------------------
MATCH (u:User {userId: 'u001'})-[:FOLLOWS*1..3]-(reachable:User)
WHERE u <> reachable
WITH u, count(DISTINCT reachable) as networkReach,
     (1 + 0.1) * (1 + 0.1) * (1 + 0.1) as decayFactor // 10% decay per hop
RETURN u.username,
       networkReach,
       'Alcance de 3º grau: ' + networkReach + ' usuários' as reachDescription,
       'Multiplicador de rede: ' + round(networkReach / 15.0, 2) + 'x' as networkMultiplier;

// ------------------------------------------------
// 5. IMPACTO DE REMOÇÃO (What-if analysis)
// ------------------------------------------------
MATCH (u:User {userId: 'u004'})  // Pedro (influenciador musical)
OPTIONAL MATCH (u)-[:POSTED]->(p:Post)
OPTIONAL MATCH (p)<-[i:LIKED|SHARED|COMMENTED|VIEWED]-()
WITH u, count(p) as contentCount, count(i) as totalInteractions
OPTIONAL MATCH (u)-[:FOLLOWS]->(following:User)
OPTIONAL MATCH (follower:User)-[:FOLLOWS]->(u)
RETURN u.username + ' (' + u.name + ')' as influencer,
       contentCount as postsCreated,
       totalInteractions as totalEngagementGenerated,
       count(DISTINCT following) as accountsFollowing,
       count(DISTINCT follower) as followersWouldLose,
       'Impacto: ' + round(totalInteractions * 0.3) + ' interações/dia perdidas' as estimatedDailyImpact;

// ------------------------------------------------
// 6. DETECÇÃO DE BOTS/FAKE ACCOUNTS
// ------------------------------------------------
MATCH (u:User)
OPTIONAL MATCH (u)-[:POSTED]->(p:Post)
OPTIONAL MATCH (u)-[f:FOLLOWS]->()
OPTIONAL MATCH (follower:User)-[:FOLLOWS]->(u)
WITH u, 
     count(p) as posts,
     count(f) as following,
     count(follower) as followers,
     avg(p.likes) as avgLikesPerPost
WHERE following > 1000 AND posts < 5  // Segue muito, posta pouco
   OR (followers > 10000 AND avgLikesPerPost < 10)  // Muitos seguidores, pouco engajamento
   OR (following / toFloat(followers + 1)) > 10  // Ratio segue/seguidores anormal
RETURN u.username,
       u.name,
       followers,
       following,
       posts,
       round(avgLikesPerPost, 1) as avgLikes,
       round(following / toFloat(followers + 1), 2) as followRatio,
       '⚠️  Suspeito' as flag
ORDER BY followers DESC;
