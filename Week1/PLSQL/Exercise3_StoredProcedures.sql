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

--Scenario 1: Monthly interest on savings accounts
CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest AS
BEGIN
    UPDATE Accounts SET Balance = Balance * 1.01, LastModified = SYSDATE 
    WHERE AccountType = 'Savings';
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Monthly interest applied to all Savings accounts.');
END;
/
EXEC ProcessMonthlyInterest;

--Scenario 2: Employee bonus by department
CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus(
    p_department IN VARCHAR2, 
    p_bonus_pct IN NUMBER) AS
BEGIN
    UPDATE Employees SET Salary = Salary + (Salary * p_bonus_pct / 100)
    WHERE Department = p_department;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Bonus of ' || p_bonus_pct || '% applied to: ' || p_department);
END;
/
EXEC UpdateEmployeeBonus('IT', 10);

--Scenario 3: Transfer funds
CREATE OR REPLACE PROCEDURE TransferFunds(
    p_from IN NUMBER, 
    p_to IN NUMBER, 
    p_amount IN NUMBER) AS
    v_balance NUMBER;
BEGIN
    SELECT Balance INTO v_balance FROM Accounts WHERE AccountID = p_from;
    IF v_balance < p_amount THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Insufficient balance in Account ' || p_from);
    ELSE
        UPDATE Accounts SET Balance = Balance - p_amount WHERE AccountID = p_from;
        UPDATE Accounts SET Balance = Balance + p_amount WHERE AccountID = p_to;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Transferred ' || p_amount 
                              || ' from Account ' || p_from 
                              || ' to Account ' || p_to);
    END IF;
END;
/
EXEC TransferFunds(1, 2, 500);
