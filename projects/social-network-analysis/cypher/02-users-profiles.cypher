// ============================================
// USUÁRIOS E PERFIS - 15 usuários variados
// ============================================

// Localizações
CREATE (loc1:Location {locationId: 'loc-001', city: 'São Paulo', state: 'SP', country: 'Brasil', coordinates: point({latitude: -23.5505, longitude: -46.6333})});
CREATE (loc2:Location {locationId: 'loc-002', city: 'Rio de Janeiro', state: 'RJ', country: 'Brasil', coordinates: point({latitude: -22.9068, longitude: -43.1729})});
CREATE (loc3:Location {locationId: 'loc-003', city: 'Belo Horizonte', state: 'MG', country: 'Brasil', coordinates: point({latitude: -19.9167, longitude: -43.9345})});
CREATE (loc4:Location {locationId: 'loc-004', city: 'Curitiba', state: 'PR', country: 'Brasil', coordinates: point({latitude: -25.4284, longitude: -49.2733})});
CREATE (loc5:Location {locationId: 'loc-005', city: 'Salvador', state: 'BA', country: 'Brasil', coordinates: point({latitude: -12.9714, longitude: -38.5014})});

// Tópicos de interesse
CREATE (t1:Topic {topicId: 'tech', name: 'Tecnologia', category: 'STEM', trendingScore: 95});
CREATE (t2:Topic {topicId: 'sports', name: 'Esportes', category: 'Lifestyle', trendingScore: 88});
CREATE (t3:Topic {topicId: 'music', name: 'Música', category: 'Entretenimento', trendingScore: 92});
CREATE (t4:Topic {topicId: 'politics', name: 'Política', category: 'Notícias', trendingScore: 78});
CREATE (t5:Topic {topicId: 'food', name: 'Gastronomia', category: 'Lifestyle', trendingScore: 85});
CREATE (t6:Topic {topicId: 'travel', name: 'Viagens', category: 'Lifestyle', trendingScore: 80});
CREATE (t7:Topic {topicId: 'fashion', name: 'Moda', category: 'Estilo', trendingScore: 75});
CREATE (t8:Topic {topicId: 'gaming', name: 'Games', category: 'Entretenimento', trendingScore: 90});

// Usuários
CREATE (u1:User {
  userId: 'u001',
  username: '@maria_tech',
  name: 'Maria Silva',
  bio: 'Desenvolvedora apaixonada por IA e café ☕',
  age: 28,
  email: 'maria@email.com',
  joinDate: date('2020-03-15'),
  verified: true,
  followersCount: 15400,
  followingCount: 890,
  interests: ['tech', 'ai', 'coffee']
})-[:LOCATED_AT]->(loc1);

CREATE (u2:User {
  userId: 'u002',
  username: '@jose_fitness',
  name: 'José Santos',
  bio: 'Personal trainer | Maratonista 🏃‍♂️',
  age: 32,
  email: 'jose@email.com',
  joinDate: date('2019-07-22'),
  verified: true,
  followersCount: 23100,
  followingCount: 450,
  interests: ['sports', 'health', 'running']
})-[:LOCATED_AT]->(loc2);

CREATE (u3:User {
  userId: 'u003',
  username: '@ana_foodie',
  name: 'Ana Costa',
  bio: 'Food blogger | Restaurantes de SP 🍽️',
  age: 26,
  email: 'ana@email.com',
  joinDate: date('2021-01-10'),
  verified: false,
  followersCount: 5200,
  followingCount: 1200,
  interests: ['food', 'travel', 'photography']
})-[:LOCATED_AT]->(loc1);

CREATE (u4:User {
  userId: 'u004',
  username: '@pedro_musica',
  name: 'Pedro Lima',
  bio: 'Músico independente 🎸 | Rock & MPB',
  age: 29,
  email: 'pedro@email.com',
  joinDate: date('2018-11-05'),
  verified: true,
  followersCount: 87500,
  followingCount: 2100,
  interests: ['music', 'guitar', 'concerts']
})-[:LOCATED_AT]->(loc3);

CREATE (u5:User {
  userId: 'u005',
  username: '@clara_viagens',
  name: 'Clara Mendes',
  bio: 'Viajante profissional ✈️ 45 países',
  age: 31,
  email: 'clara@email.com',
  joinDate: date('2019-05-18'),
  verified: true,
  followersCount: 45600,
  followingCount: 340,
  interests: ['travel', 'photography', 'culture']
})-[:LOCATED_AT]->(loc4);

CREATE (u6:User {
  userId: 'u006',
  username: '@lucas_gamer',
  name: 'Lucas Oliveira',
  bio: 'Streamer | Esports 🎮 | CS:GO & Valorant',
  age: 23,
  email: 'lucas@email.com',
  joinDate: date('2022-02-28'),
  verified: false,
  followersCount: 12300,
  followingCount: 560,
  interests: ['gaming', 'esports', 'streaming']
})-[:LOCATED_AT]->(loc1);

CREATE (u7:User {
  userId: 'u007',
  username: '@juliana_moda',
  name: 'Juliana Ferreira',
  bio: 'Stylist | Tendências 2024 💃',
  age: 27,
  email: 'juliana@email.com',
  joinDate: date('2020-09-12'),
  verified: true,
  followersCount: 34200,
  followingCount: 780,
  interests: ['fashion', 'beauty', 'lifestyle']
})-[:LOCATED_AT]->(loc2);

CREATE (u8:User {
  userId: 'u008',
  username: '@roberto_politica',
  name: 'Roberto Almeida',
  bio: 'Jornalista político 📰 | Análises diárias',
  age: 45,
  email: 'roberto@email.com',
  joinDate: date('2017-04-03'),
  verified: true,
  followersCount: 189000,
  followingCount: 230,
  interests: ['politics', 'news', 'economy']
})-[:LOCATED_AT]->(loc1);

CREATE (u9:User {
  userId: 'u009',
  username: '@fernanda_dev',
  name: 'Fernanda Souza',
  bio: 'Frontend dev | React & Vue ❤️',
  age: 25,
  email: 'fernanda@email.com',
  joinDate: date('2021-06-20'),
  verified: false,
  followersCount: 8900,
  followingCount: 670,
  interests: ['tech', 'coding', 'design']
})-[:LOCATED_AT]->(loc4);

CREATE (u10:User {
  userId: 'u010',
  username: '@carlos_esportes',
  name: 'Carlos Pereira',
  bio: 'Comentarista esportivo ⚽ | Futebol & NBA',
  age: 38,
  email: 'carlos@email.com',
  joinDate: date('2018-08-15'),
  verified: true,
  followersCount: 56700,
  followingCount: 340,
  interests: ['sports', 'football', 'basketball']
})-[:LOCATED_AT]->(loc5);

CREATE (u11:User {
  userId: 'u011',
  username: '@beatriz_art',
  name: 'Beatriz Lima',
  bio: 'Artista digital 🎨 | Comissions abertas',
  age: 24,
  email: 'beatriz@email.com',
  joinDate: date('2022-11-10'),
  verified: false,
  followersCount: 6700,
  followingCount: 890,
  interests: ['art', 'digital', 'illustration']
})-[:LOCATED_AT]->(loc3);

CREATE (u12:User {
  userId: 'u012',
  username: '@gabriel_startup',
  name: 'Gabriel Rocha',
  bio: 'CEO @TechStart 🚀 | Empreendedorismo',
  age: 34,
  email: 'gabriel@email.com',
  joinDate: date('2019-12-01'),
  verified: true,
  followersCount: 28900,
  followingCount: 1200,
  interests: ['tech', 'business', 'startup']
})-[:LOCATED_AT]->(loc1);

CREATE (u13:User {
  userId: 'u013',
  username: '@larissa_yoga',
  name: 'Larissa Martins',
  bio: 'Instrutora de yoga 🧘‍♀️ | Bem-estar',
  age: 30,
  email: 'larissa@email.com',
  joinDate: date('2020-07-25'),
  verified: false,
  followersCount: 11200,
  followingCount: 450,
  interests: ['wellness', 'yoga', 'health']
})-[:LOCATED_AT]->(loc2);

CREATE (u14:User {
  userId: 'u014',
  username: '@thiago_chef',
  name: 'Thiago Costa',
  bio: 'Chef executivo 👨‍🍳 | Receitas exclusivas',
  age: 36,
  email: 'thiago@email.com',
  joinDate: date('2018-05-14'),
  verified: true,
  followersCount: 42300,
  followingCount: 280,
  interests: ['food', 'cooking', 'gastronomy']
})-[:LOCATED_AT]->(loc1);

CREATE (u15:User {
  userId: 'u015',
  username: '@amanda_pets',
  name: 'Amanda Dias',
  bio: 'Mãe de 4 gatos 🐱 | Pet influencer',
  age: 26,
  email: 'amanda@email.com',
  joinDate: date('2021-09-03'),
  verified: false,
  followersCount: 15600,
  followingCount: 920,
  interests: ['pets', 'cats', 'animals']
})-[:LOCATED_AT]->(loc4);

// Verificar criação
MATCH (u:User) RETURN u.username, u.name, u.verified ORDER BY u.joinDate;
