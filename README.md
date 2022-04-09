# RBXSTUDAPI
This is roblox API for studio.
More specifically late 2014 studio API.
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
