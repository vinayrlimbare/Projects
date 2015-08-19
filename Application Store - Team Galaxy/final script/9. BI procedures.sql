#drop procedure sp_top_ten_countries_downloads;

#the BI code to get top ten countries according to number of downloads
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_top_ten_countries_downloads`()
main:BEGIN
select country, count(*)
from user_product
group by Country limit 10;
leave main;
end //
delimiter ;

#call sp_top_ten_countries_downloads;



#drop procedure sp_best_apps_in_each_country;


# Bi code to get best apps in each country
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_best_apps_in_each_country`()
main:BEGIN
select country, `name`, count(*)
from user_product
group by country ,`name`
order by country,count(*) desc;
leave main;
end  //
delimiter ;
#call sp_best_apps_in_each_country;







#drop procedure sp_countrywise_OS_analysis;


#Countrywise OS analysis
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_countrywise_OS_analysis`()
main:BEGIN

select Country, MobileOS, count(*)
from user_product
where MobileOS <> "All Platforms" 
group by Country, MobileOS
order by Country;

leave main;
end  //
delimiter ;

#call sp_countrywise_OS_analysis;




#drop procedure sp_top_ten_apps_last_year;


# BI code to get top ten apps in last year
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_top_ten_apps_last_year`()
main:BEGIN
select `name`, count(*) 
from user_product
where datediff(curdate(),date(Timestamp)) < 366
group by `name`
order by count(*) desc limit 10;
leave main;
end  //
delimiter ;


#call sp_top_ten_apps_last_year;





#drop procedure sp_top_ten_free_apps;


# top  ten free apps + games
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_top_ten_free_apps`()
main:BEGIN
select `name`as "Top Free", categoryname , AVG(avgrating)
from user_product
where 
Price = 0 AND 
ProductType in  ('GA' ,'AP')
group by `name`
order by AvgRating desc limit 10 ;
leave main;
end  //
delimiter ;

#call sp_top_ten_free_apps;











#drop procedure sp_top_ten_paid_apps;


# top ten paid apps + games
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_top_ten_paid_apps`()
main:BEGIN
select `name`as "Top Free", categoryname , AVG(avgrating)
from user_product
where 
Price <> 0 AND 
ProductType in  ('GA' ,'AP')
group by `name`
order by AvgRating desc limit 10;
leave main;
end  //
delimiter ;


#call sp_top_ten_paid_apps;










#drop procedure sp_top_ten_most_downloaded_apps;


# top ten most downloaded apps + games
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_top_ten_most_downloaded_apps`()
main:BEGIN
select `Name` as "Most Downloaded", categoryname , SUM(numberofdownloads)
from user_product
where ProductType in  ('GA' ,'AP')
group by `name`
order by numberofdownloads desc limit 10;
leave main;
end  //
delimiter ;


#call sp_top_ten_most_downloaded_apps;








#drop procedure sp_top_ten_companies_downloads;


#top ten companies(with highest number of downloads)
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_top_ten_companies_downloads`()
main:BEGIN
select companyName, count(*)
from user_product
group by companyName
order by count(*) desc limit 10;
leave main;
end  //
delimiter ;

#call sp_top_ten_companies_downloads;








#drop procedure sp_top_ten_companies_sales;



#top ten companies with highest sales
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_top_ten_companies_sales`()
main:BEGIN
select companyName, SUM(price) as "Sales in $"
from user_product
group by companyName
order by sum(price) desc limit 10;
leave main;
end  //
delimiter ;


#call sp_top_ten_companies_sales;