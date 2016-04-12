	-- ===== Drop Types =====
	DROP TYPE oName FORCE;
	DROP TYPE oAddress FORCE;
	DROP TYPE oAccType FORCE;
	DROP TYPE oSaving FORCE;
	DROP TYPE oCurrent FORCE;
	DROP TYPE oPeopleType FORCE;
	DROP TYPE oCustomer FORCE;
	DROP TYPE oEmployee FORCE;
	DROP TYPE oBranch FORCE;

	-- ===== Types =====

	-- Name
	CREATE TYPE oName AS OBJECT
	(
	title VARCHAR2(7),
	firstName VARCHAR2(20),
	surName VARCHAR2(20)
	)
	INSTANTIABLE
	NOT FINAL
	;
	/
	
	-- Address
	CREATE TYPE oAddress AS OBJECT
	(
	street VARCHAR(45),
	city VARCHAR(45),
	postcode VARCHAR(8)
	)
	INSTANTIABLE
	NOT FINAL
	;
	/

	-- Account Type (Abstract class)
	CREATE TYPE oAccType AS OBJECT
	(
	accID INT,
	balance NUMERIC(38, 18),
	inRate NUMERIC(38, 18), 
	limitOfFreeOD NUMERIC(38,18),
	openDate DATE,
	bID INT
	)
	INSTANTIABLE
	NOT FINAL
	;
	/

	-- Savings (Inherits from accType)
	CREATE TYPE oSaving UNDER oAccType
	(
	cID INT
	)
	INSTANTIABLE
	NOT FINAL
	;
	/

	-- Current (Inherits from accType)
	CREATE TYPE oCurrent UNDER oAccType
	(
	cID INT
	)
	INSTANTIABLE
	NOT FINAL
	;
	/


	-- Abstract People Type
	CREATE TYPE oPeopleType AS OBJECT
	(
	pName oName,
	homePhone VARCHAR(12),
	mobile1 VARCHAR(13),
	mobile2 VARCHAR(13),
	niNum VARCHAR(13),
	pAddress oAddress
	)
	INSTANTIABLE
	NOT FINAL
	;
	/

	-- Customer
	CREATE TYPE oCustomer UNDER oPeopleType
	(
	cID INT
	)
	INSTANTIABLE
	NOT FINAL
	;
	/

	-- Employee
	CREATE TYPE oEmployee UNDER oPeopleType
	(
	empID INT,
	--supervisorID REF oEmployee,
	position VARCHAR(45),
	salary NUMERIC(6,3),
	bID INT,
	joinDate DATE
	)
	INSTANTIABLE
	NOT FINAL
	;
	/

	-- Branch
	CREATE TYPE oBranch AS OBJECT
	(
	bPhone VARCHAR(12),
	pAddress oAddress,
	bID INT
	)
	INSTANTIABLE
	NOT FINAL;
	/

	-- ===== Drop Tables =====
	DROP TABLE tSaving;
	DROP TABLE tCurrent;
	DROP TABLE tCustomer;
	DROP TABLE tAccount;
	DROP TABLE tEmployee;
	DROP TABLE tBranch;

	-- Branch
	CREATE TABLE tBranch OF oBranch
	(
	PRIMARY KEY(bID)
	)
	;
	/

	-- Employee
	CREATE TABLE tEmployee OF oEmployee
	(
	PRIMARY KEY(empID),
	FOREIGN KEY(bID) REFERENCES tBranch(bID),
	CONSTRAINT uEmp UNIQUE(niNum)
	)
	;
	/

	-- Account
	CREATE TABLE tAccount OF oAccType
	(
	PRIMARY KEY(accID),
	FOREIGN KEY(bID) REFERENCES tBranch(bID)
	)
	;
	/

	-- Customer
	CREATE TABLE tCustomer OF oCustomer
	(
	PRIMARY KEY(cID)
	);
	/

	-- Savings
	CREATE TABLE tSaving OF oSaving
	(
	PRIMARY KEY(accID),
	FOREIGN KEY(cID) REFERENCES tCustomer(cID)
	)
	;
	/

	-- Current
	CREATE TABLE tCurrent OF oCurrent
	(
	PRIMARY KEY(accID),
	FOREIGN KEY(cID) REFERENCES tCustomer(cID)
	)
	;
	/
