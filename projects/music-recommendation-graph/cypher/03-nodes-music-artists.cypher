// ============================================
// GÊNEROS MUSICAIS
// ============================================

CREATE (g1:Genre {genreId: 'rock', name: 'Rock', description: 'Música com guitarra elétrica e bateria forte'});
CREATE (g2:Genre {genreId: 'pop', name: 'Pop', description: 'Música popular, catchy e dançante'});
CREATE (g3:Genre {genreId: 'jazz', name: 'Jazz', description: 'Improvisação e swing'});
CREATE (g4:Genre {genreId: 'eletronica', name: 'Eletrônica', description: 'Música produzida digitalmente'});
CREATE (g5:Genre {genreId: 'mpb', name: 'MPB', description: 'Música Popular Brasileira'});
CREATE (g6:Genre {genreId: 'indie', name: 'Indie', description: 'Música independente'});
CREATE (g7:Genre {genreId: 'hiphop', name: 'Hip Hop', description: 'Rap, beats e cultura urbana'});
CREATE (g8:Genre {genreId: 'classica', name: 'Clássica', description: 'Música erudita'});
CREATE (g9:Genre {genreId: 'sertanejo', name: 'Sertanejo', description: 'Música rural brasileira'});
CREATE (g10:Genre {genreId: 'metal', name: 'Metal', description: 'Rock pesado e agressivo'});

// ============================================
// ARTISTAS - 15 artistas variados
// ============================================

CREATE (a1:Artist {
  artistId: 'artist-001',
  name: 'Legião Urbana',
  genre: 'Rock',
  popularity: 95,
  country: 'Brasil',
  formed: 1982
});

CREATE (a2:Artist {
  artistId: 'artist-002',
  name: 'Taylor Swift',
  genre: 'Pop',
  popularity: 98,
  country: 'USA',
  formed: 2006
});

CREATE (a3:Artist {
  artistId: 'artist-003',
  name: 'Miles Davis',
  genre: 'Jazz',
  popularity: 85,
  country: 'USA',
  formed: 1944
});

CREATE (a4:Artist {
  artistId: 'artist-004',
  name: 'Daft Punk',
  genre: 'Eletrônica',
  popularity: 92,
  country: 'França',
  formed: 1993
});

CREATE (a5:Artist {
  artistId: 'artist-005',
  name: 'Chico Buarque',
  genre: 'MPB',
  popularity: 90,
  country: 'Brasil',
  formed: 1966
});

CREATE (a6:Artist {
  artistId: 'artist-006',
  name: 'Arctic Monkeys',
  genre: 'Indie',
  popularity: 88,
  country: 'UK',
  formed: 2002
});

CREATE (a7:Artist {
  artistId: 'artist-007',
  name: 'Kendrick Lamar',
  genre: 'Hip Hop',
  popularity: 94,
  country: 'USA',
  formed: 2003
});

CREATE (a8:Artist {
  artistId: 'artist-008',
  name: 'Beethoven',
  genre: 'Clássica',
  popularity: 99,
  country: 'Alemanha',
  formed: 1770
});

CREATE (a9:Artist {
  artistId: 'artist-009',
  name: 'Jorge e Mateus',
  genre: 'Sertanejo',
  popularity: 91,
  country: 'Brasil',
  formed: 2005
});

CREATE (a10:Artist {
  artistId: 'artist-010',
  name: 'Metallica',
  genre: 'Metal',
  popularity: 96,
  country: 'USA',
  formed: 1981
});

CREATE (a11:Artist {
  artistId: 'artist-011',
  name: 'Pink Floyd',
  genre: 'Rock',
  popularity: 97,
  country: 'UK',
  formed: 1965
});

CREATE (a12:Artist {
  artistId: 'artist-012',
  name: 'Adele',
  genre: 'Pop',
  popularity: 93,
  country: 'UK',
  formed: 2006
});

CREATE (a13:Artist {
  artistId: 'artist-013',
  name: 'Gilberto Gil',
  genre: 'MPB',
  popularity: 89,
  country: 'Brasil',
  formed: 1968
});

CREATE (a14:Artist {
  artistId: 'artist-014',
  name: 'Radiohead',
  genre: 'Indie',
  popularity: 87,
  country: 'UK',
  formed: 1985
});

CREATE (a15:Artist {
  artistId: 'artist-015',
  name: 'Racionais MCs',
  genre: 'Hip Hop',
  popularity: 86,
  country: 'Brasil',
  formed: 1987
});

// ============================================
// MÚSICAS - 30 faixas (2 por artista)
// ============================================

// Legião Urbana (Rock)
CREATE (s1:Song {songId: 'song-001', title: 'Tempo Perdido', duration: 285, releaseYear: 1986});
CREATE (s2:Song {songId: 'song-002', title: 'Sereníssima', duration: 240, releaseYear: 1986});

// Taylor Swift (Pop)
CREATE (s3:Song {songId: 'song-003', title: 'Shake It Off', duration: 219, releaseYear: 2014});
CREATE (s4:Song {songId: 'song-004', title: 'Blank Space', duration: 231, releaseYear: 2014});

// Miles Davis (Jazz)
CREATE (s5:Song {songId: 'song-005', title: 'So What', duration: 565, releaseYear: 1959});
CREATE (s6:Song {songId: 'song-006', title: 'Freddie Freeloader', duration: 585, releaseYear: 1959});

// Daft Punk (Eletrônica)
CREATE (s7:Song {songId: 'song-007', title: 'Get Lucky', duration: 248, releaseYear: 2013});
CREATE (s8:Song {songId: 'song-008', title: 'One More Time', duration: 320, releaseYear: 2001});

// Chico Buarque (MPB)
CREATE (s9:Song {songId: 'song-009', title: 'Construção', duration: 186, releaseYear: 1971});
CREATE (s10:Song {songId: 'song-010', title: 'Cálice', duration: 210, releaseYear: 1973});

// Arctic Monkeys (Indie)
CREATE (s11:Song {songId: 'song-011', title: 'Do I Wanna Know?', duration: 272, releaseYear: 2013});
CREATE (s12:Song {songId: 'song-012', title: 'R U Mine?', duration: 214, releaseYear: 2012});

// Kendrick Lamar (Hip Hop)
CREATE (s13:Song {songId: 'song-013', title: 'HUMBLE.', duration: 177, releaseYear: 2017});
CREATE (s14:Song {songId: 'song-014', title: 'DNA.', duration: 185, releaseYear: 2017});

// Beethoven (Clássica)
CREATE (s15:Song {songId: 'song-015', title: 'Sinfonia No. 9', duration: 3900, releaseYear: 1824});
CREATE (s16:Song {songId: 'song-016', title: 'Moonlight Sonata', duration: 900, releaseYear: 1801});

// Jorge e Mateus (Sertanejo)
CREATE (s17:Song {songId: 'song-017', title: 'Amo Noite e Dia', duration: 195, releaseYear: 2012});
CREATE (s18:Song {songId: 'song-018', title: 'Enquanto Houver Razões', duration: 210, releaseYear: 2015});

// Metallica (Metal)
CREATE (s19:Song {songId: 'song-019', title: 'Enter Sandman', duration: 331, releaseYear: 1991});
CREATE (s20:Song {songId: 'song-020', title: 'Nothing Else Matters', duration: 388, releaseYear: 1991});

// Pink Floyd (Rock)
CREATE (s21:Song {songId: 'song-021', title: 'Comfortably Numb', duration: 382, releaseYear: 1979});
CREATE (s22:Song {songId: 'song-022', title: 'Wish You Were Here', duration: 334, releaseYear: 1975});

// Adele (Pop)
CREATE (s23:Song {songId: 'song-023', title: 'Hello', duration: 295, releaseYear: 2015});
CREATE (s24:Song {songId: 'song-024', title: 'Someone Like You', duration: 285, releaseYear: 2011});

// Gilberto Gil (MPB)
CREATE (s25:Song {songId: 'song-025', title: 'Aquele Abraço', duration: 175, releaseYear: 1969});
CREATE (s26:Song {songId: 'song-026', title: 'Palco', duration: 200, releaseYear: 1981});

// Radiohead (Indie)
CREATE (s27:Song {songId: 'song-027', title: 'Creep', duration: 235, releaseYear: 1992});
CREATE (s28:Song {songId: 'song-028', title: 'Karma Police', duration: 264, releaseYear: 1997});

// Racionais MCs (Hip Hop)
CREATE (s29:Song {songId: 'song-029', title: 'Diário de um Detento', duration: 420, releaseYear: 1997});
CREATE (s30:Song {songId: 'song-030', title: 'Vida Loka Parte 2', duration: 380, releaseYear: 1998});

// Verificar criação
MATCH (n) RETURN labels(n) as tipo, count(n) as quantidade ORDER BY tipo;
