// ============================================
// CRIAÇÃO DOS NÓS - 10 Usuários, 10 Filmes/Séries
// ============================================

// --------------------------------------------
// GÊNEROS (6 nós)
// --------------------------------------------
CREATE (g1:Genre {genreId: 'action', name: 'Ação', description: 'Filmes com cenas de ação e aventura'});
CREATE (g2:Genre {genreId: 'drama', name: 'Drama', description: 'Narrativas intensas e emotivas'});
CREATE (g3:Genre {genreId: 'scifi', name: 'Ficção Científica', description: 'Futurismo e tecnologia'});
CREATE (g4:Genre {genreId: 'comedy', name: 'Comédia', description: 'Humor e entretenimento'});
CREATE (g5:Genre {genreId: 'thriller', name: 'Suspense', description: 'Tensão e mistério'});
CREATE (g6:Genre {genreId: 'romance', name: 'Romance', description: 'Histórias de amor'});

// --------------------------------------------
// USUÁRIOS (10 nós)
// --------------------------------------------
CREATE (u1:User {
  userId: 'user-001',
  name: 'Ana Silva',
  email: 'ana.silva@email.com',
  birthDate: date('1990-05-15'),
  country: 'Brasil',
  createdAt: datetime()
});

CREATE (u2:User {
  userId: 'user-002',
  name: 'Bruno Costa',
  email: 'bruno.costa@email.com',
  birthDate: date('1985-08-22'),
  country: 'Brasil',
  createdAt: datetime()
});

CREATE (u3:User {
  userId: 'user-003',
  name: 'Carla Mendes',
  email: 'carla.mendes@email.com',
  birthDate: date('1995-03-10'),
  country: 'Portugal',
  createdAt: datetime()
});

CREATE (u4:User {
  userId: 'user-004',
  name: 'Daniel Oliveira',
  email: 'daniel.oliveira@email.com',
  birthDate: date('1988-11-30'),
  country: 'Brasil',
  createdAt: datetime()
});

CREATE (u5:User {
  userId: 'user-005',
  name: 'Elena Santos',
  email: 'elena.santos@email.com',
  birthDate: date('1992-07-18'),
  country: 'Angola',
  createdAt: datetime()
});

CREATE (u6:User {
  userId: 'user-006',
  name: 'Felipe Martins',
  email: 'felipe.martins@email.com',
  birthDate: date('1987-02-25'),
  country: 'Brasil',
  createdAt: datetime()
});

CREATE (u7:User {
  userId: 'user-007',
  name: 'Gabriela Lima',
  email: 'gabriela.lima@email.com',
  birthDate: date('1993-09-12'),
  country: 'Brasil',
  createdAt: datetime()
});

CREATE (u8:User {
  userId: 'user-008',
  name: 'Henrique Souza',
  email: 'henrique.souza@email.com',
  birthDate: date('1991-04-05'),
  country: 'Portugal',
  createdAt: datetime()
});

CREATE (u9:User {
  userId: 'user-009',
  name: 'Isabela Ferreira',
  email: 'isabela.ferreira@email.com',
  birthDate: date('1989-12-20'),
  country: 'Brasil',
  createdAt: datetime()
});

CREATE (u10:User {
  userId: 'user-010',
  name: 'João Pereira',
  email: 'joao.pereira@email.com',
  birthDate: date('1994-06-08'),
  country: 'Brasil',
  createdAt: datetime()
});

// --------------------------------------------
// FILMES (6 nós)
// --------------------------------------------
CREATE (m1:Movie {
  movieId: 'movie-001',
  title: 'O Poderoso Chefão',
  releaseYear: 1972,
  duration: 175,
  rating: 9.2,
  synopsis: 'A saga da família Corleone, uma das mais poderosas famílias da máfia italiana nos EUA.'
});

CREATE (m2:Movie {
  movieId: 'movie-002',
  title: 'Interestelar',
  releaseYear: 2014,
  duration: 169,
  rating: 8.6,
  synopsis: 'Um grupo de exploradores faz uso de um buraco de minhoca recém-descoberto para superar os limites da viagem espacial.'
});

CREATE (m3:Movie {
  movieId: 'movie-003',
  title: 'Clube da Luta',
  releaseYear: 1999,
  duration: 139,
  rating: 8.8,
  synopsis: 'Um homem deprimido encontra um vendedor de sabão e forma um clube de luta clandestino.'
});

CREATE (m4:Movie {
  movieId: 'movie-004',
  title: 'Pulp Fiction',
  releaseYear: 1994,
  duration: 154,
  rating: 8.9,
  synopsis: 'As vidas de dois assassinos da máfia, um boxeador e outros personagens se entrelaçam em Los Angeles.'
});

CREATE (m5:Movie {
  movieId: 'movie-005',
  title: 'Matrix',
  releaseYear: 1999,
  duration: 136,
  rating: 8.7,
  synopsis: 'Um hacker descobre a verdade sobre sua realidade e seu papel na guerra contra seus controladores.'
});

CREATE (m6:Movie {
  movieId: 'movie-006',
  title: 'O Senhor dos Anéis: A Sociedade do Anel',
  releaseYear: 2001,
  duration: 178,
  rating: 8.8,
  synopsis: 'Um hobbit recebe a missão de destruir um anel mágico que pode salvar ou destruir a Terra Média.'
});

// --------------------------------------------
// SÉRIES (4 nós)
// --------------------------------------------
CREATE (s1:Series {
  seriesId: 'series-001',
  title: 'Breaking Bad',
  releaseYear: 2008,
  seasons: 5,
  episodes: 62,
  status: 'completed'
});

CREATE (s2:Series {
  seriesId: 'series-002',
  title: 'Game of Thrones',
  releaseYear: 2011,
  seasons: 8,
  episodes: 73,
  status: 'completed'
});

CREATE (s3:Series {
  seriesId: 'series-003',
  title: 'Stranger Things',
  releaseYear: 2016,
  seasons: 4,
  episodes: 34,
  status: 'ongoing'
});

CREATE (s4:Series {
  seriesId: 'series-004',
  title: 'The Crown',
  releaseYear: 2016,
  seasons: 6,
  episodes: 60,
  status: 'completed'
});

// --------------------------------------------
// ATORES (8 nós)
// --------------------------------------------
CREATE (a1:Actor {
  actorId: 'actor-001',
  name: 'Marlon Brando',
  birthDate: date('1924-04-03'),
  nationality: 'Americana'
});

CREATE (a2:Actor {
  actorId: 'actor-002',
  name: 'Al Pacino',
  birthDate: date('1940-04-25'),
  nationality: 'Americana'
});

CREATE (a3:Actor {
  actorId: 'actor-003',
  name: 'Matthew McConaughey',
  birthDate: date('1969-11-04'),
  nationality: 'Americana'
});

CREATE (a4:Actor {
  actorId: 'actor-004',
  name: 'Brad Pitt',
  birthDate: date('1963-12-18'),
  nationality: 'Americana'
});

CREATE (a5:Actor {
  actorId: 'actor-005',
  name: 'Keanu Reeves',
  birthDate: date('1964-09-02'),
  nationality: 'Canadense'
});

CREATE (a6:Actor {
  actorId: 'actor-006',
  name: 'Elijah Wood',
  birthDate: date('1981-01-28'),
  nationality: 'Americana'
});

CREATE (a7:Actor {
  actorId: 'actor-007',
  name: 'Bryan Cranston',
  birthDate: date('1956-03-07'),
  nationality: 'Americana'
});

CREATE (a8:Actor {
  actorId: 'actor-008',
  name: 'Emilia Clarke',
  birthDate: date('1986-10-23'),
  nationality 'Britânica'
});

// --------------------------------------------
// DIRETORES (6 nós)
// --------------------------------------------
CREATE (d1:Director {
  directorId: 'director-001',
  name: 'Francis Ford Coppola',
  birthDate: date('1939-04-07'),
  nationality: 'Americana'
});

CREATE (d2:Director {
  directorId: 'director-002',
  name: 'Christopher Nolan',
  birthDate: date('1970-07-30'),
  nationality: 'Britânica'
});

CREATE (d3:Director {
  directorId: 'director-003',
  name: 'David Fincher',
  birthDate: date('1962-08-28'),
  nationality: 'Americana'
});

CREATE (d4:Director {
  directorId: 'director-004',
  name: 'Quentin Tarantino',
  birthDate: date('1963-03-27'),
  nationality 'Americana'
});

CREATE (d5:Director {
  directorId: 'director-005',
  name: 'Lana Wachowski',
  birthDate: date('1965-06-21'),
  nationality: 'Americana'
});

CREATE (d6:Director {
  directorId: 'director-006',
  name: 'Peter Jackson',
  birthDate: date('1961-10-31'),
  nationality: 'Neozelandesa'
});

// Verificar criação
MATCH (n) 
RETURN labels(n) as tipo, count(n) as quantidade;
