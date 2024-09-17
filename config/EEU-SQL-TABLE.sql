CREATE TABLE CentralAdmin (
    CentralAdminID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Username VARCHAR(50),
    Password VARCHAR(50),
    Email VARCHAR(255)
);
-- Region Table
CREATE TABLE Region (
    RegionID INT PRIMARY KEY AUTO_INCREMENT,
    RegionName VARCHAR(255) NOT NULL,
    CentralAdminID INT NOT NULL, -- CentralAdmin Manage Region
    FOREIGN KEY (CentralAdminID) REFERENCES CentralAdmin(CentralAdminID)
);

-- District Table
CREATE TABLE District (
    DistrictID INT PRIMARY KEY AUTO_INCREMENT,
    RegionID INT NOT NULL,
    DistrictName VARCHAR(255) NOT NULL,
    CentralAdminID INT NOT NULL, -- CentralAdmin Manage District
    FOREIGN KEY (CentralAdminID) REFERENCES CentralAdmin(CentralAdminID),
    FOREIGN KEY (RegionID) REFERENCES Region(RegionID)
);
-- CustomerServiceCenter Manager
CREATE TABLE CSCManager (
    ManagerID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeID INT NOT NULL,
    CentralAdminID INT NOT NULL, -- CentralAdmin manages CSCManager
    FOREIGN KEY (CentralAdminID) REFERENCES CentralAdmin(CentralAdminID)
);
-- CustomerServiceCenter
CREATE TABLE CustomerServiceCenter (
    CustomerServiceCenterID INT PRIMARY KEY AUTO_INCREMENT,
    DistrictID INT NOT NULL,
    CustomerServiceCenterName VARCHAR(255) NOT NULL,
    Address VARCHAR(255),
    PhoneNumber VARCHAR(20),
    Email VARCHAR(255),
    ManagerID INT,
    CentralAdminID INT NOT NULL, -- CentralAdmin manages District
    FOREIGN KEY (CentralAdminID) REFERENCES CentralAdmin(CentralAdminID),
    FOREIGN KEY (DistrictID) REFERENCES District(DistrictID),
    FOREIGN KEY (ManagerID) REFERENCES CSCManager(ManagerID)
);
-- Service Center HR
CREATE TABLE CustomerServiceCenterHR (
    HRID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeID INT NOT NULL,
    CustomerServiceCenterID INT,
    CentralAdminID INT NOT NULL, -- CentralAdmin manages CustomerServiceCenterHR
    FOREIGN KEY (CentralAdminID) REFERENCES CentralAdmin(CentralAdminID),
    FOREIGN KEY (CustomerServiceCenterID) REFERENCES CustomerServiceCenter(CustomerServiceCenterID)
);
-- Create Employee table
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(255) NOT NULL,
    MiddleName VARCHAR(255),
    LastName VARCHAR(255) NOT NULL,
    Gender VARCHAR(10),
    DateOfBirth DATE,
    Nationality VARCHAR(50),
    MaritalStatus VARCHAR(20),
    Address VARCHAR(255),
    PhoneNumber VARCHAR(20),
    AlternatePhoneNumber VARCHAR(20),
    Email VARCHAR(255),
    Position VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Username VARCHAR(50),
    Password VARCHAR(50),
    EmployeeIDNumber VARCHAR(20),
    IDPhoto VARCHAR(255),
    PassportSizePhoto VARCHAR(255),
    DateOfHire DATE,
    EmploymentStatus VARCHAR(20) DEFAULT 'Active',
    Salary DECIMAL(10, 2),
    EmergencyContactName VARCHAR(255),
    EmergencyContactPhone VARCHAR(20),
    EmergencyContactRelation VARCHAR(50),
    CustomerServiceCenterID INT,
    HRID INT NOT NULL,
    FOREIGN KEY (HRID) REFERENCES CustomerServiceCenterHR(HRID),
    FOREIGN KEY (CustomerServiceCenterID) REFERENCES CustomerServiceCenter(CustomerServiceCenterID)
);


-- Create RegionAdmin table
CREATE TABLE RegionAdmin (
    RegionAdminID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeID INT NOT NULL,
    RegionID INT NOT NULL,
    CentralAdminID INT NOT NULL, -- CentralAdmin manages RegionAdmin
    FOREIGN KEY (CentralAdminID) REFERENCES CentralAdmin(CentralAdminID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (RegionID) REFERENCES Region(RegionID)
);

-- Create DistrictAdmin table
CREATE TABLE DistrictAdmin (
    DistrictAdminID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeID INT NOT NULL,
    DistrictID INT NOT NULL,
    CentralAdminID INT NOT NULL, -- CentralAdmin manages DistrictAdmin
    RegionAdminID INT NOT NULL,
    FOREIGN KEY (CentralAdminID) REFERENCES CentralAdmin(CentralAdminID),
    FOREIGN KEY (RegionAdminID) REFERENCES RegionAdmin(RegionAdminID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (DistrictID) REFERENCES District(DistrictID)
);
-- Create Customer table
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(255) NOT NULL,
    MiddleName VARCHAR(255),
    LastName VARCHAR(255) NOT NULL,
    CustomerServiceCenterID INT,
    Address VARCHAR(255),
    Username VARCHAR(50),
    Password VARCHAR(50),
    Email VARCHAR(255),  -- Email address
    PhoneNumber VARCHAR(20),
    AlternatePhoneNumber VARCHAR(20),  -- Secondary contact number
    DateOfBirth DATE,  -- Date of birth
    Gender VARCHAR(10),  -- Gender
    MaritalStatus VARCHAR(20),  -- Marital status
    Occupation VARCHAR(50),  -- Occupation
    IDNumber VARCHAR(20),
    IDPhoto VARCHAR(255),  -- Path to National ID or passport picture
    PassportSizePhoto VARCHAR(255),  -- Path to profile picture
    RegistrationDate DATETIME DEFAULT CURRENT_TIMESTAMP,  -- Date and time of registration
    Status VARCHAR(20) ,
    FOREIGN KEY (CustomerServiceCenterID) REFERENCES CustomerServiceCenter(CustomerServiceCenterID)
);

CREATE TABLE CSR (
    CSRID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeID INT NOT NULL,
    CustomerServiceCenterID INT,
    FOREIGN KEY (CustomerServiceCenterID) REFERENCES CustomerServiceCenter(CustomerServiceCenterID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

CREATE TABLE BillingDept (
    BillingID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeID INT NOT NULL,
    CustomerServiceCenterID INT,
    FOREIGN KEY (CustomerServiceCenterID) REFERENCES CustomerServiceCenter(CustomerServiceCenterID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

CREATE TABLE Technician (
    TechnicianID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeID INT NOT NULL,
    CustomerServiceCenterID INT,
    FOREIGN KEY (CustomerServiceCenterID) REFERENCES CustomerServiceCenter(CustomerServiceCenterID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Create SmartMeter table
CREATE TABLE SmartMeter (
    MeterID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    InstallationDate DATE,
    Latitude DECIMAL(10, 8), -- Latitude for map coordinates
    Longitude DECIMAL(11, 8), -- Longitude for map coordinates
    Status VARCHAR(50),
    TechnicianID INT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (TechnicianID) REFERENCES Technician(TechnicianID)
);

-- Create SmartMeterData table
CREATE TABLE SmartMeterData (
    DataID INT PRIMARY KEY AUTO_INCREMENT,
    MeterID INT NOT NULL,
    Timestamp DATETIME NOT NULL,
    UsageData DECIMAL(10, 2) NOT NULL,
    Voltage DECIMAL(10, 2),
    Current DECIMAL(10, 2),
    PowerFactor DECIMAL(10, 2),
    MeterStatus VARCHAR(50),
    FOREIGN KEY (MeterID) REFERENCES SmartMeter(MeterID)
);

-- Create Invoice table
CREATE TABLE Invoice (
    InvoiceID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    ServiceCharges DECIMAL(10, 2) NOT NULL,
    PaymentStatus VARCHAR(50) NOT NULL,
    InvoiceDate DATE NOT NULL,
    PaymentMethod VARCHAR(50),
    PaymentDate DATE NOT NULL,
    TransactionID VARCHAR(255),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Create Notification table
CREATE TABLE Notification (
    NotificationID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    NotificationType VARCHAR(50),
    Message TEXT,
    SentDate DATETIME,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Create ServiceRequest table
CREATE TABLE ServiceRequest (
    RequestID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    RequestDate DATE,
    Status VARCHAR(20),
    Description TEXT,
    ServiceType VARCHAR(20),
    CustomerServiceCenterID int,
    UpdatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (CustomerServiceCenterID) REFERENCES CustomerServiceCenter(CustomerServiceCenterID)
);

-- Create FaultReport table
CREATE TABLE FaultReport (
    FaultReportID INT PRIMARY KEY AUTO_INCREMENT,
    Description TEXT,
    ReportDate DATETIME,
    Status VARCHAR(20),
    Priority VARCHAR(10),
    Resolution VARCHAR(20)
);

-- Fault Reports From Employees
CREATE TABLE FaultReports_Employees (
    FaultReportID INT,
    EmployeeID INT,
    PRIMARY KEY (FaultReportID, EmployeeID),
    FOREIGN KEY (FaultReportID) REFERENCES FaultReport(FaultReportID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Fault Reports From Customer
CREATE TABLE FaultReport_Customer (
    FaultReportID INT,
    CustomerID INT,
    PRIMARY KEY (FaultReportID, CustomerID),
    FOREIGN KEY (FaultReportID) REFERENCES FaultReport(FaultReportID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Create MaintenanceTask table
CREATE TABLE MaintenanceTask (
    TaskID INT PRIMARY KEY AUTO_INCREMENT,
    TechnicianID INT NOT NULL,
    RequestID INT NOT NULL,
    TaskDate DATE,
    Status VARCHAR(20),
    Description TEXT,
    FOREIGN KEY (TechnicianID) REFERENCES Technician(TechnicianID),
    FOREIGN KEY (RequestID) REFERENCES ServiceRequest(RequestID)
);

-- Create SystemFeedback table
CREATE TABLE SystemFeedback (
    FeedbackID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    FeedbackDate DATE,
    Comments TEXT,
    SystemComponent VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Create ServiceFeedback table
CREATE TABLE Feedback (
    FeedbackID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    EmployeeID INT,
    FeedbackDate DATE,
    Comments TEXT,
    Rating INT,
    FeedbackType VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Create ElectricitySupplyContract table
CREATE TABLE ElectricitySupplyContract (
    ContractID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    MeterID INT,
    InvoiceID INT,
    Purposes VARCHAR(255),
    PowerApprovedKW DECIMAL(10, 2),
    Volt DECIMAL(10, 2),
    ApplicableTariff INT,
    DepositEth DECIMAL(10, 2),
    ConnectionFeeEth DECIMAL(10, 2),
    TotalEth DECIMAL(10, 2),
    ConsumerSign VARCHAR(255),
    AuthoritySign VARCHAR(255),
    ContractDate DATE,
    Witness1Name VARCHAR(255),
    Witness1Signature VARCHAR(255),
    Witness2Name VARCHAR(255),
    Witness2Signature VARCHAR(255),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (InvoiceID) REFERENCES Invoice(InvoiceID),
    FOREIGN KEY (MeterID) REFERENCES SmartMeter(MeterID)
);

-- Create EquipmentInstalled table
CREATE TABLE EquipmentInstalled (
    EquipmentInstalledID INT PRIMARY KEY AUTO_INCREMENT,
    ContractID INT,
    EquipmentName VARCHAR(255),
    NoOfPoints INT,
    TotalWattage DECIMAL(10, 2),
    FOREIGN KEY (ContractID) REFERENCES ElectricitySupplyContract(ContractID)
);

-- Create ChatConversations table
CREATE TABLE ChatConversations (
    ConversationID INT PRIMARY KEY AUTO_INCREMENT,
    Employee1ID INT NOT NULL,
    Employee2ID INT NOT NULL,
    StartDate DATETIME NOT NULL,
    FOREIGN KEY (Employee1ID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (Employee2ID) REFERENCES Employee(EmployeeID),
    INDEX (Employee1ID, Employee2ID)
);

-- Create EmployeeChat table
CREATE TABLE EmployeeChat (
    ChatMessageID INT PRIMARY KEY AUTO_INCREMENT,
    ConversationID INT NOT NULL,
    SenderID INT NOT NULL,
    ReceiverID INT NOT NULL,
    ChatMessage TEXT,
    AttachmentData VARCHAR(255),
    CreatedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ReadStatus BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (SenderID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (ReceiverID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (ConversationID) REFERENCES ChatConversations(ConversationID),
    UNIQUE INDEX (ConversationID, SenderID, CreatedDate)
);