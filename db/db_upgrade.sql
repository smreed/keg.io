BEGIN TRANSACTION;
	ALTER TABLE user ADD COLUMN email varchar(255);
COMMIT;    

BEGIN TRANSACTION;
	ALTER TABLE user ADD COLUMN twitter_handle varchar(255);
COMMIT;

BEGIN TRANSACTION;
	ALTER TABLE keg ADD COLUMN image_path varchar(255);
COMMIT;