// ============================================
// USUÁRIOS - 10 perfis de ouvintes
// ============================================

CREATE (u1:User {
  userId: 'user-001',
  name: 'Carlos Rock',
  email: 'carlos.rock@email.com',
  age: 28,
  country: 'Brasil',
  premium: true,
  createdAt: datetime()
});

CREATE (u2:User {
  userId: 'user-002',
  name: 'Maria Pop',
  email: 'maria.pop@email.com',
  age: 24,
  country: 'Brasil',
  premium: true,
  createdAt: datetime()
});

CREATE (u3:User {
  userId: 'user-003',
  name: 'João Jazz',
  email: 'joao.jazz@email.com',
  age: 35,
  country: 'Brasil',
  premium: false,
  createdAt: datetime()
});

CREATE (u4:User {
  userId: 'user-004',
  name: 'Ana Eletrônica',
  email: 'ana.eletro@email.com',
  age: 22,
  country: 'Portugal',
  premium: true,
  createdAt: datetime()
});

CREATE (u5:User {
  userId: 'user-005',
  name: 'Pedro MPB',
  email: 'pedro.mpb@email.com',
  age: 30,
  country: 'Brasil',
  premium: false,
  createdAt: datetime()
});

CREATE (u6:User {
  userId: 'user-006',
  name: 'Fernanda Indie',
  email: 'fernanda.indie@email.com',
  age: 26,
  country: 'Brasil',
  premium: true,
  createdAt: datetime()
});

CREATE (u7:User {
  userId: 'user-007',
  name: 'Lucas HipHop',
  email: 'lucas.hiphop@email.com',
  age: 23,
  country: 'Brasil',
  premium: true,
  createdAt: datetime()
});

CREATE (u8:User {
  userId: 'user-008',
  name: 'Juliana Clássica',
  email: 'juliana.classica@email.com',
  age: 40,
  country: 'Portugal',
  premium: true,
  createdAt: datetime()
});

CREATE (u9:User {
  userId: 'user-009',
  name: 'Ricardo Sertanejo',
  email: 'ricardo.sertanejo@email.com',
  age: 33,
  country: 'Brasil',
  premium: false,
  createdAt: datetime()
});

CREATE (u10:User {
  userId: 'user-010',
  name: 'Beatriz Metal',
  email: 'beatriz.metal@email.com',
  age: 27,
  country: 'Brasil',
  premium: true,
  createdAt: datetime()
});

// Verificar criação
MATCH (u:User) RETURN u.name, u.userId ORDER BY u.userId;
