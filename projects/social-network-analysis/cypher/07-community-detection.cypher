// ============================================
// DETECÇÃO DE COMUNIDADES - Graph Data Science
// ============================================

// Preparar projeção do grafo para GDS
CALL gds.graph.project(
  'social-graph',
  'User',
  {
    FOLLOWS: {orientation: 'UNDIRECTED'},
    FRIENDS_WITH: {orientation: 'UNDIRECTED'}
  },
  {
    relationshipProperties: ['strength', 'interactionCount']
  }
) YIELD graphName, nodeCount, relationshipCount;

// ------------------------------------------------
// 1. LOUVAIN - Detecção de comunidades
// ------------------------------------------------
CALL gds.louvain.stream('social-graph', {
  relationshipWeightProperty: 'strength',
  maxLevels: 10,
  maxIterations: 100
})
YIELD nodeId, communityId, intermediateCommunityIds
WITH gds.util.asNode(nodeId) as user, communityId
WITH communityId, collect(user.username) as members, count(*) as size
WHERE size >= 2
RETURN communityId,
       size as communitySize,
       members[0..5] as sampleMembers,
       'Comunidade ' + communityId as name
ORDER BY communitySize DESC;

// ------------------------------------------------
// 2. PAGERANK - Influenciadores
// ------------------------------------------------
CALL gds.pageRank.stream('social-graph', {
  relationshipWeightProperty: 'strength',
  maxIterations: 20,
  dampingFactor: 0.85
})
YIELD nodeId, score
WITH gds.util.asNode(nodeId) as user, score
RETURN user.username,
       user.name,
       round(score, 4) as pageRank,
       user.verified as isVerified
ORDER BY score DESC
LIMIT 10;

// ------------------------------------------------
// 3. BETWEENNESS CENTRALITY - Gatekeepers
// ------------------------------------------------
CALL gds.betweenness.stream('social-graph', {
  samplingSize: 15,
  samplingSeed: 42
})
YIELD nodeId, score
WITH gds.util.asNode(nodeId) as user, score
WHERE score > 0
RETURN user.username,
       round(score, 2) as betweennessScore,
       'Conecta comunidades distintas' as role
ORDER BY score DESC
LIMIT 5;

// ------------------------------------------------
// 4. TRIANGLE COUNT - Coesão social
// ------------------------------------------------
CALL gds.triangleCount.stream('social-graph')
YIELD nodeId, triangleCount
WITH gds.util.asNode(nodeId) as user, triangleCount
RETURN user.username,
       triangleCount,
       CASE 
         WHEN triangleCount > 5 THEN 'Rede muito coesa'
         WHEN triangleCount > 2 THEN 'Rede coesa'
         ELSE 'Rede dispersa'
       END as networkDensity
ORDER BY triangleCount DESC;

// ------------------------------------------------
// 5. NODE SIMILARITY - Usuários similares
// ------------------------------------------------
// Criar projeção bipartida User-Topic
CALL gds.graph.project(
  'user-topics',
  ['User', 'Topic'],
  {
    INTERESTED_IN: {
      type: 'POSTED',
      properties: {
        confidence: {
          property: 'confidence',
          defaultValue: 1.0
        }
      }
    }
  }
);

// Similaridade de Jaccard entre usuários
CALL gds.nodeSimilarity.stream('social-graph', {
  topK: 3,
  similarityCutoff: 0.5
})
YIELD node1, node2, similarity
WITH gds.util.asNode(node1) as user1, gds.util.asNode(node2) as user2, similarity
RETURN user1.username + ' ↔ ' + user2.username as pair,
       round(similarity, 3) as similarityScore,
       'Sugestão de conexão' as recommendation
ORDER BY similarity DESC
LIMIT 10;

// Limpar projeções
CALL gds.graph.drop('social-graph');
