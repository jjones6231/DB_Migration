Drop table if exists vgbulk;
create table vgbulk(
	Rank INT,
	Name varchar(200),
	Platform varchar(50),
	Year varchar(4),
	Genre varchar(20),
	Publisher varchar(50),
	NA_Sales DECIMAL(5,2),
	EU_Sales DECIMAL(5,2),
	JP_Sales DECIMAL(5,2),
	Other_Sales DECIMAL(5,2),
	Global_Sales DECIMAL(5,2)
);

LOAD DATA LOCAL INFILE "vgsales.csv" INTO TABLE Final.vgbulk 
	Fields TERMINATED BY ',' 
	ENCLOSED BY '"' 
	LINES TERMINATED BY '\n';

	

select count(rank) from vgbulk;