ALTER TABLE Users
DROP CONSTRAINT PK__Users__3214EC07AFD2B645

ALTER TABLE Users
ADD CONSTRAINT PK_Users PRIMARY KEY (Id, UserName)

SELECT * FROM Users