CREATE TABLE Roles  (
    ID INT,
    Name VARCHAR(128),
    CONSTRAINT PK_Role_ID PRIMARY KEY (ID)
);

INSERT INTO Roles(ID, Name)VALUES(1, 'Root Admin');
INSERT INTO Roles(ID, Name)VALUES(2, 'Admin');
INSERT INTO Roles(ID, Name)VALUES(99, 'Default');

CREATE TABLE Users  (
    ID INT NOT NULL AUTO_INCREMENT,
    Created DATETIME DEFAULT CURRENT_TIMESTAMP,
	UUID VARCHAR(36) UNIQUE NOT NULL,
	GoogleID VARCHAR(255),
	FirstName varchar(255),
    LastName varchar(255),
    MiddleName varchar(255),
	Avatar varchar(500),
    Birthday date,
    Phone VARCHAR(18),
    Email VARCHAR(128),
	IsEnabled BIT DEFAULT 1,
    RoleID INT NOT NULL DEFAULT 99,
    CONSTRAINT PK_User_ID PRIMARY KEY (ID),
    CONSTRAINT FK_User_Role FOREIGN KEY (RoleID)
    REFERENCES Roles(ID)
);

CREATE TABLE Heartbeats  (
    ID INT NOT NULL AUTO_INCREMENT,
    Created DATETIME DEFAULT CURRENT_TIMESTAMP,
	UserID INT NOT NULL,
	Tick DATETIME NOT NULL,
    CONSTRAINT PK_Heartbeat_ID PRIMARY KEY (ID),
    CONSTRAINT FK_Heartbeat_User FOREIGN KEY (UserID)
    REFERENCES Users(ID)
);

CREATE TABLE LogTypes(
    ID INT NOT NULL AUTO_INCREMENT,
	Name VARCHAR(32),
    CONSTRAINT PK_Log_Type_ID PRIMARY KEY (ID)
);

INSERT INTO LogType(Name) VALUES ('Information');
INSERT INTO LogType(Name) VALUES ('Error');

CREATE TABLE LogActions(
    ID INT,
    Name VARCHAR(64),
    LogTypeID INT NOT NULL DEFAULT 1,
    TargetURL VARCHAR(64),
    CONSTRAINT PK_Log_Action_ID PRIMARY KEY (ID),
    CONSTRAINT FK_Log_Action_Type FOREIGN KEY (LogTypeID)
    REFERENCES LogTypes(ID)
);

INSERT INTO LogActions(ID, Description, TargetURL) VALUES (1, 'Logged in', '/admin?user');
INSERT INTO LogActions(ID, Description, TargetURL) VALUES (2, 'Logged out', '/admin?user');

CREATE TABLE Logs(
    ID INT NOT NULL AUTO_INCREMENT,
    Created DATETIME DEFAULT CURRENT_TIMESTAMP,
    IPv4 VARCHAR(16),
	UserID INT,
	LogActionID INT NOT NULL,
    TargetID INT,
    Note VARCHAR(5000),
    CONSTRAINT PK_Log_ID PRIMARY KEY (ID),
    CONSTRAINT FK_Log_User FOREIGN KEY (UserID)
    REFERENCES Users(ID),
    CONSTRAINT FK_Log_Action FOREIGN KEY (LogActionID)
    REFERENCES LogActions(ID)
);
