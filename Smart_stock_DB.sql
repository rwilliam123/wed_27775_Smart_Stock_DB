-- PRODUCTS TABLE
CREATE TABLE Products (
  ProductID VARCHAR2(10) PRIMARY KEY,
  Name VARCHAR2(50) NOT NULL,
  Category VARCHAR2(30),
  Price DECIMAL(10,2) CHECK (Price >= 0),
  StockQuantity INT CHECK (StockQuantity >= 0)
);

-- SUPPLIERS TABLE
CREATE TABLE Suppliers (
  SupplierID VARCHAR2(10) PRIMARY KEY,
  Name VARCHAR2(50) NOT NULL,
  Contact VARCHAR2(50),
  DeliveryTime INT CHECK (DeliveryTime >= 0)
);

-- SALES TABLE
CREATE TABLE Sales (
  SaleID VARCHAR2(10) PRIMARY KEY,
  ProductID VARCHAR2(10),
  QuantitySold INT CHECK (QuantitySold >= 1),
  SaleDate DATE,
  CONSTRAINT fk_sales_product FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- ORDERS TABLE
CREATE TABLE Orders (
  OrderID VARCHAR2(10) PRIMARY KEY,
  ProductID VARCHAR2(10),
  SupplierID VARCHAR2(10),
  QuantityOrdered INT CHECK (QuantityOrdered > 0),
  OrderDate DATE,
  Status VARCHAR2(20) DEFAULT 'Pending',
  CONSTRAINT fk_orders_product FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
  CONSTRAINT fk_orders_supplier FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);


-- INSERT PRODUCTS
INSERT INTO Products VALUES ('P001', 'Laptop', 'Electronics', 1200.00, 20);
INSERT INTO Products VALUES ('P002', 'Phone', 'Electronics', 800.00, 50);
INSERT INTO Products VALUES ('P003', 'Desk Chair', 'Furniture', 150.00, 10);
INSERT INTO Products VALUES ('P004', 'Headphones', 'Accessories', 90.00, 30);

-- INSERT SUPPLIERS
INSERT INTO Suppliers VALUES ('S001', 'Tech Supplier', 'tech@supplier.com', 3);
INSERT INTO Suppliers VALUES ('S002', 'Gadget Co', 'contact@gadget.com', 5);
INSERT INTO Suppliers VALUES ('S003', 'Gadget Hub', 'hello@gadgethub.com', 4);
INSERT INTO Suppliers VALUES ('S004', 'Accessories Ltd', 'sales@accessories.com', 2);
-- INSERT SALES
INSERT INTO Sales VALUES ('S001', 'P001', 2, TO_DATE('2025-05-15', 'YYYY-MM-DD'));
INSERT INTO Sales VALUES ('S002', 'P002', 1, TO_DATE('2025-05-16', 'YYYY-MM-DD'));
INSERT INTO Sales VALUES ('S003', 'P004', 3, TO_DATE('2025-05-17', 'YYYY-MM-DD'));
INSERT INTO Sales VALUES ('S004', 'P003', 1, TO_DATE('2025-05-18', 'YYYY-MM-DD'));

-- INSERT ORDERS
INSERT INTO Orders VALUES ('O001', 'P001', 'S001', 10, TO_DATE('2025-05-14', 'YYYY-MM-DD'), 'Pending');
INSERT INTO Orders VALUES ('O002', 'P002', 'S002', 15, TO_DATE('2025-05-14', 'YYYY-MM-DD'), 'Delivered');
INSERT INTO Orders VALUES ('O003', 'P004', 'S004', 15, TO_DATE('2025-05-12', 'YYYY-MM-DD'), 'Pending');
INSERT INTO Orders VALUES ('O004', 'P002', 'S003', 7, TO_DATE('2025-05-11', 'YYYY-MM-DD'), 'Delivered');



CREATE OR REPLACE PROCEDURE Get_Stock_Info(p_ProductID IN VARCHAR2) AS
  v_Name Products.Name%TYPE;
  v_Stock Products.StockQuantity%TYPE;
BEGIN
  SELECT Name, StockQuantity INTO v_Name, v_Stock
  FROM Products
  WHERE ProductID = p_ProductID;

  DBMS_OUTPUT.PUT_LINE('Product: ' || v_Name || ' | Stock: ' || v_Stock);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No product found with ID ' || p_ProductID);
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
END;


CREATE OR REPLACE FUNCTION Get_Total_Sales(p_ProductID IN VARCHAR2)
RETURN NUMBER IS
  v_Total NUMBER;
BEGIN
  SELECT SUM(QuantitySold) INTO v_Total
  FROM Sales
  WHERE ProductID = p_ProductID;

  RETURN NVL(v_Total, 0);
EXCEPTION
  WHEN OTHERS THEN
    RETURN -1;
END;




DECLARE
  CURSOR low_stock_cur IS
    SELECT ProductID, Name, StockQuantity
    FROM Products
    WHERE StockQuantity < 15;

  v_ID Products.ProductID%TYPE;
  v_Name Products.Name%TYPE;
  v_Stock Products.StockQuantity%TYPE;
BEGIN
  OPEN low_stock_cur;
  LOOP
    FETCH low_stock_cur INTO v_ID, v_Name, v_Stock;
    EXIT WHEN low_stock_cur%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Product ' || v_Name || ' is low on stock: ' || v_Stock);
  END LOOP;
  CLOSE low_stock_cur;
END;


-- Package Spec
CREATE OR REPLACE PACKAGE Stock_Package AS
  PROCEDURE Get_Stock_Info(p_ProductID IN VARCHAR2);
  FUNCTION Get_Total_Sales(p_ProductID IN VARCHAR2) RETURN NUMBER;
END Stock_Package;




-- Package Body
CREATE OR REPLACE PACKAGE BODY Stock_Package AS

  PROCEDURE Get_Stock_Info(p_ProductID IN VARCHAR2) AS
    v_Name Products.Name%TYPE;
    v_Stock Products.StockQuantity%TYPE;
  BEGIN
    SELECT Name, StockQuantity INTO v_Name, v_Stock
    FROM Products
    WHERE ProductID = p_ProductID;
    DBMS_OUTPUT.PUT_LINE('Product: ' || v_Name || ' | Stock: ' || v_Stock);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Product not found.');
  END;

  FUNCTION Get_Total_Sales(p_ProductID IN VARCHAR2)
  RETURN NUMBER IS
    v_Total NUMBER;
  BEGIN
    SELECT SUM(QuantitySold) INTO v_Total
    FROM Sales
    WHERE ProductID = p_ProductID;
    RETURN NVL(v_Total, 0);
  END;

END Stock_Package;




-- Enabling output 
SET SERVEROUTPUT ON;

-- Run procedures
EXEC Get_Stock_Info('P001');
SELECT Get_Total_Sales('P001') FROM dual;

-- Call from package
EXEC Stock_Package.Get_Stock_Info('P002');
SELECT Stock_Package.Get_Total_Sales('P002') FROM dual;


CREATE TABLE Holidays (
  HolidayDate DATE PRIMARY KEY,
  Description VARCHAR2(100)
);



INSERT INTO Holidays VALUES (TO_DATE('2025-05-01', 'YYYY-MM-DD'), 'Labour Day');
INSERT INTO Holidays VALUES (TO_DATE('2025-05-13', 'YYYY-MM-DD'), 'Eid al-Fitr');
INSERT INTO Holidays VALUES (TO_DATE('2025-07-01', 'YYYY-MM-DD'), 'Independence Day');
INSERT INTO Holidays VALUES (TO_DATE('2025-07-04', 'YYYY-MM-DD'), 'Liberation Day');


CREATE TABLE Audit_Log (
  AuditID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  Username VARCHAR2(30),
  Action VARCHAR2(100),
  TableName VARCHAR2(30),
  ActionTime TIMESTAMP,
  Status VARCHAR2(10) -- ALLOWED / DENIED
);

CREATE OR REPLACE TRIGGER trg_block_weekday_and_holiday_dml
BEFORE INSERT OR UPDATE OR DELETE ON Products
FOR EACH ROW
DECLARE
  v_today DATE := TRUNC(SYSDATE);
  v_day VARCHAR2(10);
  v_holiday_count NUMBER;
BEGIN
  v_day := TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE=ENGLISH');
  
  SELECT COUNT(*) INTO v_holiday_count
  FROM Holidays
  WHERE HolidayDate = v_today;

  IF v_day IN ('MON', 'TUE', 'WED', 'THU', 'FRI') OR v_holiday_count > 0 THEN
    -- Log the denied attempt
    INSERT INTO Audit_Log (Username, Action, TableName, ActionTime, Status)
    VALUES (USER, 'DML Attempt', 'Products', SYSTIMESTAMP, 'DENIED');
    -- Prevent the action
    RAISE_APPLICATION_ERROR(-20001, 'DML operations are not allowed on weekdays or holidays.');
  ELSE
    -- Log allowed action
    INSERT INTO Audit_Log (Username, Action, TableName, ActionTime, Status)
    VALUES (USER, 'DML Attempt', 'Products', SYSTIMESTAMP, 'ALLOWED');
  END IF;
END;



INSERT INTO Products VALUES ('P999', 'Test Item', 'Test', 10.00, 5);

SELECT * FROM Audit_Log ORDER BY ActionTime DESC;




