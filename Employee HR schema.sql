/*

CREATE SCHEMA HR;
CREATE SCHEMA Production;
CREATE SCHEMA Sales;
CREATE SCHEMA Stats



CREATE TABLE HR.Employees
(
  empid           INT          NOT NULL,
  lastname        VARCHAR(20) NOT NULL,
  firstname       VARCHAR(10) NOT NULL,
  title           VARCHAR(30) NOT NULL,
  titleofcourtesy VARCHAR(25) NOT NULL,
  birthdate       DATE         NOT NULL,
  hiredate        DATE         NOT NULL,
  address         VARCHAR(60) NOT NULL,
  city            VARCHAR(15) NOT NULL,
  region          VARCHAR(15) NULL,
  postalcode      VARCHAR(10) NULL,
  country         VARCHAR(15) NOT NULL,
  phone           VARCHAR(24) NOT NULL,
  mgrid           INT          NULL
);





CREATE TABLE Production.Suppliers
(
  supplierid   INT          NOT NULL ,
  companyname  varchar(40) NOT NULL,
  contactname  varchar(30) NOT NULL,
  contacttitle varchar(30) NOT NULL,
  address      varchar(60) NOT NULL,
  city         varchar(15) NOT NULL,
  region       varchar(15) NULL,
  postalcode   varchar(10) NULL,
  country      varchar(15) NOT NULL,
  phone        varchar(24) NOT NULL,
  fax          varchar(24) NULL
);



CREATE TABLE Production.Categories
(
  categoryid   INT           NOT NULL ,
  categoryname VARCHAR(15)  NOT NULL,
  description  VARCHAR(200) NOT NULL
  
);




CREATE TABLE Production.Products
(
  productid    INT          NOT NULL ,
  productname  VARCHAR(40) NOT NULL,
  supplierid   INT          NOT NULL,
  categoryid   INT          NOT NULL,
  unitprice    FLOAT        NOT NULL,
  discontinued Boolean          NOT NULL 
);






CREATE TABLE Sales.Customers
(
  custid       INT          NOT NULL ,
  companyname  varchar(40) NOT NULL,
  contactname  varchar(30) NOT NULL,
  contacttitle varchar(30) NOT NULL,
  address      varchar(60) NOT NULL,
  city         varchar(15) NOT NULL,
  region       varchar(15) NULL,
  postalcode   varchar(10) NULL,
  country      varchar(15) NOT NULL,
  phone        varchar(24) NOT NULL,
  fax          varchar(24) NULL
);


CREATE TABLE Sales.Shippers
(
  shipperid   INT          NOT NULL ,
  companyname VARCHAR(40) NOT NULL,
  phone       VARCHAR(24) NOT NULL
);


CREATE TABLE Sales.Orders
(
  orderid        INT          NOT NULL,
  custid         INT          NULL,
  empid          INT          NOT NULL,
  orderdate      DATE         NOT NULL,
  requireddate   DATE         NOT NULL,
  shippeddate    DATE         NULL,
  shipperid      INT          NOT NULL,
  freight        FLOAT        NOT NULL,
  shipname       VARCHAR(40) NOT NULL,
  shipaddress    VARCHAR(60) NOT NULL,
  shipcity       VARCHAR(15) NOT NULL,
  shipregion     VARCHAR(15) NULL,
  shippostalcode VARCHAR(10) NULL,
  shipcountry    VARCHAR(15) NOT NULL
);



CREATE TABLE Sales.OrderDetails
(
  orderid   INT           NOT NULL,
  productid INT           NOT NULL,
  unitprice MONEY         NOT NULL,
  qty       SMALLINT      NOT NULL DEFAULT(1),
  discount  NUMERIC(4, 3) NOT NULL DEFAULT(0)
);



CREATE TABLE Stats.Tests
(
  testid    VARCHAR(10) NOT NULL
);



CREATE TABLE Stats.Scores
(
  testid    VARCHAR(10) NOT NULL,
  studentid VARCHAR(10) NOT NULL,
  score     INT     NOT NULL
);
*/


/* 

-- Employees 


INSERT INTO HR.Employees(empid, lastname, firstname, title, titleofcourtesy, birthdate, hiredate, address, city, region, postalcode, country, phone, mgrid)
  VALUES(1, N'Davis', N'Sara', N'CEO', N'Ms.', '19681208', '20120501', N'7890 - 20th Ave. E., Apt. 2A', N'Seattle', N'WA', N'10003', N'USA', N'(206) 555-0101', NULL);
INSERT INTO HR.Employees(empid, lastname, firstname, title, titleofcourtesy, birthdate, hiredate, address, city, region, postalcode, country, phone, mgrid)
  VALUES(2, N'Funk', N'Don', N'Vice President, Sales', N'Dr.', '19720219', '20120814', N'9012 W. Capital Way', N'Tacoma', N'WA', N'10001', N'USA', N'(206) 555-0100', 1);
INSERT INTO HR.Employees(empid, lastname, firstname, title, titleofcourtesy, birthdate, hiredate, address, city, region, postalcode, country, phone, mgrid)
  VALUES(3, N'Lew', N'Judy', N'Sales Manager', N'Ms.', '19830830', '20120401', N'2345 Moss Bay Blvd.', N'Kirkland', N'WA', N'10007', N'USA', N'(206) 555-0103', 2);
INSERT INTO HR.Employees(empid, lastname, firstname, title, titleofcourtesy, birthdate, hiredate, address, city, region, postalcode, country, phone, mgrid)
  VALUES(4, N'Peled', N'Yael', N'Sales Representative', N'Mrs.', '19570919', '20130503', N'5678 Old Redmond Rd.', N'Redmond', N'WA', N'10009', N'USA', N'(206) 555-0104', 3);
INSERT INTO HR.Employees(empid, lastname, firstname, title, titleofcourtesy, birthdate, hiredate, address, city, region, postalcode, country, phone, mgrid)
  VALUES(5, N'Mortensen', N'Sven', N'Sales Manager', N'Mr.', '19750304', '20131017', N'8901 Garrett Hill', N'London', NULL, N'10004', N'UK', N'(71) 234-5678', 2);
INSERT INTO HR.Employees(empid, lastname, firstname, title, titleofcourtesy, birthdate, hiredate, address, city, region, postalcode, country, phone, mgrid)
  VALUES(6, N'Suurs', N'Paul', N'Sales Representative', N'Mr.', '19830702', '20131017', N'3456 Coventry House, Miner Rd.', N'London', NULL, N'10005', N'UK', N'(71) 345-6789', 5);
INSERT INTO HR.Employees(empid, lastname, firstname, title, titleofcourtesy, birthdate, hiredate, address, city, region, postalcode, country, phone, mgrid)
  VALUES(7, N'King', N'Russell', N'Sales Representative', N'Mr.', '19800529', '20140102', N'6789 Edgeham Hollow, Winchester Way', N'London', NULL, N'10002', N'UK', N'(71) 123-4567', 5);
INSERT INTO HR.Employees(empid, lastname, firstname, title, titleofcourtesy, birthdate, hiredate, address, city, region, postalcode, country, phone, mgrid)
  VALUES(8, N'Cameron', N'Maria', N'Sales Representative', N'Ms.', '19780109', '20140305', N'4567 - 11th Ave. N.E.', N'Seattle', N'WA', N'10006', N'USA', N'(206) 555-0102', 3);
INSERT INTO HR.Employees(empid, lastname, firstname, title, titleofcourtesy, birthdate, hiredate, address, city, region, postalcode, country, phone, mgrid)
  VALUES(9, N'Doyle', N'Patricia', N'Sales Representative', N'Ms.', '19860127', '20141115', N'1234 Houndstooth Rd.', N'London', NULL, N'10008', N'UK', N'(71) 456-7890', 5);



-- Populate table Production.Suppliers


INSERT INTO Production.Suppliers(supplierid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(1, N'Supplier SWRXU', N'Adams, Terry', N'Purchasing Manager', N'2345 Gilbert St.', N'London', NULL, N'10023', N'UK', N'(171) 456-7890', NULL);
INSERT INTO Production.Suppliers(supplierid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(2, N'Supplier VHQZD', N'Hance, Jim', N'Order Administrator', N'P.O. Box 5678', N'New Orleans', N'LA', N'10013', N'USA', N'(100) 555-0111', NULL);
INSERT INTO Production.Suppliers(supplierid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(3, N'Supplier STUAZ', N'Parovszky, Alfons', N'Sales Representative', N'1234 Oxford Rd.', N'Ann Arbor', N'MI', N'10026', N'USA', N'(313) 555-0109', N'(313) 555-0112');
INSERT INTO Production.Suppliers(supplierid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(4, N'Supplier QOVFD', N'Balázs, Erzsébet', N'Marketing Manager', N'7890 Sekimai Musashino-shi', N'Tokyo', NULL, N'10011', N'Japan', N'(03) 6789-0123', NULL);
INSERT INTO Production.Suppliers(supplierid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(5, N'Supplier EQPNC', N'Hofmann, Roland', N'Export Administrator', N'Calle del Rosal 4567', N'Oviedo', N'Asturias', N'10029', N'Spain', N'(98) 123 45 67', NULL);
INSERT INTO Production.Suppliers(supplierid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(6, N'Supplier QWUSF', N'Popkova, Darya', N'Marketing Representative', N'8901 Setsuko Chuo-ku', N'Osaka', NULL, N'10028', N'Japan', N'(06) 789-0123', NULL);
INSERT INTO Production.Suppliers(supplierid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(7, N'Supplier GQRCV', N'Herp, Jesper', N'Marketing Manager', N'5678 Rose St. Moonie Ponds', N'Melbourne', N'Victoria', N'10018', N'Australia', N'(03) 123-4567', N'(03) 456-7890');
INSERT INTO Production.Suppliers(supplierid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(8, N'Supplier BWGYE', N'Iallo, Lucio', N'Sales Representative', N'9012 King''s Way', N'Manchester', NULL, N'10021', N'UK', N'(161) 567-8901', NULL);
INSERT INTO Production.Suppliers(supplierid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(9, N'Supplier QQYEU', N'Basalik, Evan', N'Sales Agent', N'Kaloadagatan 4567', N'Göteborg', NULL, N'10022', N'Sweden', N'031-345 67 89', N'031-678 90 12');
INSERT INTO Production.Suppliers(supplierid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(10, N'Supplier UNAHG', N'Barnett, Dave', N'Marketing Manager', N'Av. das Americanas 2345', N'Sao Paulo', NULL, N'10034', N'Brazil', N'(11) 345 6789', NULL);
INSERT INTO Production.Suppliers(supplierid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(11, N'Supplier ZPYVS', N'Jain, Mukesh', N'Sales Manager', N'Tiergartenstraße 3456', N'Berlin', NULL, N'10016', N'Germany', N'(010) 3456789', NULL);
INSERT INTO Production.Suppliers(supplierid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(12, N'Supplier SVIYA', N'Reagan, April', N'International Marketing Mgr.', N'Bogenallee 9012', N'Frankfurt', NULL, N'10024', N'Germany', N'(069) 234567', NULL);
INSERT INTO Production.Suppliers(supplierid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(13, N'Supplier TEGSC', N'Brehm, Peter', N'Coordinator Foreign Markets', N'Frahmredder 3456', N'Cuxhaven', NULL, N'10019', N'Germany', N'(04721) 1234', N'(04721) 2345');
INSERT INTO Production.Suppliers(supplierid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(14, N'Supplier KEREV', N'Keil, Kendall', N'Sales Representative', N'Viale Dante, 6789', N'Ravenna', NULL, N'10015', N'Italy', N'(0544) 56789', N'(0544) 34567');
INSERT INTO Production.Suppliers(supplierid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(15, N'Supplier NZLIF', N'Sałas-Szlejter, Karolina', N'Marketing Manager', N'Hatlevegen 1234', N'Sandvika', NULL, N'10025', N'Norway', N'(0)9-012345', NULL);
INSERT INTO Production.Suppliers(supplierid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(16, N'Supplier UHZRG', N'Scholl, Thorsten', N'Regional Account Rep.', N'8901 - 8th Avenue Suite 210', N'Bend', N'OR', N'10035', N'USA', N'(503) 555-0108', NULL);
INSERT INTO Production.Suppliers(supplierid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(17, N'Supplier QZGUF', N'Kleinerman, Christian', N'Sales Representative', N'Brovallavägen 0123', N'Stockholm', NULL, N'10033', N'Sweden', N'08-234 56 78', NULL);
INSERT INTO Production.Suppliers(supplierid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(18, N'Supplier LVJUA', N'Canel, Fabrice', N'Sales Manager', N'3456, Rue des Francs-Bourgeois', N'Paris', NULL, N'10031', N'France', N'(1) 90.12.34.56', N'(1) 01.23.45.67');
INSERT INTO Production.Suppliers(supplierid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(19, N'Supplier JDNUG', N'Chapman, Greg', N'Wholesale Account Agent', N'Order Processing Dept. 7890 Paul Revere Blvd.', N'Boston', N'MA', N'10027', N'USA', N'(617) 555-0110', N'(617) 555-0113');
INSERT INTO Production.Suppliers(supplierid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(20, N'Supplier CIYNM', N'Koch, Christine', N'Owner', N'6789 Serangoon Loop, Suite #402', N'Singapore', NULL, N'10037', N'Singapore', N'012-3456', NULL);
INSERT INTO Production.Suppliers(supplierid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(21, N'Supplier XOXZA', N'Shakespear, Paul', N'Sales Manager', N'Lyngbysild Fiskebakken 9012', N'Lyngby', NULL, N'10012', N'Denmark', N'67890123', N'78901234');
INSERT INTO Production.Suppliers(supplierid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(22, N'Supplier FNUXM', N'Skelly, Bonnie L.', N'Accounting Manager', N'Verkoop Rijnweg 8901', N'Zaandam', NULL, N'10014', N'Netherlands', N'(12345) 8901', N'(12345) 5678');
INSERT INTO Production.Suppliers(supplierid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(23, N'Supplier ELCRN', N'Lamb, Karin', N'Product Manager', N'Valtakatu 1234', N'Lappeenranta', NULL, N'10032', N'Finland', N'(953) 78901', NULL);
INSERT INTO Production.Suppliers(supplierid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(24, N'Supplier JNNES', N'Clarkson, John', N'Sales Representative', N'6789 Prince Edward Parade Hunter''s Hill', N'Sydney', N'NSW', N'10030', N'Australia', N'(02) 234-5678', N'(02) 567-8901');
INSERT INTO Production.Suppliers(supplierid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(25, N'Supplier ERVYZ', N'Sprenger, Christof', N'Marketing Manager', N'7890 Rue St. Laurent', N'Montréal', N'Québec', N'10017', N'Canada', N'(514) 456-7890', NULL);
INSERT INTO Production.Suppliers(supplierid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(26, N'Supplier ZWZDM', N'Cunha, Gonçalo', N'Order Administrator', N'Via dei Gelsomini, 5678', N'Salerno', NULL, N'10020', N'Italy', N'(089) 4567890', N'(089) 4567890');
INSERT INTO Production.Suppliers(supplierid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(27, N'Supplier ZRYDZ', N'Paturskis, Leonids', N'Sales Manager', N'4567, rue H. Voiron', N'Montceau', NULL, N'10036', N'France', N'89.01.23.45', NULL);
INSERT INTO Production.Suppliers(supplierid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(28, N'Supplier OAVQT', N'Teper, Jeff', N'Sales Representative', N'Bat. B 2345, rue des Alpes', N'Annecy', NULL, N'10010', N'France', N'01.23.45.67', N'89.01.23.45');
INSERT INTO Production.Suppliers(supplierid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(29, N'Supplier OGLRK', N'Walters, Rob', N'Accounting Manager', N'0123 rue Chasseur', N'Ste-Hyacinthe', N'Québec', N'10009', N'Canada', N'(514) 567-890', N'(514) 678-9012');

-- Populate table Production.Categories

INSERT INTO Production.Categories(categoryid, categoryname, description)
  VALUES(1, N'Beverages', N'Soft drinks, coffees, teas, beers, and ales');
INSERT INTO Production.Categories(categoryid, categoryname, description)
  VALUES(2, N'Condiments', N'Sweet and savory sauces, relishes, spreads, and seasonings');
INSERT INTO Production.Categories(categoryid, categoryname, description)
  VALUES(3, N'Confections', N'Desserts, candies, and sweet breads');
INSERT INTO Production.Categories(categoryid, categoryname, description)
  VALUES(4, N'Dairy Products', N'Cheeses');
INSERT INTO Production.Categories(categoryid, categoryname, description)
  VALUES(5, N'Grains/Cereals', N'Breads, crackers, pasta, and cereal');
INSERT INTO Production.Categories(categoryid, categoryname, description)
  VALUES(6, N'Meat/Poultry', N'Prepared meats');
INSERT INTO Production.Categories(categoryid, categoryname, description)
  VALUES(7, N'Produce', N'Dried fruit and bean curd');
INSERT INTO Production.Categories(categoryid, categoryname, description)
  VALUES(8, N'Seafood', N'Seaweed and fish');

-- Populate table Production.Products

INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(1, N'Product HHYDP', 1, 1, 18.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(2, N'Product RECZE', 1, 1, 19.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(3, N'Product IMEHJ', 1, 2, 10.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(4, N'Product KSBRM', 2, 2, 22.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(5, N'Product EPEIM', 2, 2, 21.35, TRUE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(6, N'Product VAIIV', 3, 2, 25.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(7, N'Product HMLNI', 3, 7, 30.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(8, N'Product WVJFP', 3, 2, 40.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(9, N'Product AOZBW', 4, 6, 97.00, TRUE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(10, N'Product YHXGE', 4, 8, 31.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(11, N'Product QMVUN', 5, 4, 21.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(12, N'Product OSFNS', 5, 4, 38.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(13, N'Product POXFU', 6, 8, 6.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(14, N'Product PWCJB', 6, 7, 23.25, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(15, N'Product KSZOI', 6, 2, 15.50, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(16, N'Product PAFRH', 7, 3, 17.45, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(17, N'Product BLCAX', 7, 6, 39.00, TRUE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(18, N'Product CKEDC', 7, 8, 62.50, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(19, N'Product XKXDO', 8, 3, 9.20, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(20, N'Product QHFFP', 8, 3, 81.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(21, N'Product VJZZH', 8, 3, 10.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(22, N'Product CPHFY', 9, 5, 21.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(23, N'Product JLUDZ', 9, 5, 9.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(24, N'Product QOGNU', 10, 1, 4.50, TRUE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(25, N'Product LYLNI', 11, 3, 14.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(26, N'Product HLGZA', 11, 3, 31.23, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(27, N'Product SMIOH', 11, 3, 43.90, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(28, N'Product OFBNT', 12, 7, 45.60, TRUE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(29, N'Product VJXYN', 12, 6, 123.79, TRUE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(30, N'Product LYERX', 13, 8, 25.89, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(31, N'Product XWOXC', 14, 4, 12.50, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(32, N'Product NUNAW', 14, 4, 32.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(33, N'Product ASTMN', 15, 4, 2.50, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(34, N'Product SWNJY', 16, 1, 14.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(35, N'Product NEVTJ', 16, 1, 18.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(36, N'Product GMKIJ', 17, 8, 19.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(37, N'Product EVFFA', 17, 8, 26.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(38, N'Product QDOMO', 18, 1, 263.50, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(39, N'Product LSOFL', 18, 1, 18.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(40, N'Product YZIXQ', 19, 8, 18.40, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(41, N'Product TTEEX', 19, 8, 9.65, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(42, N'Product RJVNM', 20, 5, 14.00, TRUE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(43, N'Product ZZZHR', 20, 1, 46.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(44, N'Product VJIEO', 20, 2, 19.45, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(45, N'Product AQOKR', 21, 8, 9.50, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(46, N'Product CBRRL', 21, 8, 12.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(47, N'Product EZZPR', 22, 3, 9.50, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(48, N'Product MYNXN', 22, 3, 12.75, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(49, N'Product FPYPN', 23, 3, 20.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(50, N'Product BIUDV', 23, 3, 16.25, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(51, N'Product APITJ', 24, 7, 53.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(52, N'Product QSRXF', 24, 5, 7.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(53, N'Product BKGEA', 24, 6, 32.80, TRUE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(54, N'Product QAQRL', 25, 6, 7.45, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(55, N'Product YYWRT', 25, 6, 24.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(56, N'Product VKCMF', 26, 5, 38.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(57, N'Product OVLQI', 26, 5, 19.50, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(58, N'Product ACRVI', 27, 8, 13.25, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(59, N'Product UKXRI', 28, 4, 55.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(60, N'Product WHBYK', 28, 4, 34.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(61, N'Product XYZPE', 29, 2, 28.50, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(62, N'Product WUXYK', 29, 3, 49.30, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(63, N'Product ICKNK', 7, 2, 43.90, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(64, N'Product HCQDE', 12, 5, 33.25, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(65, N'Product XYWBZ', 2, 2, 21.05, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(66, N'Product LQMGN', 2, 2, 17.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(67, N'Product XLXQF', 16, 1, 14.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(68, N'Product TBTBL', 8, 3, 12.50, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(69, N'Product COAXA', 15, 4, 36.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(70, N'Product TOONT', 7, 1, 15.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(71, N'Product MYMOI', 15, 4, 21.50, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(72, N'Product GEEOO', 14, 4, 34.80, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(73, N'Product WEUJZ', 17, 8, 15.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(74, N'Product BKAZJ', 4, 7, 10.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(75, N'Product BWRLG', 12, 1, 7.75, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(76, N'Product JYGFE', 23, 1, 18.00, FALSE);
INSERT INTO Production.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(77, N'Product LUNZZ', 12, 2, 13.00, FALSE);


INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(1, N'Customer NRZBB', N'Allen, Michael', N'Sales Representative', N'Obere Str. 0123', N'Berlin', NULL, N'10092', N'Germany', N'030-3456789', N'030-0123456');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(2, N'Customer MLTDN', N'Hassall, Mark', N'Owner', N'Avda. de la Constitución 5678', N'México D.F.', NULL, N'10077', N'Mexico', N'(5) 789-0123', N'(5) 456-7890');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(3, N'Customer KBUDE', N'Strome, David', N'Owner', N'Mataderos  7890', N'México D.F.', NULL, N'10097', N'Mexico', N'(5) 123-4567', NULL);
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(4, N'Customer HFBZG', N'Cunningham, Conor', N'Sales Representative', N'7890 Hanover Sq.', N'London', NULL, N'10046', N'UK', N'(171) 456-7890', N'(171) 456-7891');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(5, N'Customer HGVLZ', N'Higginbotham, Tom', N'Order Administrator', N'Berguvsvägen  5678', N'Luleå', NULL, N'10112', N'Sweden', N'0921-67 89 01', N'0921-23 45 67');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(6, N'Customer XHXJV', N'Poland, Carole', N'Sales Representative', N'Forsterstr. 7890', N'Mannheim', NULL, N'10117', N'Germany', N'0621-67890', N'0621-12345');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(7, N'Customer QXVLA', N'Bansal, Dushyant', N'Marketing Manager', N'2345, place Kléber', N'Strasbourg', NULL, N'10089', N'France', N'67.89.01.23', N'67.89.01.24');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(8, N'Customer QUHWH', N'Ilyina, Julia', N'Owner', N'C/ Araquil, 0123', N'Madrid', NULL, N'10104', N'Spain', N'(91) 345 67 89', N'(91) 012 34 56');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(9, N'Customer RTXGC', N'Raghav, Amritansh', N'Owner', N'6789, rue des Bouchers', N'Marseille', NULL, N'10105', N'France', N'23.45.67.89', N'23.45.67.80');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(10, N'Customer EEALV', N'Culp, Scott', N'Accounting Manager', N'8901 Tsawassen Blvd.', N'Tsawassen', N'BC', N'10111', N'Canada', N'(604) 901-2345', N'(604) 678-9012');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(11, N'Customer UBHAU', N'Jaffe, David', N'Sales Representative', N'Fauntleroy Circus 4567', N'London', NULL, N'10064', N'UK', N'(171) 789-0123', NULL);
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(12, N'Customer PSNMQ', N'Ray, Mike', N'Sales Agent', N'Cerrito 3456', N'Buenos Aires', NULL, N'10057', N'Argentina', N'(1) 890-1234', N'(1) 567-8901');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(13, N'Customer VMLOG', N'Benito, Almudena', N'Marketing Manager', N'Sierras de Granada 7890', N'México D.F.', NULL, N'10056', N'Mexico', N'(5) 456-7890', N'(5) 123-4567');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(14, N'Customer WNMAF', N'Jelitto, Jacek', N'Owner', N'Hauptstr. 0123', N'Bern', NULL, N'10065', N'Switzerland', N'0452-678901', NULL);
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(15, N'Customer JUWXK', N'Richardson, Shawn', N'Sales Associate', N'Av. dos Lusíadas, 6789', N'Sao Paulo', N'SP', N'10087', N'Brazil', N'(11) 012-3456', NULL);
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(16, N'Customer GYBBY', N'Birkby, Dana', N'Sales Representative', N'Berkeley Gardens 0123 Brewery', N'London', NULL, N'10039', N'UK', N'(171) 234-5678', N'(171) 234-5679');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(17, N'Customer FEVNN', N'Sun, Nate', N'Order Administrator', N'Walserweg 4567', N'Aachen', NULL, N'10067', N'Germany', N'0241-789012', N'0241-345678');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(18, N'Customer BSVAR', N'Lieber, Justin', N'Owner', N'3456, rue des Cinquante Otages', N'Nantes', NULL, N'10041', N'France', N'89.01.23.45', N'89.01.23.46');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(19, N'Customer RFNQC', N'Boseman, Randall', N'Sales Agent', N'5678 King George', N'London', NULL, N'10110', N'UK', N'(171) 345-6789', N'(171) 345-6780');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(20, N'Customer THHDP', N'Kane, John', N'Sales Manager', N'Kirchgasse 9012', N'Graz', NULL, N'10059', N'Austria', N'1234-5678', N'9012-3456');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(21, N'Customer KIDPX', N'Russo, Giuseppe', N'Marketing Assistant', N'Rua Orós, 3456', N'Sao Paulo', N'SP', N'10096', N'Brazil', N'(11) 456-7890', NULL);
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(22, N'Customer DTDMN', N'Daly, Jim', N'Accounting Manager', N'C/ Moralzarzal, 5678', N'Madrid', NULL, N'10080', N'Spain', N'(91) 890 12 34', N'(91) 567 89 01');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(23, N'Customer WVFAF', N'Liu, Jenny', N'Assistant Sales Agent', N'4567, chaussée de Tournai', N'Lille', NULL, N'10048', N'France', N'45.67.89.01', N'45.67.89.02');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(24, N'Customer CYZTN', N'Grisso, Geoff', N'Owner', N'Åkergatan 5678', N'Bräcke', NULL, N'10114', N'Sweden', N'0695-67 89 01', NULL);
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(25, N'Customer AZJED', N'Carlson, Jason', N'Marketing Manager', N'Berliner Platz 9012', N'München', NULL, N'10091', N'Germany', N'089-8901234', N'089-5678901');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(26, N'Customer USDBG', N'Koch, Paul', N'Marketing Manager', N'9012, rue Royale', N'Nantes', NULL, N'10101', N'France', N'34.56.78.90', N'34.56.78.91');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(27, N'Customer WMFEA', N'Schmöllerl, Martin', N'Sales Representative', N'Via Monte Bianco 4567', N'Torino', NULL, N'10099', N'Italy', N'011-2345678', N'011-9012345');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(28, N'Customer XYUFB', N'Cavaglieri, Giorgio', N'Sales Manager', N'Jardim das rosas n. 8901', N'Lisboa', NULL, N'10054', N'Portugal', N'(1) 456-7890', N'(1) 123-4567');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(29, N'Customer MDLWA', N'Kolesnikova, Katerina', N'Marketing Manager', N'Rambla de Cataluña, 8901', N'Barcelona', NULL, N'10081', N'Spain', N'(93) 789 0123', N'(93) 456 7890');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(30, N'Customer KSLQF', N'Grossman, Seth', N'Sales Manager', N'C/ Romero, 1234', N'Sevilla', NULL, N'10075', N'Spain', N'(95) 901 23 45', NULL);
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(31, N'Customer YJCBX', N'Orint, Neil', N'Sales Associate', N'Av. Brasil, 5678', N'Campinas', N'SP', N'10128', N'Brazil', N'(11) 567-8901', NULL);
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(32, N'Customer YSIQX', N'Krishnan, Venky', N'Marketing Manager', N'6789 Baker Blvd.', N'Eugene', N'OR', N'10070', N'USA', N'(503) 555-0122', NULL);
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(33, N'Customer FVXPQ', N'Yuksel, Ayca', N'Owner', N'5ª Ave. Los Palos Grandes 3456', N'Caracas', N'DF', N'10043', N'Venezuela', N'(2) 789-0123', N'(2) 456-7890');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(34, N'Customer IBVRG', N'Zhang, Frank', N'Accounting Manager', N'Rua do Paço, 7890', N'Rio de Janeiro', N'RJ', N'10076', N'Brazil', N'(21) 789-0123', N'(21) 789-0124');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(35, N'Customer UMTLM', N'Langohr, Kris', N'Sales Representative', N'Carrera 1234 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'10066', N'Venezuela', N'(5) 567-8901', N'(5) 234-5678');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(36, N'Customer LVJSO', N'Smith, Denise', N'Sales Representative', N'City Center Plaza 2345 Main St.', N'Elgin', N'OR', N'10103', N'USA', N'(503) 555-0126', N'(503) 555-0135');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(37, N'Customer FRXZL', N'Óskarsson, Jón Harry', N'Sales Associate', N'9012 Johnstown Road', N'Cork', N'Co. Cork', N'10051', N'Ireland', N'8901 234', N'5678 9012');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(38, N'Customer LJUCA', N'Orton, Jon', N'Marketing Manager', N'Garden House Crowther Way 3456', N'Cowes', N'Isle of Wight', N'10063', N'UK', N'(198) 567-8901', NULL);
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(39, N'Customer GLLAG', N'Song, Lolan', N'Sales Associate', N'Maubelstr. 8901', N'Brandenburg', NULL, N'10060', N'Germany', N'0555-34567', NULL);
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(40, N'Customer EFFTC', N'Owens, Ron', N'Sales Representative', N'2345, avenue de l''Europe', N'Versailles', NULL, N'10108', N'France', N'12.34.56.78', N'12.34.56.79');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(41, N'Customer XIIWM', N'Litton, Tim', N'Sales Manager', N'3456 rue Alsace-Lorraine', N'Toulouse', NULL, N'10053', N'France', N'90.12.34.56', N'90.12.34.57');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(42, N'Customer IAIJK', N'Zaki, Amr', N'Marketing Assistant', N'2345 Oak St.', N'Vancouver', N'BC', N'10098', N'Canada', N'(604) 567-8901', N'(604) 234-5678');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(43, N'Customer UISOJ', N'Wu, Qiong', N'Marketing Manager', N'8901 Orchestra Terrace', N'Walla Walla', N'WA', N'10069', N'USA', N'(509) 555-0119', N'(509) 555-0130');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(44, N'Customer OXFRU', N'Louverdis, George', N'Sales Representative', N'Magazinweg 8901', N'Frankfurt a.M.', NULL, N'10095', N'Germany', N'069-7890123', N'069-4567890');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(45, N'Customer QXPPT', N'Wright, David', N'Owner', N'1234 Polk St. Suite 5', N'San Francisco', N'CA', N'10062', N'USA', N'(415) 555-0118', NULL);
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(46, N'Customer XPNIK', N'Neves, Paulo', N'Accounting Manager', N'Carrera 7890 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'10093', N'Venezuela', N'(9) 789-0123', N'(9) 456-7890');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(47, N'Customer PSQUZ', N'Lupu, Cornel', N'Owner', N'Ave. 5 de Mayo Porlamar 5678', N'I. de Margarita', N'Nueva Esparta', N'10121', N'Venezuela', N'(8) 01-23-45', N'(8) 67-89-01');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(48, N'Customer DVFMB', N'Szymczak, Radosław', N'Sales Manager', N'9012 Chiaroscuro Rd.', N'Portland', N'OR', N'10073', N'USA', N'(503) 555-0117', N'(503) 555-0129');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(49, N'Customer CQRAA', N'Duerr, Bernard', N'Marketing Manager', N'Via Ludovico il Moro 6789', N'Bergamo', NULL, N'10106', N'Italy', N'035-345678', N'035-901234');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(50, N'Customer JYPSC', N'Goldin, Maxim', N'Sales Agent', N'Rue Joseph-Bens 0123', N'Bruxelles', NULL, N'10074', N'Belgium', N'(02) 890 12 34', N'(02) 567 89 01');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(51, N'Customer PVDZC', N'Taylor, Maurice', N'Marketing Assistant', N'8901 rue St. Laurent', N'Montréal', N'Québec', N'10040', N'Canada', N'(514) 345-6789', N'(514) 012-3456');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(52, N'Customer PZNLA', N'Natarajan, Mrina', N'Marketing Assistant', N'Heerstr. 4567', N'Leipzig', NULL, N'10125', N'Germany', N'0342-12345', NULL);
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(53, N'Customer GCJSG', N'Mallit, Ken', N'Sales Associate', N'South House 1234 Queensbridge', N'London', NULL, N'10061', N'UK', N'(171) 890-1234', N'(171) 890-1235');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(54, N'Customer TDKEG', N'Nash, Mike', N'Sales Agent', N'Ing. Gustavo Moncada 0123 Piso 20-A', N'Buenos Aires', NULL, N'10094', N'Argentina', N'(1) 123-4567', N'(1) 890-1234');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(55, N'Customer KZQZT', N'Wood, Robin', N'Sales Representative', N'7890 Bering St.', N'Anchorage', N'AK', N'10050', N'USA', N'(907) 555-0115', N'(907) 555-0128');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(56, N'Customer QNIVZ', N'Miller, Lisa', N'Owner', N'Mehrheimerstr. 9012', N'Köln', NULL, N'10047', N'Germany', N'0221-0123456', N'0221-7890123');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(57, N'Customer WVAXS', N'Tollevsen, Bjørn', N'Owner', N'5678, boulevard Charonne', N'Paris', NULL, N'10085', N'France', N'(1) 89.01.23.45', N'(1) 89.01.23.46');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(58, N'Customer AHXHT', N'Frank, Jill', N'Sales Representative', N'Calle Dr. Jorge Cash 8901', N'México D.F.', NULL, N'10116', N'Mexico', N'(5) 890-1234', N'(5) 567-8901');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(59, N'Customer LOLJO', N'Wang, Tony', N'Sales Manager', N'Geislweg 2345', N'Salzburg', NULL, N'10127', N'Austria', N'4567-8901', N'2345-6789');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(60, N'Customer QZURI', N'Uppal, Sunil', N'Sales Representative', N'Estrada da saúde n. 6789', N'Lisboa', NULL, N'10083', N'Portugal', N'(1) 789-0123', NULL);
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(61, N'Customer WULWD', N'Meisels, Josh', N'Accounting Manager', N'Rua da Panificadora, 1234', N'Rio de Janeiro', N'RJ', N'10115', N'Brazil', N'(21) 678-9012', N'(21) 678-9013');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(62, N'Customer WFIZJ', N'Misiec, Anna', N'Marketing Assistant', N'Alameda dos Canàrios, 1234', N'Sao Paulo', N'SP', N'10102', N'Brazil', N'(11) 901-2345', NULL);
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(63, N'Customer IRRVL', N'Veronesi, Giorgio', N'Accounting Manager', N'Taucherstraße 1234', N'Cunewalde', NULL, N'10126', N'Germany', N'0372-12345', NULL);
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(64, N'Customer LWGMD', N'Gaffney, Lawrie', N'Sales Representative', N'Av. del Libertador 3456', N'Buenos Aires', NULL, N'10124', N'Argentina', N'(1) 234-5678', N'(1) 901-2345');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(65, N'Customer NYUHS', N'Moore, Michael', N'Assistant Sales Representative', N'6789 Milton Dr.', N'Albuquerque', N'NM', N'10109', N'USA', N'(505) 555-0125', N'(505) 555-0134');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(66, N'Customer LHANT', N'Voss, Florian', N'Sales Associate', N'Strada Provinciale 7890', N'Reggio Emilia', NULL, N'10038', N'Italy', N'0522-012345', N'0522-678901');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(67, N'Customer QVEPD', N'Garden, Euan', N'Assistant Sales Agent', N'Av. Copacabana, 6789', N'Rio de Janeiro', N'RJ', N'10052', N'Brazil', N'(21) 345-6789', NULL);
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(68, N'Customer CCKOT', N'Myrcha, Jacek', N'Sales Manager', N'Grenzacherweg 0123', N'Genève', NULL, N'10122', N'Switzerland', N'0897-012345', NULL);
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(69, N'Customer SIUIH', N'Troup, Carol', N'Accounting Manager', N'Gran Vía, 4567', N'Madrid', NULL, N'10071', N'Spain', N'(91) 567 8901', N'(91) 234 5678');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(70, N'Customer TMXGN', N'Makovac, Zrinka', N'Owner', N'Erling Skakkes gate 2345', N'Stavern', NULL, N'10123', N'Norway', N'07-89 01 23', N'07-45 67 89');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(71, N'Customer LCOUJ', N'Navarro, Tomás', N'Sales Representative', N'9012 Suffolk Ln.', N'Boise', N'ID', N'10078', N'USA', N'(208) 555-0116', NULL);
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(72, N'Customer AHPOP', N'Welcker, Brian', N'Sales Manager', N'4567 Wadhurst Rd.', N'London', NULL, N'10088', N'UK', N'(171) 901-2345', N'(171) 901-2346');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(73, N'Customer JMIKW', N'Gonzalez, Nuria', N'Owner', N'Vinbæltet 3456', N'Kobenhavn', NULL, N'10079', N'Denmark', N'12 34 56 78', N'90 12 34 56');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(74, N'Customer YSHXL', N'MacDonald, Scott', N'Marketing Manager', N'9012, rue Lauriston', N'Paris', NULL, N'10058', N'France', N'(1) 23.45.67.89', N'(1) 23.45.67.80');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(75, N'Customer XOJYP', N'Downs, Chris', N'Sales Manager', N'P.O. Box 1234', N'Lander', N'WY', N'10113', N'USA', N'(307) 555-0114', N'(307) 555-0127');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(76, N'Customer SFOGW', N'Luper, Steve', N'Accounting Manager', N'Boulevard Tirou, 2345', N'Charleroi', NULL, N'10100', N'Belgium', N'(071) 56 78 90 12', N'(071) 34 56 78 90');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(77, N'Customer LCYBZ', N'Didcock, Cliff', N'Marketing Manager', N'2345 Jefferson Way Suite 2', N'Portland', N'OR', N'10042', N'USA', N'(503) 555-0120', NULL);
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(78, N'Customer NLTYP', N'Ma, Andrew', N'Marketing Assistant', N'0123 Grizzly Peak Rd.', N'Butte', N'MT', N'10107', N'USA', N'(406) 555-0121', N'(406) 555-0131');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(79, N'Customer FAPSM', N'Wickham, Jim', N'Marketing Manager', N'Luisenstr. 0123', N'Münster', NULL, N'10118', N'Germany', N'0251-456789', N'0251-012345');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(80, N'Customer VONTK', N'Toh, Karen', N'Owner', N'Avda. Azteca 4567', N'México D.F.', NULL, N'10044', N'Mexico', N'(5) 678-9012', NULL);
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(81, N'Customer YQQWW', N'Edwards, Josh', N'Sales Representative', N'Av. Inês de Castro, 1234', N'Sao Paulo', N'SP', N'10120', N'Brazil', N'(11) 123-4567', N'(11) 234-5678');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(82, N'Customer EYHKM', N'Veninga, Tjeerd', N'Sales Associate', N'1234 DaVinci Blvd.', N'Kirkland', N'WA', N'10119', N'USA', N'(206) 555-0124', N'(206) 555-0133');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(83, N'Customer ZRNDE', N'Manar, Karim', N'Sales Manager', N'Smagsloget 3456', N'Århus', NULL, N'10090', N'Denmark', N'23 45 67 89', N'01 23 45 67');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(84, N'Customer NRCSK', N'Tuntisangaroon, Sittichai', N'Sales Agent', N'6789, rue du Commerce', N'Lyon', NULL, N'10072', N'France', N'78.90.12.34', N'78.90.12.35');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(85, N'Customer ENQZT', N'Elliott, Patrick', N'Accounting Manager', N'5678 rue de l''Abbaye', N'Reims', NULL, N'10082', N'France', N'56.78.90.12', N'56.78.90.13');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(86, N'Customer SNXOJ', N'Syamala, Manoj', N'Sales Representative', N'Adenauerallee 7890', N'Stuttgart', NULL, N'10086', N'Germany', N'0711-345678', N'0711-901234');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(87, N'Customer ZHYOS', N'Ludwig, Michael', N'Accounting Manager', N'Torikatu 9012', N'Oulu', NULL, N'10045', N'Finland', N'981-123456', N'981-789012');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(88, N'Customer SRQVM', N'Li, Yan', N'Sales Manager', N'Rua do Mercado, 4567', N'Resende', N'SP', N'10084', N'Brazil', N'(14) 234-5678', NULL);
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(89, N'Customer YBQTI', N'Smith Jr., Ronaldo', N'Owner', N'8901 - 14th Ave. S. Suite 3B', N'Seattle', N'WA', N'10049', N'USA', N'(206) 555-0123', N'(206) 555-0132');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(90, N'Customer XBBVR', N'Larsson, Katarina', N'Owner/Marketing Assistant', N'Keskuskatu 2345', N'Helsinki', NULL, N'10055', N'Finland', N'90-012 3456', N'90-789 0123');
INSERT INTO Sales.Customers(custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(91, N'Customer CCFIZ', N'Vasa, Petr', N'Owner', N'ul. Filtrowa 6789', N'Warszawa', NULL, N'10068', N'Poland', N'(26) 234-5678', N'(26) 901-2345');



INSERT INTO Stats.Scores(testid, studentid, score) VALUES
  ('Test ABC', 'Student A', 95);
INSERT INTO Stats.Scores(testid, studentid, score) VALUES
  ('Test ABC', 'Student B', 80);
INSERT INTO Stats.Scores(testid, studentid, score) VALUES
  ('Test ABC', 'Student C', 55);
INSERT INTO Stats.Scores(testid, studentid, score) VALUES
  ('Test ABC', 'Student D', 55);
INSERT INTO Stats.Scores(testid, studentid, score) VALUES
  ('Test ABC', 'Student E', 50);
INSERT INTO Stats.Scores(testid, studentid, score) VALUES
  ('Test ABC', 'Student F', 80);
INSERT INTO Stats.Scores(testid, studentid, score) VALUES
  ('Test ABC', 'Student G', 95);
INSERT INTO Stats.Scores(testid, studentid, score) VALUES
  ('Test ABC', 'Student H', 65);
INSERT INTO Stats.Scores(testid, studentid, score) VALUES
  ('Test ABC', 'Student I', 75);
INSERT INTO Stats.Scores(testid, studentid, score) VALUES
  ('Test XYZ', 'Student A', 95);
INSERT INTO Stats.Scores(testid, studentid, score) VALUES
  ('Test XYZ', 'Student B', 80);
INSERT INTO Stats.Scores(testid, studentid, score) VALUES
  ('Test XYZ', 'Student C', 55);
INSERT INTO Stats.Scores(testid, studentid, score) VALUES
  ('Test XYZ', 'Student D', 55);
INSERT INTO Stats.Scores(testid, studentid, score) VALUES
  ('Test XYZ', 'Student E', 50);
INSERT INTO Stats.Scores(testid, studentid, score) VALUES
  ('Test XYZ', 'Student F', 80);
INSERT INTO Stats.Scores(testid, studentid, score) VALUES
  ('Test XYZ', 'Student G', 95);
INSERT INTO Stats.Scores(testid, studentid, score) VALUES
  ('Test XYZ', 'Student H', 65);
INSERT INTO Stats.Scores(testid, studentid, score) VALUES
  ('Test XYZ', 'Student I', 75);
INSERT INTO Stats.Scores(testid, studentid, score) VALUES
  ('Test XYZ', 'Student J', 95);
  
  
INSERT INTO Stats.Tests(testid) VALUES ('Test ABC');
INSERT INTO Stats.Tests(testid) VALUES ('Test XYZ');
  
*/






