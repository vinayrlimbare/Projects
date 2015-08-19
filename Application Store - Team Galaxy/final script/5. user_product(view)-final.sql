CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `mydb`.`user_product` AS
    select 
t.transaction_id,
        `u`.`User_ID` AS `User_id`,
        `u`.`FirstName` AS `FirstName`,
u.lastname,
        `u`.`EmailID` AS `emailid`,
        `u`.`Gender` AS `Gender`,
        `u`.`DateOfBirth` AS `dateofbirth`,
        `u`.`State` AS `state`,
        `u`.`Country` AS `country`,
        `u`.`City` AS `city`,
        `d`.`Details_ID` AS `details_id`,
        `p`.`Product_ID` AS `Product_ID`,
        `p`.`Name` AS `name`,
        `p`.`AvgRating` AS `avgrating`,
        `p`.`NumberOfDownloads` AS `numberofdownloads`,
        `p`.`Description` AS `description`,
        `p`.`Price` AS `price`,
        `p`.`MultimediaLink` AS `multimedialink`,
        `c`.`CategoryName` AS `categoryname`,
        `co`.`CompanyName` AS `CompanyName`,
        `mu`.`Album` AS `Album`,
        `mu`.`Length` AS `musiclength`,
        `mu`.`Singer` AS `Singer`,
        `mu`.`SongQuality` AS `SongQuality`,
        `mo`.`Length` AS `movielength`,
        `mo`.`Quality` AS `Quality`,
        `e`.`ISBN` AS `ISBN`,
        `e`.`Author` AS `Author`,
        `e`.`Version` AS `Version`,
        `v`.`VersionNumber` AS `VersionNumber`,
        `v`.`Size` AS `Size`,
        `v`.`MobileOS` AS `MobileOS`,
        `v`.`ProductLink` AS `ProductLink`,
        `v`.`VersionDate` AS `VersionDate`,
        `v`.`WhatsNew` AS `WhatsNew`,
P.Producttype,
      #  `pr`.`ReviewTitle` AS `ReviewTitle`,
       # `pr`.`ReviewDate` AS `ReviewDate`,
        #`pr`.`ReviewDescription` AS `ReviewDescription`,
        #`pr`.`ProdRating` AS `ProdRating`,
		t.timestamp
    from
        ((((((((((((`mydb`.`transaction` `t`
        left join `mydb`.`details` `d` ON ((`t`.`Details_ID` = `d`.`Details_ID`)))
        left join `mydb`.`user` `u` ON ((`d`.`User_ID` = `u`.`User_ID`)))
        left join `mydb`.`version` `v` ON ((`t`.`Version_ID` = `v`.`Version_ID`)))
        left join `mydb`.`product` `p` ON ((`p`.`Product_ID` = `v`.`Product_ID`)))
        left join `mydb`.`company` `co` ON ((`p`.`Company_ID` = `co`.`Company_ID`)))
        left join `mydb`.`ebooks` `e` ON ((`e`.`EProduct_ID` = `p`.`Product_ID`)))
        left join `mydb`.`music` `mu` ON ((`mu`.`MUProduct_ID` = `p`.`Product_ID`)))
        left join `mydb`.`movie` `mo` ON ((`mo`.`MOProduct_ID` = `p`.`Product_ID`)))
        left join `mydb`.`game` `g` ON ((`g`.`GProduct_ID` = `p`.`Product_ID`)))
        left join `mydb`.`app` `a` ON ((`a`.`AProduct_ID` = `p`.`Product_ID`)))
        left join `mydb`.`categorygenre` `c` ON ((`c`.`Category_ID` = `p`.`Category_ID`))))
     #   left join `mydb`.`productreview` `pr` ON ((`pr`.`Product_ID` = `p`.`Product_ID`)))