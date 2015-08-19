-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_productdetails`(productid1 int, MobileOS1 varchar(20))
main:BEGIN
if (select Producttype from product where product_id=productid1) = 'AP'
then
select P.name, CO.companyName, C.categoryname, P.Avgrating, P.numberofdownloads, P.description, P.price, 
P.multimedialink, V.Versionnumber, V.mobileos, V.Size, V.Productlink, V.Whatsnew, V.Versiondate
from Product as P left join company as CO on P.Company_id= CO.Company_id
left join categorygenre as C on P.Category_id= C.Category_id
left join version as V on P.Product_id= V.Product_id 
where V.MobileOS= MobileOS1 AND (V.VersionDate= (select max(versiondate) from version where product_id=productid1 AND MobileOS=MobileOS1) 
AND P.Product_id=productid1);
leave main;
end if ;

if (select Producttype from product where product_id=productid1) = 'GA'
then
select P.name, CO.companyName, C.categoryname, P.Avgrating, P.numberofdownloads, P.description, P.price, 
P.multimedialink, V.Versionnumber, V.mobileos, V.Size, V.Productlink, V.Whatsnew, V.Versiondate
from Product as P left join company as CO on P.Company_id= CO.Company_id
left join categorygenre as C on P.Category_id= C.Category_id
left join version as V on P.Product_id= V.Product_id 
where V.MobileOS= MobileOS1 AND (V.VersionDate= (select max(versiondate) from version where product_id=productid1 AND MobileOS=MobileOS1) 
AND P.Product_id=productid1);
leave main;
end if ;

if (select Producttype from product where product_id=productid1) = 'MO'
then
select P.name, CO.companyName, C.categoryname, P.Avgrating, P.numberofdownloads, P.description, P.price, 
P.multimedialink, V.mobileos, V.Size, V.Productlink, V.Versiondate, MO.Length, MO.Quality
from Product as P left join company as CO on P.Company_id= CO.Company_id
left join categorygenre as C on P.Category_id= C.Category_id
left join version as V on P.Product_id= V.Product_id 
left join movie as MO on P.product_id= MO.MOProduct_id
where P.Product_id=productid1;
leave main;
end if ;

if (select Producttype from product where product_id=productid1) = 'MU'
then
select P.name, CO.companyName, C.categoryname, P.Avgrating, P.numberofdownloads, P.description, P.price, 
P.multimedialink, V.mobileos, V.Size, V.Productlink, V.Versiondate, MU.Length, MU.SongQuality, MU.Album, MU.Singer
from Product as P left join company as CO on P.Company_id= CO.Company_id
left join categorygenre as C on P.Category_id= C.Category_id
left join version as V on P.Product_id= V.Product_id 
left join music as MU on P.product_id= MU.MUProduct_id
where P.Product_id=productid1;
leave main;
end if ;

if (select Producttype from product where product_id=productid1) = 'EB'
then
select P.name, CO.companyName, C.categoryname, P.Avgrating, P.numberofdownloads, P.description, P.price, 
P.multimedialink, V.mobileos, V.Size, V.Productlink, V.Versiondate, E.ISBN, E.Author, E.Version
from Product as P left join company as CO on P.Company_id= CO.Company_id
left join categorygenre as C on P.Category_id= C.Category_id
left join version as V on P.Product_id= V.Product_id 
left join Ebooks as E on P.product_id= E.EProduct_id
where P.Product_id=productid1;
leave main;
end if ;
end