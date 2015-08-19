delimiter \\
create trigger numberofdownloads after insert on `transaction`
for each row 
begin
update Product
left join version on product.product_id=version.product_id
left join `transaction` on version.version_id=`transaction`.version_id
set NumberOfDownloads= ( select count(*) from `transaction` where `transaction`.version_id= Version.version_id AND `transaction`.`status`='success')
 - ( select count(*) from `transaction` where `transaction`.version_id= Version.version_id AND `transaction`.`status`='deleted')
where product.product_id=Version.product_id;
 End \\

delimiter ;





#Run the below command after executing above trigger initially to populate the database



insert into `transaction`
values (589,1,1,'success',"2015-01-01 23:54:01",1,42342532);
