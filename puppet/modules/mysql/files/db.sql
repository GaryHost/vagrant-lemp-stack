-- create database for the dynamic site
CREATE DATABASE IF NOT EXISTS db;

-- create a new user for the Web app
DELETE FROM mysql.user WHERE User = 'webuser';
CREATE USER 'webuser'@'%' IDENTIFIED BY 'vagrantrocks';

-- grant only the necessary privileges to our new user
GRANT SELECT, INSERT, UPDATE, DELETE ON dynamic.* TO 'webuser'@'%';

-- make this our active database
USE db;

-- create a table to store our wish list items
DROP TABLE IF EXISTS `MyNewTable`;
CREATE TABLE IF NOT EXISTS `MyNewTable` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `description` varchar(255),

  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

-- start with some data in the table
INSERT INTO MyNewTable (name, description) VALUES ('Pro Puppet book', 'I wanna be a Puppet pro.');
INSERT INTO MyNewTable (name, description) VALUES ('Red Rider BB Gun', 'I will NOT shoot my eye out.');
INSERT INTO MyNewTable (name, description) VALUES ('Soccer cleats', 'For ultimate frisbee. Good luck finding a size 14.');