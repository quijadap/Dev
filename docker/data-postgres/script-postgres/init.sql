CREATE SCHEMA IF NOT EXISTS worlddb;

DROP TABLE IF EXISTS s_customer;
CREATE TABLE s_customer 
 (id                         VARCHAR(3)  NOT NULL,
  name                       VARCHAR(20) NOT NULL,
  phone                      VARCHAR(20) NOT NULL,
  address                    VARCHAR(20),
  city                       VARCHAR(20),
  state                      VARCHAR(15),
  country                    VARCHAR(20),
  zip_code                   VARCHAR(15),
  credit_rating              VARCHAR(9),
  sales_rep_id               VARCHAR(3),
  region_id                  VARCHAR(3),
  comments                   VARCHAR(255),
  CONSTRAINT s_customer_id_pk PRIMARY KEY (id),
  CONSTRAINT s_customer_credit_rating_ck
  CHECK (credit_rating IN ('EXCELLENT', 'GOOD', 'POOR'))
 );

INSERT INTO s_customer VALUES ('301', 'Sports,Inc', '540-123-4567','72 High St','Harrisonburg', 'VA','US', '22809','EXCELLENT', '12', '1', NULL);
INSERT INTO s_customer VALUES ('302', 'Toms Sporting Goods', '540-987-6543','6741 Main St','Harrisonburg', 'VA','US', '22809','POOR', '14', '1', NULL);
INSERT INTO s_customer VALUES ('303', 'Athletic Attire', '540-123-6789','54 Market St','Harrisonburg', 'VA','US', '22808','GOOD', '14', '1', NULL);
INSERT INTO s_customer VALUES ('304', 'Athletics For All', '540-987-1234','286 Main St', 'Harrisonburg', 'VA','US', '22808','EXCELLENT', '12', '1', NULL);
INSERT INTO s_customer VALUES ('305', 'Shoes for Sports', '540-123-9876','538 High St','Harrisonburg', 'VA','US', '22809','EXCELLENT', '14', '1', NULL);
INSERT INTO s_customer VALUES ('306', 'BJ Athletics', '540-987-9999','632 Water St','Harrisonburg', 'VA','US', '22810','POOR', '12', '1', NULL);
INSERT INTO s_customer VALUES ('403', 'Athletics One', '717-234-6786','912 Columbia Rd','Lancaster', 'PA','US', '17601','GOOD', '14', '1', NULL);
INSERT INTO s_customer VALUES ('404', 'Great Athletes', '717-987-2341','121 Litiz Pike','Lancaster', 'PA','US', '17602','EXCELLENT', '12', '1', NULL);
INSERT INTO s_customer VALUES ('405', 'Athletics Two', '717-987-9875','435 High Rd','Lancaster', 'PA','US', '17602','EXCELLENT', '14', '1', NULL);
INSERT INTO s_customer VALUES ('406', 'Athletes Attic', '717-234-9888','101 Greenfield Rd','Lancaster', 'PA','US', '17601','POOR', '12', '1', NULL);
INSERT INTO s_customer VALUES ('201', 'One Sport', '55-112066222','82 Via Bahia', 'Sao Paolo',NULL, 'Brazil', NULL,'EXCELLENT', '12', '2', NULL);
INSERT INTO s_customer VALUES ('202', 'Deportivo Caracas', '58-28066222','31 Sabana Grande','Caracas', NULL, 'Venezuela', NULL,'EXCELLENT', '12', '2', NULL);
INSERT INTO s_customer VALUES ('203', 'New Delhi Sports', '91-11903338','11368 Chanakya','New Delhi', NULL, 'India', NULL,'GOOD', '11', '4', NULL);
INSERT INTO s_customer VALUES ('204', 'Ladysport', '1-206-104-0111','281 Queen Street','Seattle', 'Washington', 'US', NULL,'EXCELLENT', '11', '1', NULL);
INSERT INTO s_customer VALUES ('205', 'Kim''s Sporting Goods', '852-3693888','15 Henessey Road','Hong Kong', NULL, NULL, NULL,'EXCELLENT', '11', '4', NULL);
INSERT INTO s_customer VALUES ('206', 'Sportique', '33-93425722253','172 Rue de Place','Cannes', NULL, 'France', NULL,'EXCELLENT', '13', '5', NULL);
INSERT INTO s_customer VALUES ('207', 'Tall Rock Sports', '234-16036222','10 Saint Antoine','Lagos', NULL, 'Nigeria', NULL,'GOOD', NULL, '3', NULL);
INSERT INTO s_customer VALUES ('208', 'Muench Sports', '49-895274449','435 Gruenestrasse','Munich', NULL, 'Germany', NULL,'GOOD', '13', '5', NULL);
INSERT INTO s_customer VALUES ('209', 'Beisbol Si!', '809-352666','415 Playa Del Mar', 'San Pedro de Macoris', NULL, 'Dominican Republic', NULL, 'EXCELLENT', '11', '6', NULL);
INSERT INTO s_customer VALUES ('210', 'Futbol Sonora', '52-404555','5 Via Saguaro', 'Nogales',NULL, 'Mexico', NULL,'EXCELLENT', '12', '2', NULL);
INSERT INTO s_customer VALUES ('211', 'Helmut''s Sports', '42-2111222','45 Modrany', 'Prague',NULL, 'Czechoslovakia', NULL,'EXCELLENT', '11', '5', NULL);
INSERT INTO s_customer VALUES ('212', 'Hamada Sport', '20-31209222','47A Corniche', 'Alexandria', NULL, 'Egypt', NULL,'EXCELLENT', '13', '3', NULL);
INSERT INTO s_customer VALUES ('213', 'Sports Emporium', '1-415-555-6281','4783 168th Street','San Francisco', 'CA', 'US', NULL,'EXCELLENT', '11', '1', NULL);
INSERT INTO s_customer VALUES ('214', 'Sports Retail', '1-716-555-7777','115 Main Street','Buffalo', 'NY', 'US', NULL, 'POOR', '11', '1', NULL);
INSERT INTO s_customer VALUES ('215', 'Sports Russia', '7-0953892444','7070 Yekatamina','Saint Petersburg', NULL, 'Russia', NULL,'POOR', '11', '5', NULL);

-- Creation of product table
CREATE TABLE IF NOT EXISTS product (
  product_id INT NOT NULL,
  name varchar(250) NOT NULL,
  PRIMARY KEY (product_id)
);

-- Creation of country table
CREATE TABLE IF NOT EXISTS country (
  country_id INT NOT NULL,
  country_name varchar(450) NOT NULL,
  PRIMARY KEY (country_id)
);
INSERT INTO country VALUES (1, 'Venezuela');
-- Creation of city table
CREATE TABLE IF NOT EXISTS city (
  city_id INT NOT NULL,
  city_name varchar(450) NOT NULL,
  country_id INT NOT NULL,
  PRIMARY KEY (city_id),
  CONSTRAINT fk_country
      FOREIGN KEY(country_id) 
	  REFERENCES country(country_id)
);

-- Creation of store table
CREATE TABLE IF NOT EXISTS store (
  store_id INT NOT NULL,
  name varchar(250) NOT NULL,
  city_id INT NOT NULL,
  PRIMARY KEY (store_id),
  CONSTRAINT fk_city
      FOREIGN KEY(city_id) 
	  REFERENCES city(city_id)
);

-- Creation of user table
CREATE TABLE IF NOT EXISTS users (
  user_id INT NOT NULL,
  name varchar(250) NOT NULL,
  PRIMARY KEY (user_id)
);

-- Creation of status_name table
CREATE TABLE IF NOT EXISTS status_name (
  status_name_id INT NOT NULL,
  status_name varchar(450) NOT NULL,
  PRIMARY KEY (status_name_id)
);

-- Creation of sale table
CREATE TABLE IF NOT EXISTS sale (
  sale_id varchar(200) NOT NULL,
  amount DECIMAL(20,3) NOT NULL,
  date_sale TIMESTAMP,
  product_id INT NOT NULL,
  user_id INT NOT NULL,
  store_id INT NOT NULL, 
  PRIMARY KEY (sale_id),
  CONSTRAINT fk_product
      FOREIGN KEY(product_id) 
	  REFERENCES product(product_id),
  CONSTRAINT fk_user
      FOREIGN KEY(user_id) 
	  REFERENCES users(user_id),
  CONSTRAINT fk_store
      FOREIGN KEY(store_id) 
	  REFERENCES store(store_id)	  
);

-- Creation of order_status table
CREATE TABLE IF NOT EXISTS order_status (
  order_status_id varchar(200) NOT NULL,
  update_at TIMESTAMP,
  sale_id varchar(200) NOT NULL,
  status_name_id INT NOT NULL,
  PRIMARY KEY (order_status_id),
  CONSTRAINT fk_sale
      FOREIGN KEY(sale_id) 
	  REFERENCES sale(sale_id),
  CONSTRAINT fk_status_name
      FOREIGN KEY(status_name_id) 
	  REFERENCES status_name(status_name_id)  
);
