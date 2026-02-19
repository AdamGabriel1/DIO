// ============================================
// INTERAÇÕES - Likes, Comments, Shares, Views
// ============================================

// LIKES - rede de engajamento
MATCH (u:User {userId: 'u001'}), (p:Post) WHERE p.postId IN ['p002', 'p003', 'p005', 'p009']
CREATE (u)-[:LIKED {timestamp: datetime() - duration('PT1H'), reactionType: 'like'}]->(p);

MATCH (u:User {userId: 'u002'}), (p:Post) WHERE p.postId IN ['p001', 'p003', 'p004', 'p010']
CREATE (u)-[:LIKED {timestamp: datetime() - duration('PT2H'), reactionType: 'love'}]->(p);

MATCH (u:User {userId: 'u003'}), (p:Post) WHERE p.postId IN ['p001', 'p002', 'p005', 'p014']
CREATE (u)-[:LIKED {timestamp: datetime() - duration('PT30M'), reactionType: 'like'}]->(p);

MATCH (u:User {userId: 'u004'}), (p:Post) WHERE p.postId IN ['p003', 'p006', 'p008', 'p011']
CREATE (u)-[:LIKED {timestamp: datetime() - duration('PT45M'), reactionType: 'like'}]->(p);

MATCH (u:User {userId: 'u005'}), (p:Post) WHERE p.postId IN ['p001', 'p002', 'p004', 'p007']
CREATE (u)-[:LIKED {timestamp: datetime() - duration('PT3H'), reactionType: 'love'}]->(p);

MATCH (u:User {userId: 'u006'}), (p:Post) WHERE p.postId IN ['p001', 'p004', 'p009', 'p012']
CREATE (u)-[:LIKED {timestamp: datetime() - duration('PT15M'), reactionType: 'fire'}]->(p);

MATCH (u:User {userId: 'u007'}), (p:Post) WHERE p.postId IN ['p003', 'p005', 'p008', 'p013']
CREATE (u)-[:LIKED {timestamp: datetime() - duration('PT2H'), reactionType: 'like'}]->(p);

MATCH (u:User {userId: 'u008'}), (p:Post) WHERE p.postId IN ['p001', 'p004', 'p009', 'p012']
CREATE (u)-[:LIKED {timestamp: datetime() - duration('PT4H'), reactionType: 'think'}]->(p);

MATCH (u:User {userId: 'u009'}), (p:Post) WHERE p.postId IN ['p001', 'p002', 'p006', 'p012']
CREATE (u)-[:LIKED {timestamp: datetime() - duration('PT1H'), reactionType: 'like'}]->(p);

MATCH (u:User {userId: 'u010'}), (p:Post) WHERE p.postId IN ['p003', 'p004', 'p007', 'p014']
CREATE (u)-[:LIKED {timestamp: datetime() - duration('PT20M'), reactionType: 'love'}]->(p);

// COMMENTS - comentários em posts
CREATE (c1:Comment {commentId: 'c001', text: 'Incrível! Parabéns pelo recorde 🎉', timestamp: datetime() - duration('PT3H'), likes: 12})
WITH c1
MATCH (u:User {userId: 'u003'}), (p:Post {postId: 'p002'})
CREATE (u)-[:COMMENTED {timestamp: datetime() - duration('PT3H')}]->(c1)
CREATE (c1)-[:REPLIED_TO]->(p);

CREATE (c2:Comment {commentId: 'c002', text: 'Qual foi a estratégia de treino?', timestamp: datetime() - duration('PT2H'), likes: 8})
WITH c2
MATCH (u:User {userId: 'u006'}), (p:Post {postId: 'p002'})
CREATE (u)-[:COMMENTED {timestamp: datetime() - duration('PT2H')}]->(c2)
CREATE (c2)-[:REPLIED_TO]->(p);

CREATE (c3:Comment {commentId: 'c003', text: 'Vou testar esse código hoje!', timestamp: datetime() - duration('PT1H'), likes: 23})
WITH c3
MATCH (u:User {userId: 'u009'}), (p:Post {postId: 'p001'})
CREATE (u)-[:COMMENTED {timestamp: datetime() - duration('PT1H')}]->(c3)
CREATE (c3)-[:REPLIED_TO]->(p);

CREATE (c4:Comment {commentId: 'c004', text: 'Vue é vida! React é overengineering', timestamp: datetime() - duration('PT30M'), likes: 45})
WITH c4
MATCH (u:User {userId: 'u001'}), (p:Post {postId: 'p009'})
CREATE (u)-[:COMMENTED {timestamp: datetime() - duration('PT30M')}]->(c4)
CREATE (c4)-[:REPLIED_TO]->(p);

CREATE (c5:Comment {commentId: 'c005', text: 'Lugar de sonho! Quanto custou?', timestamp: datetime() - duration('PT5H'), likes: 34})
WITH c5
MATCH (u:User {userId: 'u007'}), (p:Post {postId: 'p005'})
CREATE (u)-[:COMMENTED {timestamp: datetime() - duration('PT5H')}]->(c5)
CREATE (c5)-[:REPLIED_TO]->(p);

// Nested replies
CREATE (c6:Comment {commentId: 'c006', text: 'Foi barato! Só 15k a viagem completa', timestamp: datetime() - duration('PT4H'), likes: 67})
WITH c6
MATCH (u:User {userId: 'u005'}), (c5:Comment {commentId: 'c005'})
CREATE (u)-[:COMMENTED {timestamp: datetime() - duration('PT4H')}]->(c6)
CREATE (c6)-[:REPLIED_TO]->(c5);

// SHARES - compartilhamentos
MATCH (u:User {userId: 'u002'}), (p:Post {postId: 'p001'})
CREATE (u)-[:SHARED {timestamp: datetime() - duration('PT2H'), platform: 'story', quote: 'Boa dica!'}]->(p);

MATCH (u:User {userId: 'u004'}), (p:Post {postId: 'p003'})
CREATE (u)-[:SHARED {timestamp: datetime() - duration('PT4H'), platform: 'direct', quote: 'Vamos fazer isso?'}]->(p);

MATCH (u:User {userId: 'u006'}), (p:Post {postId: 'p005'})
CREATE (u)-[:SHARED {timestamp: datetime() - duration('PT6H'), platform: 'feed', quote: 'Bucket list!'}]->(p);

MATCH (u:User {userId: 'u008'}), (p:Post {postId: 'p012'})
CREATE (u)-[:SHARED {timestamp: datetime() - duration('PT8H'), platform: 'story'}]->(p);

MATCH (u:User {userId: 'u010'}), (p:Post {postId: 'p004'})
CREATE (u)-[:SHARED {timestamp: datetime() - duration('PT1H'), platform: 'feed', quote: 'Nova música do Pedro tá incrível'}]->(p);

// VIEWS - visualizações (simulando maior volume)
MATCH (u:User), (p:Post)
WHERE rand() < 0.3 AND u.userId <> 'u001'  // 30% dos usuários viram posts aleatórios
WITH u, p LIMIT 50
CREATE (u)-[:VIEWED {timestamp: datetime() - duration('PT' + toInteger(rand()*24) + 'H'), duration: rand()*300}]->(p);

// MENTIONS - menções em posts
MATCH (p:Post {postId: 'p001'}), (u:User {userId: 'u009'})
CREATE (p)-[:MENTIONS]->(u);

MATCH (p:Post {postId: 'p004'}), (u:User {userId: 'u002'})
CREATE (p)-[:MENTIONS]->(u);

MATCH (p:Post {postId: 'p009'}), (u:User {userId: 'u001'})
CREATE (p)-[:MENTIONS]->(u);

// Verificar interações
MATCH ()-[r:LIKED|COMMENTED|SHARED|VIEWED]->() 
RETURN type(r) as interaction, count(r) as count ORDER BY count DESC;
