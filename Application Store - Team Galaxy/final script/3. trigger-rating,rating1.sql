delimiter \\
create trigger rating after insert on ProductReview 
for each row
begin
update Product
set avgrating = (select AVG(Prodrating) from productreview where product_id= new.product_id)
where product_id= new.product_id;
End \\
delimiter ;
 


delimiter \\
create trigger rating1 after update on ProductReview 
for each row
begin
update Product
set avgrating = (select AVG(Prodrating) from productreview where product_id= new.product_id) 
where product_id= new.product_id;
End \\
delimiter ;
 

#Run the below command after executing above trigger initially to populate the database

Update mydb.ProductReview
set ProdRating= ProdRating + 0;

