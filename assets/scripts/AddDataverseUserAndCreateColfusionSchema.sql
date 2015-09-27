grant all on *.* to 'dataverse'@'localhost' identified by 'dataverse';
grant all on *.* to 'dataverse'@'%' identified by 'dataverse';

FLUSH PRIVILEGES;

CREATE DATABASE  IF NOT EXISTS `colfusion` /*!40100 DEFAULT CHARACTER SET utf8 */;
