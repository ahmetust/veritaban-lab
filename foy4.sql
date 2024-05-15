use foy4;
CREATE TABLE client_master (
    client_no NVARCHAR(6) PRIMARY KEY,
    name NVARCHAR(20),
    address1 NVARCHAR(30),
    address2 NVARCHAR(30),
    city NVARCHAR(15),
    state NVARCHAR(15),
    pincode INT,
    bal_due DECIMAL(10, 2)
);

INSERT INTO client_master (client_no, name,city, state, pincode, bal_due) VALUES ('0001', 'Ivan','Bombay', 'Maharashtra', 400054, 15000.00);
INSERT INTO client_master (client_no, name,city, state, pincode, bal_due) VALUES ('0002', 'Vandana','Madras', 'Tamilnadu', 780001, 0.00);
INSERT INTO client_master (client_no, name,city, state, pincode, bal_due) VALUES ('0003', 'Pramada','Bombay', 'Maharashtra', 400057, 5000.00);
INSERT INTO client_master (client_no, name,city, state, pincode, bal_due) VALUES ('0004', 'Basu','Bombay', 'Maharashtra', 400056, 0);
INSERT INTO client_master (client_no, name,city, pincode, bal_due) VALUES ('0005', 'Ravi','Delhi', 100001, 2000.00);
INSERT INTO client_master (client_no, name,city, state, pincode, bal_due) VALUES ('0006', 'Rukmini','Bombay', 'Maharashtra', 400050, 0);


CREATE TABLE product_master (
    product_no NVARCHAR(6) PRIMARY KEY,
    description NVARCHAR(20),
    profit_percent DECIMAL(5,2),
    unit_measure NVARCHAR(30),
    qty_on_hand INT,
    reorder_lvl INT,
    sell_price INT,
    cost_price INT
);
INSERT INTO product_master (product_no, description, profit_percent, unit_measure, qty_on_hand, reorder_lvl, sell_price, cost_price)
VALUES ('P00001','1.44floppies',5,'piece',100,20,525,500);
INSERT INTO product_master (product_no, description, profit_percent, unit_measure, qty_on_hand, reorder_lvl, sell_price, cost_price)
VALUES ('P03453','Monitors',6,'piece',10,3,12000,11200);
INSERT INTO product_master (product_no, description, profit_percent, unit_measure, qty_on_hand, reorder_lvl, sell_price, cost_price)
VALUES ('P06734','Mouse',5,'piece',20,5,1050,500);
INSERT INTO product_master (product_no, description, profit_percent, unit_measure, qty_on_hand, reorder_lvl, sell_price, cost_price)
VALUES ('P07865','1.22floppies',5,'piece',100,20,525,500);
INSERT INTO product_master (product_no, description, profit_percent, unit_measure, qty_on_hand, reorder_lvl, sell_price, cost_price)
VALUES ('P07868','Keyboards',2,'piece',10,3,3150,3050);
INSERT INTO product_master (product_no, description, profit_percent, unit_measure, qty_on_hand, reorder_lvl, sell_price, cost_price)
VALUES ('P07885','CD Drive',2.5,'piece',10,3,5250,5100);
INSERT INTO product_master (product_no, description, profit_percent, unit_measure, qty_on_hand, reorder_lvl, sell_price, cost_price)
VALUES ('P07965','540 HDD',4,'piece',10,3,8400,8000);
INSERT INTO product_master (product_no, description, profit_percent, unit_measure, qty_on_hand, reorder_lvl, sell_price, cost_price)
VALUES ('P07975','1.44 Drive',5,'piece',10,3,1050,1000);
INSERT INTO product_master (product_no, description, profit_percent, unit_measure, qty_on_hand, reorder_lvl, sell_price, cost_price)
VALUES ('P08865','1.22 Drive',5,'piece',2,3,1050,1000);



CREATE TABLE salesman_master (
	salesman_no NVARCHAR(6) PRIMARY KEY,
    sal_name NVARCHAR(20) NOT NULL,
    address NVARCHAR(100) NOT NULL,
    city NVARCHAR(30),
    state NVARCHAR(15),
    pincode INT,
    sal_amt DECIMAL(8,2) NOT NULL,
	tgt_to_get DECIMAL(6,2) NOT NULL,
	ytd_sales DECIMAL(6,2) NOT NULL,
	remarks NVARCHAR(30),
	CONSTRAINT chk_5 CHECK (salesman_no LIKE '5%'),
	CONSTRAINT chk_sal_zero CHECK (sal_amt <> 0),
	CONSTRAINT chk_tgt_zero CHECK (tgt_to_get <> 0),
	CONSTRAINT chk_ytd_zero CHECK (ytd_sales <> 0)
);
INSERT INTO salesman_master (salesman_no, sal_name, address,city,state, pincode, sal_amt, tgt_to_get, ytd_sales,remarks)
VALUES ('500001', 'Kiran', 'A/14 worli','Bombay', 'Mah',400002,3000.00,100,50,'Good');
INSERT INTO salesman_master (salesman_no, sal_name, address,city,state, pincode, sal_amt, tgt_to_get, ytd_sales,remarks)
VALUES ('500002', 'Manish', '65,nariman','Bombay', 'Mah',400001,3000.00,200,100,'Good');
INSERT INTO salesman_master (salesman_no, sal_name, address,city,state, pincode, sal_amt, tgt_to_get, ytd_sales,remarks)
VALUES ('500003', 'Ravi', 'P-7 Bandra','Bombay', 'Mah',400032,3000.00,200,100,'Good');
INSERT INTO salesman_master (salesman_no, sal_name, address,city,state, pincode, sal_amt, tgt_to_get, ytd_sales,remarks)
VALUES ('500004', 'Kiran', 'A/5 Juhu','Bombay', 'Mah',400044,3500.00,200,150,'Good');


CREATE TABLE sales_order (
	s_order_no NVARCHAR(6) PRIMARY KEY,
    s_order_date DATE,
    client_no NVARCHAR(6) FOREIGN KEY REFERENCES client_master(client_no),
    dely_add NVARCHAR(30),
    salesman_no NVARCHAR(6) FOREIGN KEY REFERENCES salesman_master(salesman_no),
	dely_type CHAR DEFAULT 'F' CHECK (dely_type IN ('P', 'F')),
    billed_yn CHAR,
    dely_date DATE,
	order_status NVARCHAR(10),
	CONSTRAINT chk_son CHECK (s_order_no LIKE '0%'),
    CONSTRAINT chk_date CHECK (dely_date >= s_order_date),
	CONSTRAINT chk_os CHECK (order_status IN ('in process', 'fulfilled', 'back order', 'canceled'))
);


INSERT INTO sales_order (s_order_no, s_order_date, client_no, salesman_no, dely_type, billed_yn, dely_date, order_status)
VALUES ('019001', '1996-01-12', '0001', '500001', 'F', 'N', '1996-01-20', 'in process');
INSERT INTO sales_order (s_order_no, s_order_date, client_no, salesman_no, dely_type, billed_yn, dely_date, order_status)
VALUES ('019002', '1996-01-25', '0002', '500002', 'P', 'N', '1996-01-27', 'canceled');
INSERT INTO sales_order (s_order_no, s_order_date, client_no, salesman_no, dely_type, billed_yn, dely_date, order_status)
VALUES ('016865', '1996-02-18', '0003', '500003', 'F', 'Y', '1996-02-20', 'fulfilled');
INSERT INTO sales_order (s_order_no, s_order_date, client_no, salesman_no, dely_type, billed_yn, dely_date, order_status)
VALUES ('019003', '1996-04-03', '0001', '500001', 'F', 'Y', '1996-04-07', 'fulfilled');
INSERT INTO sales_order (s_order_no, s_order_date, client_no, salesman_no, dely_type, billed_yn, dely_date, order_status)
VALUES ('046866', '1996-05-20', '0004', '500002', 'P', 'N', '1996-05-22', 'canceled');
INSERT INTO sales_order (s_order_no, s_order_date, client_no, salesman_no, dely_type, billed_yn, dely_date, order_status)
VALUES ('010008', '1996-05-24', '0005', '500004', 'F', 'N', '1996-05-26', 'in process');




CREATE TABLE sales_order_details (
	s_order_no NVARCHAR(6) FOREIGN KEY REFERENCES sales_order(s_order_no),
    product_no NVARCHAR(6) FOREIGN KEY REFERENCES product_master(product_no),
	qty_order INT,
	qty_disp INT,
	Product_rate DECIMAL(10,2)
);

INSERT INTO sales_order_details (s_order_no, product_no, qty_order, qty_disp, Product_rate)
VALUES ('019001', 'P00001', 4, 4, 525);
INSERT INTO sales_order_details (s_order_no, product_no, qty_order, qty_disp, Product_rate)
VALUES ('019001', 'P07965', 2, 1, 8400);
INSERT INTO sales_order_details (s_order_no, product_no, qty_order, qty_disp, Product_rate)
VALUES ('019001', 'P07885', 2, 1, 5250);
INSERT INTO sales_order_details (s_order_no, product_no, qty_order, qty_disp, Product_rate)
VALUES ('019002', 'P00001', 10, 0, 525);
INSERT INTO sales_order_details (s_order_no, product_no, qty_order, qty_disp, Product_rate)
VALUES ('016865', 'P07868', 3, 3, 3150);
INSERT INTO sales_order_details (s_order_no, product_no, qty_order, qty_disp, Product_rate)
VALUES ('016865', 'P07885', 10, 10, 5250);
INSERT INTO sales_order_details (s_order_no, product_no, qty_order, qty_disp, Product_rate)
VALUES ('019003', 'P00001', 4, 4, 1050);
INSERT INTO sales_order_details (s_order_no, product_no, qty_order, qty_disp, Product_rate)
VALUES ('019003', 'P03453', 2, 2, 1050);
INSERT INTO sales_order_details (s_order_no, product_no, qty_order, qty_disp, Product_rate)
VALUES ('046866', 'P06734', 1, 1, 12000);
INSERT INTO sales_order_details (s_order_no, product_no, qty_order, qty_disp, Product_rate)
VALUES ('046866', 'P07965', 1, 0, 8400);
INSERT INTO sales_order_details (s_order_no, product_no, qty_order, qty_disp, Product_rate)
VALUES ('010008', 'P07975', 1, 0, 1050);
INSERT INTO sales_order_details (s_order_no, product_no, qty_order, qty_disp, Product_rate)
VALUES ('010008', 'P00001', 10, 5, 525);

