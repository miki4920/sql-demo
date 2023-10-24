-- This code has been designed for MySQL database. 
CREATE SCHEMA sql_demo;
USE sql_demo;

CREATE TABLE IF NOT EXISTS User (
    id BIGINT PRIMARY KEY,
    username VARCHAR(255),
    firstName VARCHAR(255),
    lastName VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255),
    phone VARCHAR(255),
    userStatus INT
);

CREATE TABLE IF NOT EXISTS Category (
    id BIGINT PRIMARY KEY,
    name VARCHAR(255)
);

-- Pet Photo Urls were moved to a separate table as there can be multiple ones per pet. 
CREATE TABLE IF NOT EXISTS Pet (
    id BIGINT PRIMARY KEY,
    category_id BIGINT,
    FOREIGN KEY (category_id) REFERENCES Category(id),
    name VARCHAR(255) NOT NULL,
    status ENUM('available', 'pending', 'sold')  NOT NULL
);

CREATE TABLE IF NOT EXISTS PetPhotoUrl (
    id INT PRIMARY KEY,
    petId BIGINT,
    -- Upload Image form passes metadata to the server. It might not need to be stored depending on what it is used for.
    photoMetadata VARCHAR(255),
    photoUrl VARCHAR(255) NOT NULL,
    FOREIGN KEY (petId) REFERENCES Pet(id)
);

CREATE TABLE IF NOT EXISTS Tag (
    id BIGINT PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS Pet_Tags (
    petId BIGINT,
    tagId BIGINT,
    PRIMARY KEY (petId, tagId),
    FOREIGN KEY (petId) REFERENCES Pet(id),
    FOREIGN KEY (tagId) REFERENCES Tag(id)
);

CREATE TABLE IF NOT EXISTS PetOrder (
    id BIGINT PRIMARY KEY,
    petId BIGINT,
    FOREIGN KEY (petId) REFERENCES Pet(id),
    quantity INT,
    shipDate DATE,
    status ENUM('placed', 'approved', 'delivered') NOT NULL,
    complete BOOLEAN
);
