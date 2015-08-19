/*drop user shaw@localhost;
drop user google@localhost;
drop user microsoft@localhost;
drop user apple@localhost;
drop user xingyang@localhost;
drop user shaine@localhost;
drop user ashwin@localhost;
drop user tanmay@localhost;
drop user vinay@localhost;
drop user admin@localhost;

drop view User_view;
drop view NON_HR;
*/


create user 'shaw'@'localhost' identified by 'shaw';
grant select , update on User to shaw@localhost;
grant select, update on CardDetails to shaw@localhost;
grant select, update on Details to shaw@localhost;
grant select, update on productreview to shaw@localhost;

create view `User_view` as 
select P.Product_ID, P.`name`, p.avgrating, p.numberofdownloads, p.description, p.price, p. multimedialink, C.categoryname,  CO.CompanyName, MU.Album, MU.Length as musiclength,
MU.Singer, MU.SongQuality, MO.Length as movielength, MO.Quality, E.ISBN, E.Author, E.Version, V.VersionNumber, V.Size, V.MobileOS, V.ProductLink, V.VersionDate, V.WhatsNew, 
PR.ReviewTitle, PR.ReviewDate, PR.ReviewDescription, PR.ProdRating
from product as P 
left outer join company as CO on p.Company_ID= co.Company_ID
left join version as V on p.Product_ID=v.Product_ID
left join ebooks as E on e.EProduct_ID=p.Product_ID
left join music as MU on mu.MUProduct_ID=p.Product_ID
left join movie as MO on mo.MOProduct_ID= p.Product_ID
left join game as G on g.GProduct_ID=p.Product_ID
left join app as A on a.AProduct_ID=p.Product_ID
left join categorygenre as C on c.Category_ID=p.Category_ID
left join productreview as PR on PR.product_id=P.Product_ID;


grant select on user_view to shaw@localhost;

create user 'google'@'localhost' identified by 'google';



grant select , update on Company to google@localhost;
grant select , update on accountdetails to google@localhost;
grant select , update on vendor to google@localhost;

grant select , update, insert on product to google@localhost;
grant select , update, insert on version to google@localhost;
grant select , update, insert on app to google@localhost;
grant select , update on Advertiser to google@localhost;
grant select , update on Advertisement to google@localhost;
grant select , update on CardDetails to google@localhost;


create user 'apple'@'localhost' identified by 'apple';

grant select , update on Company to apple@localhost;
grant select , update on Advertiser to apple@localhost;
grant select , update on Advertisement to apple@localhost;
grant select , update on CardDetails to apple@localhost;


create user 'microsoft'@'localhost' identified by 'microsoft';



grant select , update on Company to microsoft@localhost;
grant select , update on accountdetails to microsoft@localhost;
grant select , update on vendor to microsoft@localhost;
grant select , update, insert on product to microsoft@localhost;
grant select , update, insert on version to microsoft@localhost;
grant select , update, insert on app to microsoft@localhost;



create view `NON_HR` as select  EMP_ID, EmpName, EMPdept, Emptype
from Employee;

create user xingyang@localhost identified by 'xingyang';


Grant select ,update on Non_HR to xingyang@localhost;
Grant select ,update on Advertisement to xingyang@localhost;


create user vinay@localhost identified by 'vinay';

Grant select ,update on Non_HR to vinay@localhost;
grant all on product to vinay@localhost;
grant all on music to vinay@localhost;
grant all on movie to vinay@localhost;
grant all on ebooks to vinay@localhost;
grant all on app to vinay@localhost;
grant all on game to vinay@localhost;
grant all on version to vinay@localhost;
grant all on categorygenre to vinay@localhost;


create user tanmay@localhost identified by 'tanmay';
grant all on employee to tanmay@localhost;



create user shaine@localhost identified by 'shaine';
grant all on transaction to shaine@localhost;
grant all on carddetails to shaine@localhost;
grant all on accountdetails to shaine@localhost;
grant select on employee to shaine@localhost;


create user ashwin@localhost identified by 'ashwin';
grant all on mydb.* to ashwin@localhost;
grant all on mydb.user_product to ashwin@localhost;

create user admin@localhost identified by 'admin';
grant all on mydb.* to admin@localhost with grant option; 
