CREATE DATABASE upsert_demo
GO
USE upsert_demo
GO

--IF EXISTS(select * from users) DROP TABLE users
CREATE TABLE users (
	id INT IDENTITY(1,1) PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(255),
	is_active BIT
);
GO

CREATE PROCEDURE upsert_user
	@id INT,
	@first_name VARCHAR(50),
	@last_name VARCHAR(50),
	@email VARCHAR(255),
	@is_active BIT = 0
AS
BEGIN
	SET NOCOUNT ON;

	IF @id = 0
	BEGIN
		INSERT INTO 
			users (first_name, last_name, email, is_active)
		VALUES 
		    (@first_name, @last_name, @email, @is_active)
	END
	ELSE
	BEGIN
		UPDATE users set first_name=@first_name, last_name=@last_name, email=@email, is_active=@is_active where id = @id
	END
END
GO
