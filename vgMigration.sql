drop table if exists vgGame;
drop table if exists vgGenre;
drop table if exists vgPublisher;
drop table if exists vgPlatform;

#create tables to migrate data into
create table vgPublisher(
	pub_id INT AUTO_INCREMENT PRIMARY KEY,
	publisher_name varchar(50) 
);

create table vgPlatform(
	plat_id INT AUTO_INCREMENT PRIMARY KEY,
	platform_name varchar(50)
);

create table vgGenre(
	genre_id INT AUTO_INCREMENT PRIMARY KEY,
	genre varchar(20)
);


#vgGame will serve as our master table
create table vgGame(
	game_id INT AUTO_INCREMENT PRIMARY KEY,
	name varchar(200),
	year varchar(4),
	NA DECIMAL(5,2),
	EU DECIMAL(5,2),
	JP DECIMAL(5,2),
	Other DECIMAL(5,2),
	genre_id INT,
	plat_id INT,
	pub_id INT,
	CONSTRAINT fk_genre_id
		FOREIGN KEY (genre_id)
		REFERENCES vgGenre(genre_id)
		ON DELETE SET NULL,
	CONSTRAINT fk_plat_id
		FOREIGN KEY (plat_id)
		REFERENCES vgPlatform(plat_id)
		ON DELETE SET NUll,
	CONSTRAINT fk_pub_id
    FOREIGN KEY (pub_id)
    REFERENCES vgPublisher (pub_id)
    ON DELETE SET NULL
);


#use nested queries to insert data into our new tables
insert into vgPublisher(publisher_name) (select unique Publisher from vgbulk);

insert into vgPlatform(platform_name) (select unique Platform from vgbulk);

insert into vgGenre(genre) (select unique Genre from vgbulk);

insert into vgGame(name, year, NA, EU, JP, Other, genre_id, plat_id, pub_id) (select unique Name, Year, NA_Sales, EU_Sales, JP_Sales, Other_Sales, genre_id, plat_id, pub_id from vgbulk vb join vgGenre vg on vb.Genre = vg.genre join vgPlatform as vgp on vb.Platform = vgp.platform_name join vgPublisher as vp on vb.Publisher=vp.publisher_name);
