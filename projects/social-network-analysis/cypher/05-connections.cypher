// ============================================
// CONEXÕES SOCIAIS - Follows, Friends, Blocks
// ============================================

// FOLLOWS - rede de seguidores (grafo direcionado)
MATCH (u1:User {userId: 'u001'}), (u2:User) WHERE u2.userId IN ['u002', 'u003', 'u004', 'u005', 'u009', 'u012']
CREATE (u1)-[:FOLLOWS {since: date('2021-01-15'), strength: 0.8 + rand()*0.2}]->(u2);

MATCH (u1:User {userId: 'u002'}), (u2:User) WHERE u2.userId IN ['u001', 'u003', 'u010', 'u013']
CREATE (u1)-[:FOLLOWS {since: date('2020-08-10'), strength: 0.7 + rand()*0.3}]->(u2);

MATCH (u1:User {userId: 'u003'}), (u2:User) WHERE u2.userId IN ['u001', 'u002', 'u005', 'u014']
CREATE (u1)-[:FOLLOWS {since: date('2021-06-20'), strength: 0.6 + rand()*0.4}]->(u2);

MATCH (u1:User {userId: 'u004'}), (u2:User) WHERE u2.userId IN ['u001', 'u006', 'u007', 'u011']
CREATE (u1)-[:FOLLOWS {since: date('2019-05-10'), strength: 0.9}]->(u2);

MATCH (u1:User {userId: 'u005'}), (u2:User) WHERE u2.userId IN ['u003', 'u007', 'u008', 'u015']
CREATE (u1)-[:FOLLOWS {since: date('2020-03-15'), strength: 0.75}]->(u2);

MATCH (u1:User {userId: 'u006'}), (u2:User) WHERE u2.userId IN ['u001', 'u004', 'u009', 'u012']
CREATE (u1)-[:FOLLOWS {since: date('2022-05-01'), strength: 0.85}]->(u2);

MATCH (u1:User {userId: 'u007'}), (u2:User) WHERE u2.userId IN ['u003', 'u005', 'u008', 'u014']
CREATE (u1)-[:FOLLOWS {since: date('2021-02-20'), strength: 0.7}]->(u2);

MATCH (u1:User {userId: 'u008'}), (u2:User) WHERE u2.userId IN ['u001', 'u005', 'u009', 'u012']
CREATE (u1)-[:FOLLOWS {since: date('2018-12-01'), strength: 0.9}]->(u2);

MATCH (u1:User {userId: 'u009'}), (u2:User) WHERE u2.userId IN ['u001', 'u004', 'u006', 'u008']
CREATE (u1)-[:FOLLOWS {since: date('2021-09-10'), strength: 0.8}]->(u2);

MATCH (u1:User {userId: 'u010'}), (u2:User) WHERE u2.userId IN ['u002', 'u004', 'u008', 'u013']
CREATE (u1)-[:FOLLOWS {since: date('2019-11-15'), strength: 0.85}]->(u2);

MATCH (u1:User {userId: 'u011'}), (u2:User) WHERE u2.userId IN ['u004', 'u007', 'u009', 'u012']
CREATE (u1)-[:FOLLOWS {since: date('2023-01-10'), strength: 0.75}]->(u2);

MATCH (u1:User {userId: 'u012'}), (u2:User) WHERE u2.userId IN ['u001', 'u006', 'u008', 'u009']
CREATE (u1)-[:FOLLOWS {since: date('2020-07-01'), strength: 0.9}]->(u2);

MATCH (u1:User {userId: 'u013'}), (u2:User) WHERE u2.userId IN ['u002', 'u005', 'u007', 'u010']
CREATE (u1)-[:FOLLOWS {since: date('2021-04-15'), strength: 0.8}]->(u2);

MATCH (u1:User {userId: 'u014'}), (u2:User) WHERE u2.userId IN ['u003', 'u005', 'u007', 'u010']
CREATE (u1)-[:FOLLOWS {since: date('2019-08-20'), strength: 0.85}]->(u2);

MATCH (u1:User {userId: 'u015'}), (u2:User) WHERE u2.userId IN ['u003', 'u005', 'u007', 'u011']
CREATE (u1)-[:FOLLOWS {since: date('2022-02-01'), strength: 0.7}]->(u2);

// FRIENDS_WITH - amizades mútuas (grafo não-direcionado/simétrico)
MATCH (u1:User {userId: 'u001'}), (u2:User {userId: 'u002'})
CREATE (u1)-[:FRIENDS_WITH {since: date('2020-10-15'), interactionCount: 234}]-(u2);

MATCH (u1:User {userId: 'u001'}), (u2:User {userId: 'u009'})
CREATE (u1)-[:FRIENDS_WITH {since: date('2021-08-20'), interactionCount: 189}]-(u2);

MATCH (u1:User {userId: 'u003'}), (u2:User {userId: 'u005'})
CREATE (u1)-[:FRIENDS_WITH {since: date('2021-12-01'), interactionCount: 156}]-(u2);

MATCH (u1:User {userId: 'u004'}), (u2:User {userId: 'u006'})
CREATE (u1)-[:FRIENDS_WITH {since: date('2020-05-10'), interactionCount: 123}]-(u2);

MATCH (u1:User {userId: 'u007'}), (u2:User {userId: 'u014'})
CREATE (u1)-[:FRIENDS_WITH {since: date('2022-03-15'), interactionCount: 98}]-(u2);

MATCH (u1:User {userId: 'u008'}), (u2:User {userId: 'u012'})
CREATE (u1)-[:FRIENDS_WITH {since: date('2019-09-20'), interactionCount: 267}]-(u2);

MATCH (u1:User {userId: 'u010'}), (u2:User {userId: 'u013'})
CREATE (u1)-[:FRIENDS_WITH {since: date('2020-11-05'), interactionCount: 145}]-(u2);

// BLOCKED - bloqueios (relação negativa)
MATCH (u1:User {userId: 'u008'}), (u2:User {userId: 'u004'})
CREATE (u1)-[:BLOCKED {since: date('2023-01-10'), reason: 'spam'}]->(u2);

// Verificar rede
MATCH (u:User)-[r:FOLLOWS|FRIENDS_WITH|BLOCKED]-(other)
RETURN u.username, type(r), other.username LIMIT 20;
