-- Test Insert Procedure
EXEC sp_InsertKeyboard;
SELECT * FROM PRODUCT;

-- Test Display Procedure
EXEC sp_DisplayHardDiskPrice;

-- Test Update Procedure
EXEC sp_UpdateMouseQuantity;
SELECT * FROM PRODUCT WHERE productName = 'Mouse';

-- Test Duplication Prevention
INSERT INTO EMPLOYEE (empID, empName, BirthDate, position, salary)
VALUES ('E001', 'Test Employee', '1990-01-01', 'Tester', 5000); -- This should fail

-- Test Salary Log Trigger
UPDATE EMPLOYEE SET salary = 12000 WHERE empID = 'E001';
SELECT * FROM EMPLOYEE_SALARY_LOG;

SELECT empID, empName FROM EMPLOYEE;

-- Try to cheat 
INSERT INTO EMPLOYEE (empID, empName, BirthDate, position, salary)
VALUES ('E001', 'Fake Employee', '2000-01-01', 'Cheater', 1000);
SELECT empID, empName FROM EMPLOYEE;
-- Show current employees
SELECT empID, empName FROM EMPLOYEE;

-- Try to cheat (this will FAIL with error)
INSERT INTO EMPLOYEE (empID, empName, BirthDate, position, salary)
VALUES ('E001', 'Fake Employee', '2000-01-01', 'Cheater', 1000);

-- Show employees still the same
SELECT empID, empName FROM EMPLOYEE;
-- show the dublication 
SELECT * FROM EMPLOYEE;
INSERT INTO EMPLOYEE (empID, empName, BirthDate, position, salary)
VALUES ('E001', 'Fake Employee', '2000-01-01', 'Cheater', 1000);
SELECT * FROM EMPLOYEE;