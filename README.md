Name: David  Muhirwa  
ID: 27436  

**Problem Statement**  

Many retail and e-commerce businesses face issues like stockouts, overstocking, and sales tracking errors. These problems lead to financial losses and customer dissatisfaction.  

**Solution**:  
A Smart Stock Management System that automates inventory updates, order processing, sales logging, and supplier interactions. It includes triggers to block transactions on  holidays and weekdays, with audit logging for transparency.



**Methodology**  

- Designed normalized Oracle database schema (3NF)
- Created PL/SQL procedures, functions, cursors, and packages
- Implemented auditing and transaction-blocking using triggers
- Incorporated Rwanda’s holiday calendar for realistic restrictions


ER Diagram  


![image alt](https://github.com/Daveeeid/Mon_27436_SmartStockMS/blob/main/ER%20Diagram%20phase%20III.png?raw=true)  

**1. Entities and Attributes**

I. Products
ProductID (PK)

Name

Category

Price

StockQuantity

II. Sales
SaleID (PK)

ProductID (FK → Products)

QuantitySold

SaleDate

III. Suppliers
SupplierID (PK)

Name

Contact

DeliveryTime

IV. Orders
OrderID (PK)

ProductID (FK → Products)

SupplierID (FK → Suppliers)

QuantityOrdered

OrderDate

Status (e.g., Pending, Delivered)

**2. Relationships**  

Relationship	       |Type  
Products ↔ Sales	   |1 to many  
Products ↔ Orders	   |1 to many  
Suppliers ↔ Orders	 |1 to many  

Each sale is for one product.  

>Each order involves one product and one supplier.

>A supplier can supply many products via orders.

**3. Constraints**

NOT NULL for all mandatory fields

CHECK for StockQuantity, QuantitySold, QuantityOrdered ≥ 0

UNIQUE for fields like ProductID, SupplierID, etc.

DEFAULT for Status = 'Pending'

**4. Normalization (Up to 3NF)**

1NF: All values are atomic (no multi-valued fields) 

2NF: No partial dependencies (every non-key attribute depends on full PK) 

3NF: No transitive dependencies (non-key attributes don’t depend on other non-key attributes) 


![image](https://github.com/user-attachments/assets/cc2fa97d-8f5f-4cfe-ad7b-95c8a6f51065)

**Business Process:** Inventory and Sales Management for retail/e-commerce stores.  
**Objective:** Automate sales recording, inventory tracking, supplier ordering, and financial reporting.  

**Key Actors:**  

Customer (buys products)

Cashier (records sales)

Store Manager (monitors inventory, orders products)

Supplier (delivers products)

System (stores all records)

