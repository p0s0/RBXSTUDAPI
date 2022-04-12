<p align="center">
<img src="https://assume.neocities.org/Big.png" alt="branding" width="600">
<br>
</p>

# RBXSTUDAPI
This is roblox API for studio.
More specifically late 2014 studio API.
<br></br>
<b>WARNING: All of this code is prone to any drastical change.
Please ALWAYS keep backups before actually using a newer version.</b>
# How to set it up:
Put the following on .htaccess:
```
RewriteEngine on
RewriteCond %{THE_REQUEST} /([^.]+)\.php [NC]
RewriteRule ^ /%1 [NC,L,R]
 
RewriteCond %{REQUEST_FILENAME}.php -f
RewriteRule ^ %{REQUEST_URI}.php [NC,L]

AddHandler application/x-httpd-php .ashx
AddType application/x-httpd-php .ashx
AddHandler application/x-httpd-php .aspx
AddType application/x-httpd-php .aspx
```
Create a database called "prodrbx", and use the following SQL code:
```
CREATE TABLE `asset` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` varchar(100) NOT NULL,
  `approved` varchar(100) NOT NULL,
  `creatorname` LONGTEXT NOT NULL,
  `creatorid` varchar(100) NOT NULL,
  `public` varchar(100) NOT NULL,
  `genre` LONGTEXT NULL,
  `itemtype` LONGTEXT NULL,
  `rsprice` LONGTEXT NOT NULL,
  `tkprice` LONGTEXT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
```
and then use the following SQL code too:
```
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` varchar(100) NOT NULL,
  `password` LONGTEXT NOT NULL,
  `email` LONGTEXT NOT NULL,
  `robux` varchar(100) NOT NULL,
  `ticket` varchar(100) NOT NULL,
  `status` LONGTEXT NOT NULL,
  `admin` varchar(100) NOT NULL,
  `termtype` varchar(100) NOT NULL,
  `treason` LONGTEXT NOT NULL,
  `tdate` varchar(100) NOT NULL,
  `creationdate` varchar(100) NOT NULL,
  `token` LONGTEXT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
```
Modify ```/game/ProdRBX/Configuration.php``` to use your own configs, create three folders "ModelUserCreated","PlaceUserCreated" and "UserRendered" inside of ```/Tools/``` and you are done!
