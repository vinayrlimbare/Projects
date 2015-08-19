

create view `Application_view` as
select Product_ID,name,AvgRating,NumberOfDownloads,Description,Price,MultimediaLink,CategoryName,CompanyName,VersionNumber,size, MobileOS,ProductLink, VersionDate,WhatsNew,ProductType
from user_product where ProductType='AP'
order by Product_ID;


create view `Game_view` as
select Product_ID,name,AvgRating,NumberOfDownloads,Description,Price,MultimediaLink,CategoryName,CompanyName,VersionNumber,size, MobileOS,ProductLink, VersionDate,WhatsNew,ProductType
from user_product where ProductType='GA'
order by Product_ID;

create view `Music_view` as
select Product_ID,name,AvgRating,NumberOfDownloads,Description,Price,MultimediaLink,CategoryName,CompanyName,Album,musiclength,Singer,SongQuality
,size,ProductLink, VersionDate,ProductType
from user_product where ProductType='MU'
order by Product_ID;


create view `Movie_view` as
select Product_ID,name,AvgRating,NumberOfDownloads,Description,Price,MultimediaLink,CategoryName,CompanyName,movielength,Quality
size,ProductLink, VersionDate,ProductType
from user_product where ProductType='Mo'
order by Product_ID;


create view `Ebook_view` as
select Product_ID,name,AvgRating,NumberOfDownloads,Description,Price,MultimediaLink,CategoryName,CompanyName,ISBN,Author,Version
size,ProductLink, VersionDate,ProductType
from user_product where ProductType='EB'
order by Product_ID;
