// ============================================
// RELACIONAMENTOS: CREATED_BY (Artista → Música)
// ============================================

MATCH (a:Artist {artistId: 'artist-001'}), (s:Song) WHERE s.songId IN ['song-001', 'song-002']
CREATE (s)-[:CREATED_BY]->(a);

MATCH (a:Artist {artistId: 'artist-002'}), (s:Song) WHERE s.songId IN ['song-003', 'song-004']
CREATE (s)-[:CREATED_BY]->(a);

MATCH (a:Artist {artistId: 'artist-003'}), (s:Song) WHERE s.songId IN ['song-005', 'song-006']
CREATE (s)-[:CREATED_BY]->(a);

MATCH (a:Artist {artistId: 'artist-004'}), (s:Song) WHERE s.songId IN ['song-007', 'song-008']
CREATE (s)-[:CREATED_BY]->(a);

MATCH (a:Artist {artistId: 'artist-005'}), (s:Song) WHERE s.songId IN ['song-009', 'song-010']
CREATE (s)-[:CREATED_BY]->(a);

MATCH (a:Artist {artistId: 'artist-006'}), (s:Song) WHERE s.songId IN ['song-011', 'song-012']
CREATE (s)-[:CREATED_BY]->(a);

MATCH (a:Artist {artistId: 'artist-007'}), (s:Song) WHERE s.songId IN ['song-013', 'song-014']
CREATE (s)-[:CREATED_BY]->(a);

MATCH (a:Artist {artistId: 'artist-008'}), (s:Song) WHERE s.songId IN ['song-015', 'song-016']
CREATE (s)-[:CREATED_BY]->(a);

MATCH (a:Artist {artistId: 'artist-009'}), (s:Song) WHERE s.songId IN ['song-017', 'song-018']
CREATE (s)-[:CREATED_BY]->(a);

MATCH (a:Artist {artistId: 'artist-010'}), (s:Song) WHERE s.songId IN ['song-019', 'song-020']
CREATE (s)-[:CREATED_BY]->(a);

MATCH (a:Artist {artistId: 'artist-011'}), (s:Song) WHERE s.songId IN ['song-021', 'song-022']
CREATE (s)-[:CREATED_BY]->(a);

MATCH (a:Artist {artistId: 'artist-012'}), (s:Song) WHERE s.songId IN ['song-023', 'song-024']
CREATE (s)-[:CREATED_BY]->(a);

MATCH (a:Artist {artistId: 'artist-013'}), (s:Song) WHERE s.songId IN ['song-025', 'song-026']
CREATE (s)-[:CREATED_BY]->(a);

MATCH (a:Artist {artistId: 'artist-014'}), (s:Song) WHERE s.songId IN ['song-027', 'song-028']
CREATE (s)-[:CREATED_BY]->(a);

MATCH (a:Artist {artistId: 'artist-015'}), (s:Song) WHERE s.songId IN ['song-029', 'song-030']
CREATE (s)-[:CREATED_BY]->(a);

// ============================================
// RELACIONAMENTOS: BELONGS_TO (Música → Gênero)
// ============================================

// Rock
MATCH (s:Song), (g:Genre {genreId: 'rock'})
WHERE s.songId IN ['song-001', 'song-002', 'song-021', 'song-022']
CREATE (s)-[:BELONGS_TO {confidence: 0.95}]->(g);

// Pop
MATCH (s:Song), (g:Genre {genreId: 'pop'})
WHERE s.songId IN ['song-003', 'song-004', 'song-023', 'song-024']
CREATE (s)-[:BELONGS_TO {confidence: 0.95}]->(g);

// Jazz
MATCH (s:Song), (g:Genre {genreId: 'jazz'})
WHERE s.songId IN ['song-005', 'song-006']
CREATE (s)-[:BELONGS_TO {confidence: 1.0}]->(g);

// Eletrônica
MATCH (s:Song), (g:Genre {genreId: 'eletronica'})
WHERE s.songId IN ['song-007', 'song-008']
CREATE (s)-[:BELONGS_TO {confidence: 1.0}]->(g);

// MPB
MATCH (s:Song), (g:Genre {genreId: 'mpb'})
WHERE s.songId IN ['song-009', 'song-010', 'song-025', 'song-026']
CREATE (s)-[:BELONGS_TO {confidence: 0.95}]->(g);

// Indie
MATCH (s:Song), (g:Genre {genreId: 'indie'})
WHERE s.songId IN ['song-011', 'song-012', 'song-027', 'song-028']
CREATE (s)-[:BELONGS_TO {confidence: 0.9}]->(g);

// Hip Hop
MATCH (s:Song), (g:Genre {genreId: 'hiphop'})
WHERE s.songId IN ['song-013', 'song-014', 'song-029', 'song-030']
CREATE (s)-[:BELONGS_TO {confidence: 0.95}]->(g);

// Clássica
MATCH (s:Song), (g:Genre {genreId: 'classica'})
WHERE s.songId IN ['song-015', 'song-016']
CREATE (s)-[:BELONGS_TO {confidence: 1.0}]->(g);

// Sertanejo
MATCH (s:Song), (g:Genre {genreId: 'sertanejo'})
WHERE s.songId IN ['song-017', 'song-018']
CREATE (s)-[:BELONGS_TO {confidence: 1.0}]->(g);

// Metal
MATCH (s:Song), (g:Genre {genreId: 'metal'})
WHERE s.songId IN ['song-019', 'song-020']
CREATE (s)-[:BELONGS_TO {confidence: 0.95}]->(g);

// ============================================
// RELACIONAMENTOS: INFLUENCED_BY (Artista → Artista)
// ============================================

MATCH (a1:Artist {artistId: 'artist-001'}), (a2:Artist {artistId: 'artist-011'})
CREATE (a1)-[:INFLUENCED_BY {era: '1980s', style: 'Progressive Rock'}]->(a2);

MATCH (a1:Artist {artistId: 'artist-006'}), (a2:Artist {artistId: 'artist-011'})
CREATE (a1)-[:INFLUENCED_BY {era: '2000s', style: 'Psychedelic Rock'}]->(a2);

MATCH (a1:Artist {artistId: 'artist-014'}), (a2:Artist {artistId: 'artist-011'})
CREATE (a1)-[:INFLUENCED_BY {era: '1990s', style: 'Art Rock'}]->(a2);

MATCH (a1:Artist {artistId: 'artist-007'}), (a2:Artist {artistId: 'artist-015'})
CREATE (a1)-[:INFLUENCED_BY {era: '2010s', style: 'Conscious Rap'}]->(a2);

MATCH (a1:Artist {artistId: 'artist-012'}), (a2:Artist {artistId: 'artist-002'})
CREATE (a1)-[:INFLUENCED_BY {era: '2010s', style: 'Pop Soul'}]->(a2);

// ============================================
// RELACIONAMENTOS: LISTENED (Usuário → Música)
// ============================================

// Carlos Rock (user-001) - Rock e MPB
MATCH (u:User {userId: 'user-001'}), (s:Song {songId: 'song-001'})
CREATE (u)-[:LISTENED {plays: 45, lastPlayed: datetime(), skipRate: 0.05}]->(s);

MATCH (u:User {userId: 'user-001'}), (s:Song {songId: 'song-002'})
CREATE (u)-[:LISTENED {plays: 38, lastPlayed: datetime(), skipRate: 0.02}]->(s);

MATCH (u:User {userId: 'user-001'}), (s:Song {songId: 'song-021'})
CREATE (u)-[:LISTENED {plays: 52, lastPlayed: datetime(), skipRate: 0.0}]->(s);

MATCH (u:User {userId: 'user-001'}), (s:Song {songId: 'song-022'})
CREATE (u)-[:LISTENED {plays: 41, lastPlayed: datetime(), skipRate: 0.03}]->(s);

MATCH (u:User {userId: 'user-001'}), (s:Song {songId: 'song-009'})
CREATE (u)-[:LISTENED {plays: 25, lastPlayed: datetime(), skipRate: 0.1}]->(s);

// Maria Pop (user-002) - Pop e Indie
MATCH (u:User {userId: 'user-002'}), (s:Song {songId: 'song-003'})
CREATE (u)-[:LISTENED {plays: 67, lastPlayed: datetime(), skipRate: 0.0}]->(s);

MATCH (u:User {userId: 'user-002'}), (s:Song {songId: 'song-004'})
CREATE (u)-[:LISTENED {plays: 54, lastPlayed: datetime(), skipRate: 0.02}]->(s);

MATCH (u:User {userId: 'user-002'}), (s:Song {songId: 'song-023'})
CREATE (u)-[:LISTENED {plays: 48, lastPlayed: datetime(), skipRate: 0.05}]->(s);

MATCH (u:User {userId: 'user-002'}), (s:Song {songId: 'song-011'})
CREATE (u)-[:LISTENED {plays: 32, lastPlayed: datetime(), skipRate: 0.08}]->(s);

MATCH (u:User {userId: 'user-002'}), (s:Song {songId: 'song-012'})
CREATE (u)-[:LISTENED {plays: 28, lastPlayed: datetime(), skipRate: 0.12}]->(s);

// João Jazz (user-003) - Jazz e Clássica
MATCH (u:User {userId: 'user-003'}), (s:Song {songId: 'song-005'})
CREATE (u)-[:LISTENED {plays: 89, lastPlayed: datetime(), skipRate: 0.0}]->(s);

MATCH (u:User {userId: 'user-003'}), (s:Song {songId: 'song-006'})
CREATE (u)-[:LISTENED {plays: 76, lastPlayed: datetime(), skipRate: 0.0}]->(s);

MATCH (u:User {userId: 'user-003'}), (s:Song {songId: 'song-015'})
CREATE (u)-[:LISTENED {plays: 34, lastPlayed: datetime(), skipRate: 0.05}]->(s);

MATCH (u:User {userId: 'user-003'}), (s:Song {songId: 'song-016'})
CREATE (u)-[:LISTENED {plays: 62, lastPlayed: datetime(), skipRate: 0.02}]->(s);

// Ana Eletrônica (user-004) - Eletrônica e Indie
MATCH (u:User {userId: 'user-004'}), (s:Song {songId: 'song-007'})
CREATE (u)-[:LISTENED {plays: 78, lastPlayed: datetime(), skipRate: 0.03}]->(s);

MATCH (u:User {userId: 'user-004'}), (s:Song {songId: 'song-008'})
CREATE (u)-[:LISTENED {plays: 65, lastPlayed: datetime(), skipRate: 0.05}]->(s);

MATCH (u:User {userId: 'user-004'}), (s:Song {songId: 'song-027'})
CREATE (u)-[:LISTENED {plays: 42, lastPlayed: datetime(), skipRate: 0.08}]->(s);

MATCH (u:User {userId: 'user-004'}), (s:Song {songId: 'song-028'})
CREATE (u)-[:LISTENED {plays: 38, lastPlayed: datetime(), skipRate: 0.1}]->(s);

// Pedro MPB (user-005) - MPB e Sertanejo
MATCH (u:User {userId: 'user-005'}), (s:Song {songId: 'song-009'})
CREATE (u)-[:LISTENED {plays: 92, lastPlayed: datetime(), skipRate: 0.0}]->(s);

MATCH (u:User {userId: 'user-005'}), (s:Song {songId: 'song-010'})
CREATE (u)-[:LISTENED {plays: 87, lastPlayed: datetime(), skipRate: 0.0}]->(s);

MATCH (u:User {userId: 'user-005'}), (s:Song {songId: 'song-025'})
CREATE (u)-[:LISTENED {plays: 71, lastPlayed: datetime(), skipRate: 0.02}]->(s);

MATCH (u:User {userId: 'user-005'}), (s:Song {songId: 'song-026'})
CREATE (u)-[:LISTENED {plays: 68, lastPlayed: datetime(), skipRate: 0.03}]->(s);

MATCH (u:User {userId: 'user-005'}), (s:Song {songId: 'song-017'})
CREATE (u)-[:LISTENED {plays: 45, lastPlayed: datetime(), skipRate: 0.15}]->(s);

// Fernanda Indie (user-006) - Indie e Rock Alternativo
MATCH (u:User {userId: 'user-006'}), (s:Song {songId: 'song-011'})
CREATE (u)-[:LISTENED {plays: 56, lastPlayed: datetime(), skipRate: 0.05}]->(s);

MATCH (u:User {userId: 'user-006'}), (s:Song {songId: 'song-012'})
CREATE (u)-[:LISTENED {plays: 61, lastPlayed: datetime(), skipRate: 0.03}]->(s);

MATCH (u:User {userId: 'user-006'}), (s:Song {songId: 'song-027'})
CREATE (u)-[:LISTENED {plays: 49, lastPlayed: datetime(), skipRate: 0.08}]->(s);

MATCH (u:User {userId: 'user-006'}), (s:Song {songId: 'song-028'})
CREATE (u)-[:LISTENED {plays: 53, lastPlayed: datetime(), skipRate: 0.06}]->(s);

// Lucas HipHop (user-007) - Hip Hop
MATCH (u:User {userId: 'user-007'}), (s:Song {songId: 'song-013'})
CREATE (u)-[:LISTENED {plays: 83, lastPlayed: datetime(), skipRate: 0.02}]->(s);

MATCH (u:User {userId: 'user-007'}), (s:Song {songId: 'song-014'})
CREATE (u)-[:LISTENED {plays: 79, lastPlayed: datetime(), skipRate: 0.03}]->(s);

MATCH (u:User {userId: 'user-007'}), (s:Song {songId: 'song-029'})
CREATE (u)-[:LISTENED {plays: 67, lastPlayed: datetime(), skipRate: 0.05}]->(s);

MATCH (u:User {userId: 'user-007'}), (s:Song {songId: 'song-030'})
CREATE (u)-[:LISTENED {plays: 72, lastPlayed: datetime(), skipRate: 0.04}]->(s);

// Juliana Clássica (user-008) - Clássica e Jazz
MATCH (u:User {userId: 'user-008'}), (s:Song {songId: 'song-015'})
CREATE (u)-[:LISTENED {plays: 45, lastPlayed: datetime(), skipRate: 0.0}]->(s);

MATCH (u:User {userId: 'user-008'}), (s:Song {songId: 'song-016'})
CREATE (u)-[:LISTENED {plays: 58, lastPlayed: datetime(), skipRate: 0.0}]->(s);

MATCH (u:User {userId: 'user-008'}), (s:Song {songId: 'song-005'})
CREATE (u)-[:LISTENED {plays: 34, lastPlayed: datetime(), skipRate: 0.02}]->(s);

// Ricardo Sertanejo (user-009) - Sertanejo e MPB
MATCH (u:User {userId: 'user-009'}), (s:Song {songId: 'song-017'})
CREATE (u)-[:LISTENED {plays: 95, lastPlayed: datetime(), skipRate: 0.0}]->(s);

MATCH (u:User {userId: 'user-009'}), (s:Song {songId: 'song-018'})
CREATE (u)-[:LISTENED {plays: 88, lastPlayed: datetime(), skipRate: 0.02}]->(s);

MATCH (u:User {userId: 'user-009'}), (s:Song {songId: 'song-025'})
CREATE (u)-[:LISTENED {plays: 42, lastPlayed: datetime(), skipRate: 0.1}]->(s);

// Beatriz Metal (user-010) - Metal e Rock
MATCH (u:User {userId: 'user-010'}), (s:Song {songId: 'song-019'})
CREATE (u)-[:LISTENED {plays: 74, lastPlayed: datetime(), skipRate: 0.05}]->(s);

MATCH (u:User {userId: 'user-010'}), (s:Song {songId: 'song-020'})
CREATE (u)-[:LISTENED {plays: 69, lastPlayed: datetime(), skipRate: 0.03}]->(s);

MATCH (u:User {userId: 'user-010'}), (s:Song {songId: 'song-001'})
CREATE (u)-[:LISTENED {plays: 38, lastPlayed: datetime(), skipRate: 0.12}]->(s);

MATCH (u:User {userId: 'user-010'}), (s:Song {songId: 'song-021'})
CREATE (u)-[:LISTENED {plays: 52, lastPlayed: datetime(), skipRate: 0.08}]->(s);

// ============================================
// RELACIONAMENTOS: LIKED (Usuário → Música)
// ============================================

// Carlos curte rock
MATCH (u:User {userId: 'user-001'}), (s:Song) WHERE s.songId IN ['song-001', 'song-002', 'song-021', 'song-022']
CREATE (u)-[:LIKED {timestamp: datetime(), rating: 5}]->(s);

// Maria curte pop
MATCH (u:User {userId: 'user-002'}), (s:Song) WHERE s.songId IN ['song-003', 'song-004', 'song-023']
CREATE (u)-[:LIKED {timestamp: datetime(), rating: 5}]->(s);

// João curte jazz
MATCH (u:User {userId: 'user-003'}), (s:Song) WHERE s.songId IN ['song-005', 'song-006', 'song-015', 'song-016']
CREATE (u)-[:LIKED {timestamp: datetime(), rating: 5}]->(s);

// Ana curte eletrônica
MATCH (u:User {userId: 'user-004'}), (s:Song) WHERE s.songId IN ['song-007', 'song-008', 'song-027', 'song-028']
CREATE (u)-[:LIKED {timestamp: datetime(), rating: 4}]->(s);

// Pedro curte MPB
MATCH (u:User {userId: 'user-005'}), (s:Song) WHERE s.songId IN ['song-009', 'song-010', 'song-025', 'song-026']
CREATE (u)-[:LIKED {timestamp: datetime(), rating: 5}]->(s);

// ============================================
// RELACIONAMENTOS: FOLLOWS (Rede Social)
// ============================================

// Carlos segue Maria e João (gostos diferentes, mas amigos)
MATCH (u1:User {userId: 'user-001'}), (u2:User {userId: 'user-002'})
CREATE (u1)-[:FOLLOWS {since: datetime(), strength: 0.8}]->(u2);

MATCH (u1:User {userId: 'user-001'}), (u2:User {userId: 'user-003'})
CREATE (u1)-[:FOLLOWS {since: datetime(), strength: 0.6}]->(u2);

// Maria segue Ana e Fernanda (Pop + Indie + Eletrônica)
MATCH (u1:User {userId: 'user-002'}), (u2:User {userId: 'user-004'})
CREATE (u1)-[:FOLLOWS {since: datetime(), strength: 0.9}]->(u2);

MATCH (u1:User {userId: 'user-002'}), (u2:User {userId: 'user-006'})
CREATE (u1)-[:FOLLOWS {since: datetime(), strength: 0.7}]->(u2);

// João segue Juliana (Jazz + Clássica)
MATCH (u1:User {userId: 'user-003'}), (u2:User {userId: 'user-008'})
CREATE (u1)-[:FOLLOWS {since: datetime(), strength: 0.85}]->(u2);

// Ana segue Fernanda (Indie + Eletrônica)
MATCH (u1:User {userId: 'user-004'}), (u2:User {userId: 'user-006'})
CREATE (u1)-[:FOLLOWS {since: datetime(), strength: 0.75}]->(u2);

// Pedro segue Ricardo (MPB + Sertanejo)
MATCH (u1:User {userId: 'user-005'}), (u2:User {userId: 'user-009'})
CREATE (u1)-[:FOLLOWS {since: datetime(), strength: 0.8}]->(u2);

// Lucas segue Maria (Hip Hop + Pop)
MATCH (u1:User {userId: 'user-007'}), (u2:User {userId: 'user-002'})
CREATE (u1)-[:FOLLOWS {since: datetime(), strength: 0.6}]->(u2);

// Beatriz segue Carlos (Metal + Rock)
MATCH (u1:User {userId: 'user-010'}), (u2:User {userId: 'user-001'})
CREATE (u1)-[:FOLLOWS {since: datetime(), strength: 0.9}]->(u2);

// Verificar relacionamentos
MATCH ()-[r]->() RETURN type(r) as tipo, count(r) as quantidade ORDER BY tipo;
