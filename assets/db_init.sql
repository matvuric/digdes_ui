CREATE TABLE t_User(
  id                    TEXT NOT NULL PRIMARY KEY
  ,username             TEXT NOT NULL
  ,email                TEXT NOT NULL
  ,birthDate            TEXT
  ,bio                  TEXT
  ,firstName            TEXT
  ,lastName             TEXT
  ,gender               TEXT
  ,phone                TEXT NOT NULL
  ,isPrivate            BOOLEAN
  ,avatarLink           TEXT
  ,postsCount           INTEGER
  ,followersCount       INTEGER
  ,followingsCount      INTEGER
  ,likesCount           INTEGER
  ,dislikesCount        INTEGER
);
CREATE TABLE t_Post(
  id                    TEXT NOT NULL PRIMARY KEY
  ,caption              TEXT
  ,authorId             TEXT NOT NULL
  ,likesCount           INTEGER
  ,dislikesCount        INTEGER
  ,postsCount           INTEGER
  ,FOREIGN KEY(authorId) REFERENCES t_User(id)
);
CREATE TABLE t_PostAttachment(
  id                    TEXT NOT NULL PRIMARY KEY
  ,[name]               TEXT
  ,mimeType             TEXT
  ,postId               TEXT NOT NULL
  ,attachmentLink       TEXT NOT NULL
  ,FOREIGN KEY(postId) REFERENCES t_Post(id)
);