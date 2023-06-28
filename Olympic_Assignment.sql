use sql7;

create table athletes(
	Id int,
    Name varchar(200),
    Sex char(1),
    Age int,
    Height float,
    Weight float,
    Team varchar(200),
    NOC char(3),
    Games varchar(200),
    Year int,
    Season varchar(200),
    City varchar(200),
    Sport varchar(200),
    Event varchar(200),
    Medal Varchar(50));
    
select * from athletes;

SHOW VARIABLES LIKE "secure_file_priv";

-- Load the data from csv file after saving to above location
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Athletes_Cleaned.csv'
into table athletes
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows;

-- View the table
select * from athletes;

-- Q1. Show how many medal counts present for entire data.

select medal,count(medal) from athletes
group by medal;

-- Q2. Show count of unique Sports are present in olympics.

select count(distinct sport) from athletes;

-- Q3. Show how many different medals won by Team India in data.
select distinct medal from athletes;

select team,medal,count(medal) from athletes
where Team='india' and (medal='gold' or medal='silver' or medal='bronze')
group by medal
order by count(medal) desc; 

-- Q4. Show event wise medals won by india show from highest to lowest medals won in order.

select team,event,count(medal) from athletes
where team='india' and medal<>'nomedal' 
group by event
order by count(medal) desc;

-- Q5. Show event and yearwise medals won by india in order of year.

select team,year,event,count(medal) from athletes
where team='india' and medal<>'nomedal'
group by year,event
order by year asc;

-- Q6. Show the country with maximum medals won gold, silver, bronze

select team, count(Medal) from athletes 
where medal<>'nomedal'
group by team
order by count(medal) desc
limit 1;

-- Q7. Show the top 10 countries with respect to gold medals

select team, count(medal) as g_medal from athletes
where medal='gold'
group by team
order by g_medal desc
limit 10;


-- Q8. Show in which year did United States won most medals

select team ,year,count(Medal) from athletes
where team='United States' and medal<>"nomedal"
group by year
order by count(medal) desc
limit 1;

-- Q9. In which sports United States has most medals
select team,sport,count(Medal) from athletes
where team='United States' and medal<>"nomedal"
group by sport
order by count(medal) desc
limit 1;


-- Q10. Find top 3 players who have won most medals along with their sports and country.

select name ,count(medal),team,sport from athletes
where medal<>'nomedal'
group by name , team,sport
order by count(medal) desc
limit 3;


-- Q11. Find player with most gold medals in cycling along with his country.

select name,team,sport,count(medal) as g_medal from athletes
where sport='cycling' and medal='gold'
group by name,sport,team
order by g_medal desc
limit 1;

-- Q12. Find player with most medals (Gold + Silver + Bronze) in Basketball also show his country.

select name ,sport,team,count(medal) from athletes
where sport='Basketball' and medal<>'nomedal'
group by name,sport,team
order by count(medal) desc
limit 1;


-- Q13. Find out the count of different medals of the top basketball player.

select name, medal, count(medal) as medal_count
from athletes
where name='Teresa Edwards' and medal<>'NoMedal'
group by medal
order by medal_count desc;

-- Q14. Find out medals won by male, female each year . Export this data and plot graph in excel.

select year, sex, count(medal) as medal_count 
from athletes
where medal<>'NoMedal'
group by year, sex
order by year asc;


