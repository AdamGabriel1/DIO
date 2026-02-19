// ============================================
// SCHEMA E CONSTRAINTS - Rede Social
// ============================================

// Constraints de unicidade
CREATE CONSTRAINT user_id_unique IF NOT EXISTS
FOR (u:User) REQUIRE u.userId IS UNIQUE;

CREATE CONSTRAINT username_unique IF NOT EXISTS
FOR (u:User) REQUIRE u.username IS UNIQUE;

CREATE CONSTRAINT post_id_unique IF NOT EXISTS
FOR (p:Post) REQUIRE p.postId IS UNIQUE;

CREATE CONSTRAINT comment_id_unique IF NOT EXISTS
FOR (c:Comment) REQUIRE c.commentId IS UNIQUE;

CREATE CONSTRAINT hashtag_tag_unique IF NOT EXISTS
FOR (h:Hashtag) REQUIRE h.tag IS UNIQUE;

CREATE CONSTRAINT topic_id_unique IF NOT EXISTS
FOR (t:Topic) REQUIRE t.topicId IS UNIQUE;

CREATE CONSTRAINT location_id_unique IF NOT EXISTS
FOR (l:Location) REQUIRE l.locationId IS UNIQUE;

// Índices para performance
CREATE INDEX user_name_index IF NOT EXISTS
FOR (u:User) ON (u.name);

CREATE INDEX post_timestamp_index IF NOT EXISTS
FOR (p:Post) ON (p.timestamp);

CREATE INDEX interaction_timestamp IF NOT EXISTS
FOR ()-[r:LIKED|COMMENTED|SHARED|VIEWED]-() ON (r.timestamp);

// Índice composto para queries temporais
CREATE INDEX post_temporal IF NOT EXISTS
FOR (p:Post) ON (p.timestamp, p.type);

// Full-text search para conteúdo
CALL db.index.fulltext.createNodeIndex('postContent', ['Post', 'Comment'], ['content', 'text']);

SHOW CONSTRAINTS;
SHOW INDEXES;
