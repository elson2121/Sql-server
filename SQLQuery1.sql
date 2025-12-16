CREATE DATABASE Samuel_DB;
--create database
USE Samuel_DB;
CREATE TABLE PRODUCT (
    productID VARCHAR(10) PRIMARY KEY,
    productName VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL
);
--for    emply
-- EMPLOYEE Table
CREATE TABLE EMPLOYEE (
    empID VARCHAR(10) PRIMARY KEY,
    empName VARCHAR(100) NOT NULL,
    BirthDate DATE NOT NULL,
    position VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL
);
-- insrt data fro pro
INSERT INTO PRODUCT (productID, productName, price, quantity) VALUES
('P003', 'Mouse', 500.00, 8),
('P005', 'Hard disk', 2500.00, 10);
-- insert for empl
INSERT INTO EMPLOYEE (empID, empName, BirthDate, position, salary) VALUES
('E001', 'Biruk Tadesse', '1994-03-10', 'Manager', 10000.00),
('E004', 'Dibora Bekele', '2001-12-07', 'Finance officer', 5600.00);
-- crete the procudure
CREATE PROCEDURE sp_InsertKeyboard
AS
BEGIN
    INSERT INTO PRODUCT (productID, productName, price, quantity)
    VALUES ('P006', 'Keyboard', 300.00, 50);
    PRINT 'Keyboard product inserted successfully.';
END;
-- II. Display Procedure for Hard disk price
CREATE PROCEDURE sp_DisplayHardDiskPrice
AS
BEGIN
    SELECT price 
    FROM PRODUCT 
    WHERE productName = 'Hard disk';
END;



-- III. Update Procedure for Mouse quantity
CREATE PROCEDURE sp_UpdateMouseQuantity
AS
BEGIN
    UPDATE PRODUCT 
    SET quantity = 25
    WHERE productName = 'Mouse';
    PRINT 'Mouse quantity updated to 25.';
END;

select * from PRODUCT 
UPDATE PRODUCT SET quantity = 50 WHERE productName = 'Mouse';







CREATE PROCEDURE sp_UpdateMouseQuantity
AS
BEGIN
    UPDATE PRODUCT 
    SET quantity = 50 
    WHERE productName = 'Mouse';
    PRINT 'Mouse quantity updated to 25.';
END;





-- I. Duplication Check Trigger (Before Insert)
CREATE TRIGGER trg_PreventDuplicateEmployee
ON EMPLOYEE
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM EMPLOYEE e INNER JOIN inserted i ON e.empID = i.empID)
    BEGIN
        RAISERROR('Employee ID already exists. Duplication is not allowed.', 16, 1);
        RETURN;
    END
    
    INSERT INTO EMPLOYEE (empID, empName, BirthDate, position, salary)
    SELECT empID, empName, BirthDate, position, salary FROM inserted;
END;
-- Create Log Table for Salary Updates
CREATE TABLE EMPLOYEE_SALARY_LOG (
    logID INT IDENTITY(1,1) PRIMARY KEY,
    empID VARCHAR(10) NOT NULL,
    oldSalary DECIMAL(10,2) NOT NULL,
    newSalary DECIMAL(10,2) NOT NULL,
    updateTime DATETIME DEFAULT GETDATE()
);
select * from PRODUCT 



-- II. Salary Log Trigger (After Update)
CREATE TRIGGER trg_LogSalaryUpdate
ON EMPLOYEE
AFTER UPDATE
AS
BEGIN
    IF UPDATE(salary)
    BEGIN
        INSERT INTO EMPLOYEE_SALARY_LOG (empID, oldSalary, newSalary)
        SELECT 
            d.empID,
            d.salary AS oldSalary,
            i.salary AS newSalary
        FROM deleted d
        INNER JOIN inserted i ON d.empID = i.empID
        WHERE d.salary <> i.salary;
    END
END;








