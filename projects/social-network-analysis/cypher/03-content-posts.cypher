// ============================================
// POSTS E CONTEÚDO - 30 publicações variadas
// ============================================

// Hashtags populares
CREATE (h1:Hashtag {tag: '#tecnologia', category: 'tech', usageCount: 45000});
CREATE (h2:Hashtag {tag: '#javascript', category: 'programming', usageCount: 32000});
CREATE (h3:Hashtag {tag: '#corrida', category: 'sports', usageCount: 28000});
CREATE (h4:Hashtag {tag: '#receita', category: 'food', usageCount: 51000});
CREATE (h5:Hashtag {tag: '#viagem', category: 'travel', usageCount: 67000});
CREATE (h6:Hashtag {tag: '#musica', category: 'music', usageCount: 89000});
CREATE (h7:Hashtag {tag: '#gameplay', category: 'gaming', usageCount: 24000});
CREATE (h8:Hashtag {tag: '#moda', category: 'fashion', usageCount: 43000});
CREATE (h9:Hashtag {tag: '#politica', category: 'news', usageCount: 19000});
CREATE (h10:Hashtag {tag: '#startup', category: 'business', usageCount: 15000});

// Posts de Maria (Tech)
MATCH (u:User {userId: 'u001'}), (t:Topic {topicId: 'tech'}), (h1:Hashtag {tag: '#tecnologia'}), (h2:Hashtag {tag: '#javascript'})
CREATE (p1:Post {
  postId: 'p001',
  content: 'Acabei de descobrir uma nova forma de otimizar algoritmos de ML! Thread 🧵 #tecnologia #javascript',
  type: 'text',
  timestamp: datetime() - duration('PT2H'),
  likes: 234,
  shares: 45,
  comments: 23,
  views: 5600,
  sentimentScore: 0.8
})-[:POSTED {timestamp: datetime() - duration('PT2H'), device: 'mobile'}]->(u)
CREATE (p1)-[:ABOUT_TOPIC {confidence: 0.95}]->(t)
CREATE (p1)-[:TAGGED_WITH {relevance: 0.9}]->(h1)
CREATE (p1)-[:TAGGED_WITH {relevance: 0.7}]->(h2);

// Posts de José (Fitness)
MATCH (u:User {userId: 'u002'}), (t:Topic {topicId: 'sports'}), (h3:Hashtag {tag: '#corrida'})
CREATE (p2:Post {
  postId: 'p002',
  content: '5km em 22min hoje! Superando meu recorde pessoal 💪 #corrida',
  type: 'image',
  timestamp: datetime() - duration('PT4H'),
  likes: 567,
  shares: 12,
  comments: 45,
  views: 8900,
  sentimentScore: 0.9
})-[:POSTED]->(u)
CREATE (p2)-[:ABOUT_TOPIC {confidence: 0.98}]->(t)
CREATE (p2)-[:TAGGED_WITH {relevance: 1.0}]->(h3);

// Posts de Ana (Food)
MATCH (u:User {userId: 'u003'}), (t:Topic {topicId: 'food'}), (h4:Hashtag {tag: '#receita'})
CREATE (p3:Post {
  postId: 'p003',
  content: 'Risoto de funghi que aprendi em Milão! Receita completa no blog 🍄 #receita',
  type: 'image',
  timestamp: datetime() - duration('PT6H'),
  likes: 1234,
  shares: 234,
  comments: 89,
  views: 15600,
  sentimentScore: 0.85
})-[:POSTED]->(u)
CREATE (p3)-[:ABOUT_TOPIC {confidence: 0.95}]->(t)
CREATE (p3)-[:TAGGED_WITH {relevance: 1.0}]->(h4);

// Posts de Pedro (Música)
MATCH (u:User {userId: 'u004'}), (t:Topic {topicId: 'music'}), (h6:Hashtag {tag: '#musica'})
CREATE (p4:Post {
  postId: 'p004',
  content: 'Novo single disponível em todas as plataformas! Link na bio 🎸 #musica',
  type: 'video',
  timestamp: datetime() - duration('PT1H'),
  likes: 4567,
  shares: 890,
  comments: 234,
  views: 45000,
  sentimentScore: 0.9
})-[:POSTED]->(u)
CREATE (p4)-[:ABOUT_TOPIC {confidence: 0.99}]->(t)
CREATE (p4)-[:TAGGED_WITH {relevance: 1.0}]->(h6);

// Posts de Clara (Viagens)
MATCH (u:User {userId: 'u005'}), (t:Topic {topicId: 'travel'}), (h5:Hashtag {tag: '#viagem'})
CREATE (p5:Post {
  postId: 'p005',
  content: 'Aurora Boreal na Islândia! Sonho realizado ✨ #viagem',
  type: 'image',
  timestamp: datetime() - duration('PT8H'),
  likes: 8901,
  shares: 1234,
  comments: 567,
  views: 67000,
  sentimentScore: 0.95
})-[:POSTED]->(u)
CREATE (p5)-[:ABOUT_TOPIC {confidence: 0.98}]->(t)
CREATE (p5)-[:TAGGED_WITH {relevance: 1.0}]->(h5);

// Posts de Lucas (Gaming)
MATCH (u:User {userId: 'u006'}), (t:Topic {topicId: 'gaming'}), (h7:Hashtag {tag: '#gameplay'})
CREATE (p6:Post {
  postId: 'p006',
  content: 'Live on! Ranked Valorant, rumo ao Radiante 🔥 #gameplay',
  type: 'video',
  timestamp: datetime() - duration('PT30M'),
  likes: 345,
  shares: 23,
  comments: 156,
  views: 2300,
  sentimentScore: 0.75
})-[:POSTED]->(u)
CREATE (p6)-[:ABOUT_TOPIC {confidence: 0.95}]->(t)
CREATE (p6)-[:TAGGED_WITH {relevance: 0.9}]->(h7);

// Posts de Juliana (Moda)
MATCH (u:User {userId: 'u007'}), (t:Topic {topicId: 'fashion'}), (h8:Hashtag {tag: '#moda'})
CREATE (p7:Post {
  postId: 'p007',
  content: 'Tendências de outono/inverno 2024 que você precisa conhecer! 🍂 #moda',
  type: 'carousel',
  timestamp: datetime() - duration('PT3H'),
  likes: 2345,
  shares: 456,
  comments: 123,
  views: 18900,
  sentimentScore: 0.8
})-[:POSTED]->(u)
CREATE (p7)-[:ABOUT_TOPIC {confidence: 0.92}]->(t)
CREATE (p7)-[:TAGGED_WITH {relevance: 1.0}]->(h8);

// Posts de Roberto (Política)
MATCH (u:User {userId: 'u008'}), (t:Topic {topicId: 'politics'}), (h9:Hashtag {tag: '#politica'})
CREATE (p8:Post {
  postId: 'p008',
  content: 'Análise: Os impactos da nova reforma tributária na economia brasileira #politica',
  type: 'text',
  timestamp: datetime() - duration('PT5H'),
  likes: 1234,
  shares: 567,
  comments: 890,
  views: 45000,
  sentimentScore: 0.3
})-[:POSTED]->(u)
CREATE (p8)-[:ABOUT_TOPIC {confidence: 0.95}]->(t)
CREATE (p8)-[:TAGGED_WITH {relevance: 0.95}]->(h9);

// Posts de Fernanda (Tech)
MATCH (u:User {userId: 'u009'}), (t:Topic {topicId: 'tech'}), (h1:Hashtag {tag: '#tecnologia'})
CREATE (p9:Post {
  postId: 'p009',
  content: 'Vue 3 vs React 18: minha experiência migrando entre frameworks #tecnologia',
  type: 'text',
  timestamp: datetime() - duration('PT7H'),
  likes: 678,
  shares: 123,
  comments: 89,
  views: 12300,
  sentimentScore: 0.7
})-[:POSTED]->(u)
CREATE (p9)-[:ABOUT_TOPIC {confidence: 0.9}]->(t)
CREATE (p9)-[:TAGGED_WITH {relevance: 0.9}]->(h1);

// Posts de Carlos (Esportes)
MATCH (u:User {userId: 'u010'}), (t:Topic {topicId: 'sports'}), (h3:Hashtag {tag: '#corrida'})
CREATE (p10:Post {
  postId: 'p010',
  content: 'Flamengo campeão! Análise pós-jogo no fio 🧵 #futebol',
  type: 'video',
  timestamp: datetime() - duration('PT1H'),
  likes: 12345,
  shares: 3456,
  comments: 2345,
  views: 156000,
  sentimentScore: 0.85
})-[:POSTED]->(u)
CREATE (p10)-[:ABOUT_TOPIC {confidence: 0.95}]->(t);

// Mais posts variados
MATCH (u:User {userId: 'u011'}), (t:Topic {topicId: 'art'})
CREATE (p11:Post {postId: 'p011', content: 'Nova ilustração! O que acharam? 🎨', type: 'image', timestamp: datetime() - duration('PT10H'), likes: 890, shares: 45, comments: 67, views: 5600, sentimentScore: 0.8})-[:POSTED]->(u);

MATCH (u:User {userId: 'u012'}), (t:Topic {topicId: 'tech'}), (h10:Hashtag {tag: '#startup'})
CREATE (p12:Post {postId: 'p012', content: 'Levantamos R$ 10M na Series A! 🚀 #startup', type: 'text', timestamp: datetime() - duration('PT12H'), likes: 4567, shares: 890, comments: 234, views: 34000, sentimentScore: 0.95})-[:POSTED]->(u)
CREATE (p12)-[:TAGGED_WITH {relevance: 1.0}]->(h10);

MATCH (u:User {userId: 'u013'}), (t:Topic {topicId: 'wellness'})
CREATE (p13:Post {postId: 'p013', content: 'Meditação guiada para iniciantes 🧘‍♀️', type: 'video', timestamp: datetime() - duration('PT14H'), likes: 2345, shares: 567, comments: 123, views: 18900, sentimentScore: 0.9})-[:POSTED]->(u);

MATCH (u:User {userId: 'u014'}), (t:Topic {topicId: 'food'}), (h4:Hashtag {tag: '#receita'})
CREATE (p14:Post {postId: 'p014', content: 'Segredo do risoto perfeito: o caldo! #receita', type: 'video', timestamp: datetime() - duration('PT16H'), likes: 5678, shares: 1234, comments: 456, views: 45000, sentimentScore: 0.85})-[:POSTED]->(u)
CREATE (p14)-[:TAGGED_WITH {relevance: 1.0}]->(h4);

MATCH (u:User {userId: 'u015'})
CREATE (p15:Post {postId: 'p015', content: 'Meus gatos reagindo ao laser 😹', type: 'video', timestamp: datetime() - duration('PT18H'), likes: 8901, shares: 2345, comments: 890, views: 67000, sentimentScore: 0.95})-[:POSTED]->(u);

// Verificar posts
MATCH (p:Post)-[:POSTED]->(u:User)
RETURN u.username, count(p) as posts ORDER BY posts DESC;
