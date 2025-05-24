Name: David  Muhirwa  
ID: 27436  

SMART STOCK SYSTEM
--

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

_I. Products_  
ProductID (PK)

Name

Category

Price

StockQuantity

_II. Sales_  
SaleID (PK)

ProductID (FK → Products)

QuantitySold

SaleDate

_III. Suppliers_  
SupplierID (PK)

Name

Contact

DeliveryTime

_IV. Orders_    
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

>Each sale is for one product.  

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

The Smart Stock Management System focuses on automating inventory and sales operations for retail businesses. The business process modeled integrates customers, cashiers, store managers, suppliers, and the database system into an efficient workflow.
The process begins when a customer selects and purchases a product. The cashier records the sale into the system, which automatically updates the stock quantity. If the inventory level falls below a predefined threshold, the system generates a low-stock alert for the store manager. Upon receiving the alert, the manager reviews and approves a restock order, which is then sent to the supplier. After delivery, the system updates the inventory levels accordingly.
This business process supports Management Information Systems (MIS) principles by automating decision support, improving operational efficiency, and ensuring real-time data availability. Automation minimizes human error, accelerates processes, and supports better financial reporting through accurate data capture. As a result, the organization achieves better control over inventory, enhanced customer satisfaction, and improved profitability.
The swimlane diagram visually separates each actor’s responsibility, clarifying the information flow and decision-making points. It ensures that each role is clearly understood, supporting operational transparency and accountability, which are critical aspects of an effective MIS.

**DATABASE USER CREATION**  




