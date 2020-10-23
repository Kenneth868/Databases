CREATE TABLE Grade (
    GradeID INT NOT NULL AUTO_INCREMENT,
    Title VARCHAR(128) NOT NULL,
    Code VARCHAR(16) NOT NULL UNIQUE,
    SpineMin INT NOT NULL DEFAULT '1',
    SpineMax INT NOT NULL DEFAULT '1',
    PRIMARY KEY(GradeID),
    INDEX(GradeID),
    INDEX(Code));

CREATE TABLE Skill (
    SkillID BIGINT NOT NULL AUTO_INCREMENT,
    Title VARCHAR(255) NOT NULL UNIQUE,
    PRIMARY KEY(SkillID),
    INDEX(SkillID),
    INDEX(Title));

CREATE TABLE Project (
    ProjectID BIGINT NOT NULL AUTO_INCREMENT,
    Title VARCHAR(255) NOT NULL,
    Notes VARCHAR(255) NULL,
    Internal BOOLEAN NOT NULL DEFAULT '0',
    `Sensitive` BOOLEAN NOT NULL DEFAULT '0',
    Started DATE NOT NULL,
    Ended DATE NULL,
    PRIMARY KEY(ProjectID),
    INDEX(ProjectID),
    INDEX(Title),
    INDEX(Notes));
    
CREATE TABLE Equipment (
    EquipmentID BIGINT NOT NULL AUTO_INCREMENT,
    Type VARCHAR(255) NOT NULL,
    Make VARCHAR(255) NULL,
    Model VARCHAR(255) NULL,
    Description VARCHAR(255) NULL,
    OperationNotes TEXT NULL,
    Damaged BOOLEAN NOT NULL,
    PRIMARY KEY(EquipmentID),
    INDEX(EquipmentID),
    INDEX(Type),
    INDEX(Model),
    INDEX(Description),
    INDEX(Damaged));

CREATE TABLE Employee (
    EmployeeID BIGINT NOT NULL AUTO_INCREMENT,
    Title VARCHAR(32) NULL,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NULL UNIQUE,
    Joined DATE NULL,
    `Left` DATE NULL,
    `Current` BOOLEAN NOT NULL,
    Phone VARCHAR(32) NOT NULL,
    GradeID INT NOT NULL,
    Manager BIGINT NULL,
    INDEX(EmployeeID),
    INDEX(FirstName),
    INDEX(LastName),
    INDEX(Email),
    INDEX(`Current`),
    INDEX(Manager),
    PRIMARY KEY(EmployeeID),
    FOREIGN KEY(GradeID) REFERENCES Grade(GradeID) ON UPDATE CASCADE,
    FOREIGN KEY(Manager) REFERENCES Employee(EmployeeID) ON DELETE SET NULL);

CREATE TABLE EmployeeSkill (
    EmployeeID BIGINT NOT NULL,
    SkillID BIGINT NOT NULL,
    DateAchieved DATE NULL,
    INDEX(EmployeeID), 
    INDEX(SkillID),
    FOREIGN KEY(EmployeeID) REFERENCES Employee(EmployeeID) ON DELETE CASCADE,
    FOREIGN KEY(SkillID) REFERENCES Skill(SkillID) ON DELETE CASCADE);

CREATE TABLE Assignment (
    ProjectID BIGINT NOT NULL,
    EmployeeID BIGINT NOT NULL,
    INDEX(ProjectID), 
    INDEX(EmployeeID),
    FOREIGN KEY(ProjectID) REFERENCES Project(ProjectID) ON DELETE CASCADE,
    FOREIGN KEY(EmployeeID) REFERENCES Employee(EmployeeID) ON DELETE CASCADE);

CREATE TABLE Expense (
    ExpenseID BIGINT NOT NULL AUTO_INCREMENT,
    EmployeeID BIGINT NOT NULL,
    ProjectID BIGINT NULL,
    Description VARCHAR(255) NOT NULL,
    Amount DOUBLE NOT NULL,
    Paid BOOLEAN NOT NULL DEFAULT '0',
    PRIMARY KEY(ExpenseID),
    INDEX(ExpenseID), 
    INDEX(EmployeeID),
    INDEX(ProjectID),
    INDEX(Description),
    FOREIGN KEY(EmployeeID) REFERENCES Employee(EmployeeID) ON DELETE CASCADE,
    FOREIGN KEY(ProjectID) REFERENCES Project(ProjectID) ON DELETE SET NULL);

CREATE TABLE FileItem (
    ItemID BIGINT NOT NULL AUTO_INCREMENT,
    Title VARCHAR(255) NOT NULL DEFAULT '""',
    Location VARCHAR(255) NOT NULL DEFAULT '""',
    EmployeeID BIGINT NOT NULL,
    PRIMARY KEY(ItemID),
    INDEX(ItemID), 
    INDEX(Title),
    INDEX(EmployeeID),
    FOREIGN KEY(EmployeeID) REFERENCES Employee(EmployeeID) ON DELETE CASCADE);

CREATE TABLE Payslip (
    PayslipID BIGINT NOT NULL AUTO_INCREMENT,
    EmployeeID BIGINT NOT NULL,
    Taxable DOUBLE NOT NULL,
    NonTaxable DOUBLE NOT NULL DEFAULT '0',
    IncomeTax DOUBLE NOT NULL DEFAULT '0',
    NationalInsurance DOUBLE NOT NULL DEFAULT '0',
    NetPay DOUBLE NOT NULL DEFAULT '0',
    Payday DATE NOT NULL,
    TransferDay DATE NOT NULL,
    TransferRef VARCHAR(32) NOT NULL,
     PRIMARY KEY(PayslipID),
    INDEX(PayslipID), 
    INDEX(EmployeeID),
    FOREIGN KEY(EmployeeID) REFERENCES Employee(EmployeeID) ON DELETE CASCADE);

CREATE TABLE Contract (
    ContractID BIGINT NOT NULL AUTO_INCREMENT,
    Title VARCHAR(255) NOT NULL,
    Start DATE NOT NULL,
    DueFinish DATE NULL,
    ActualFinish DATE NULL,
    EmployeeID BIGINT NOT NULL,
    PRIMARY KEY(ContractID),
    INDEX(ContractID), 
    INDEX(EmployeeID),
    FOREIGN KEY(EmployeeID) REFERENCES Employee(EmployeeID) ON DELETE CASCADE);

CREATE TABLE EquipmentLoan (
    EmployeeID BIGINT NOT NULL,
    EquipmentID BIGINT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NULL,
    `Current` BOOLEAN NOT NULL,
    Notes TEXT NULL,
    INDEX(EquipmentID), 
    INDEX(EmployeeID),
    INDEX(`Current`),
    FOREIGN KEY(EquipmentID) REFERENCES Equipment(EquipmentID) ON DELETE CASCADE,
    FOREIGN KEY(EmployeeID) REFERENCES Employee(EmployeeID) ON DELETE CASCADE);