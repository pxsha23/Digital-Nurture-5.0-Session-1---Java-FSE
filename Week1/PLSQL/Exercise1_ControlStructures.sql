CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    DOB DATE,
    Balance NUMBER,
    LastModified DATE
);

CREATE TABLE Loans (
    LoanID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    LoanAmount NUMBER,
    InterestRate NUMBER,
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Accounts (
    AccountID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    AccountType VARCHAR2(20),
    Balance NUMBER,
    LastModified DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Employees (
    EmployeeID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Position VARCHAR2(50),
    Salary NUMBER,
    Department VARCHAR2(50),
    HireDate DATE
);

INSERT INTO Customers VALUES (1, 'John Doe', TO_DATE('1955-05-15', 'YYYY-MM-DD'), 15000, SYSDATE);
INSERT INTO Customers VALUES (2, 'Jane Smith', TO_DATE('1990-07-20', 'YYYY-MM-DD'), 8000, SYSDATE);
INSERT INTO Customers VALUES (3, 'Bob Brown', TO_DATE('1958-03-10', 'YYYY-MM-DD'), 12000, SYSDATE);
INSERT INTO Accounts VALUES (1, 1, 'Savings', 15000, SYSDATE);
INSERT INTO Accounts VALUES (2, 2, 'Checking', 8000, SYSDATE);
INSERT INTO Accounts VALUES (3, 3, 'Savings', 12000, SYSDATE);
INSERT INTO Loans VALUES (1, 1, 5000, 5, SYSDATE, ADD_MONTHS(SYSDATE, 60));
INSERT INTO Loans VALUES (2, 2, 3000, 7, SYSDATE, SYSDATE + 15);
INSERT INTO Loans VALUES (3, 3, 8000, 6, SYSDATE, ADD_MONTHS(SYSDATE, 12));
INSERT INTO Employees VALUES (1, 'Alice Johnson', 'Manager', 70000, 'HR', TO_DATE('2015-06-15', 'YYYY-MM-DD'));
INSERT INTO Employees VALUES (2, 'Bob Brown', 'Developer', 60000, 'IT', TO_DATE('2017-03-20', 'YYYY-MM-DD'));
COMMIT;

--Scenario 1: Age-based loan discount
BEGIN
    FOR cust IN (SELECT c.CustomerID, l.LoanID,
                        FLOOR(MONTHS_BETWEEN(SYSDATE, c.DOB) / 12) AS Age
                 FROM Customers c JOIN Loans l ON c.CustomerID = l.CustomerID)
    LOOP
        IF cust.Age > 60 THEN
            UPDATE Loans SET InterestRate = InterestRate - 1 WHERE LoanID = cust.LoanID;
            DBMS_OUTPUT.PUT_LINE('Discount applied for CustomerID: ' || cust.CustomerID 
                                  || ' | Age: ' || cust.Age 
                                  || ' | LoanID: ' || cust.LoanID);
        END IF;
    END LOOP;
    COMMIT;
END;
/

--Scenario 2: VIP status
ALTER TABLE Customers ADD IsVIP VARCHAR2(5) DEFAULT 'FALSE';
BEGIN
    FOR cust IN (SELECT CustomerID, Name, Balance FROM Customers)
    LOOP
        IF cust.Balance > 10000 THEN
            UPDATE Customers SET IsVIP = 'TRUE' WHERE CustomerID = cust.CustomerID;
            DBMS_OUTPUT.PUT_LINE('VIP: ' || cust.Name || ' | Balance: ' || cust.Balance);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Not VIP: ' || cust.Name || ' | Balance: ' || cust.Balance);
        END IF;
    END LOOP;
    COMMIT;
END;
/

--Scenario 3: Loan reminders within 30 days
BEGIN
    FOR loan IN (SELECT l.LoanID, c.Name, l.EndDate
                 FROM Loans l JOIN Customers c ON l.CustomerID = c.CustomerID
                 WHERE l.EndDate BETWEEN SYSDATE AND SYSDATE + 30)
    LOOP
        DBMS_OUTPUT.PUT_LINE('REMINDER: Dear ' || loan.Name
                              || ', Loan ID: ' || loan.LoanID
                              || ' due on ' || TO_CHAR(loan.EndDate, 'DD-MON-YYYY'));
    END LOOP;
END;
/
