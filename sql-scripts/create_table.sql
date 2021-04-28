
CREATE TABLE `employees` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	`first_name` varchar(25) DEFAULT NULL,
	`last_name` varchar(25) DEFAULT NULL,
	`department` varchar(15) DEFAULT NULL,
	`email` varchar(50) DEFAULT NULL,
	`created_at` datetime DEFAULT NULL,
	`updated_at` datetime DEFAULT NULL,  
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1