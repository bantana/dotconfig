#!/bin/bash
## Install and Setup TiDB on Linux
## https://github.com/pingcap/tidb
## https://github.com/pingcap/docs/blob/master/sql/privilege.md
## https://pingcap.com/blog/2016-10-17-how-we-build-tidb/

useradd tidb -d /var/lib/tidb -m
usermod -a -G tidb tidb

if [[ ! -d "/var/lib/tidb" ]]; then
   mkdir -p /var/lib/tidb 
fi
cd /var/lib/tidb
wget http://download.pingcap.org/tidb-latest-linux-amd64.tar.gz
tar -xzf tidb-latest-linux-amd64.tar.gz
mv tidb-latest-linux-amd64/bin .
rm -rf tidb-latest-linux-amd64.tar.gz tidb-latest-linux-amd64
mkdir -p /var/lib/tidb/log/
mkdir -p /var/lib/tidb/storage/
chown -R tidb:tidb *


### Create Service in SystemD
echo '[Unit]
Description=TiDB Daemon
After=syslog.target network.target
[Service]
WorkingDirectory=/var/lib/tidb
ExecStart=/var/lib/tidb/bin/tidb-server -path /var/lib/tidb/storage --log-file=/var/lib/tidb/log/tidb.log
SyslogIdentifier=tidb
User=tidb
Group=tidb
[Install]
WantedBy=multi-user.target' > /etc/systemd/system/tidb.service

systemctl daemon-reload
systemctl start tidb
systemctl enable tidb

echo "set password for 'root'@'%' = 'tidbrootpass';
flush privileges;" > set_root_pass.sql
if [[ -f /usr/bin/mysql ]]; then
    sudo apt -y install mysql-client-core-8.0
fi
mysql -h 127.0.0.1 -P 4000 < set_root_pass.sql

exit 0

## For ISPConfig ##
### Create Service in SystemD
echo '[Unit]
Description=TiDB Daemon
After=syslog.target network.target
[Service]
WorkingDirectory=/var/lib/tidb
ExecStart=/var/lib/tidb/bin/tidb-server -P 3306 -path /var/lib/tidb/storage --log-file=/var/lib/tidb/log/tidb.log
SyslogIdentifier=tidb
User=tidb
Group=tidb
[Install]
WantedBy=multi-user.target' > /etc/systemd/system/tidb.service

systemctl daemon-reload
systemctl start tidb
systemctl enable tidb

echo "set password for 'root'@'%' = 'tidbsecure';
flush privileges;
SET GLOBAL sql_mode = 'NO_ENGINE_SUBSTITUTION';
SET SESSION sql_mode = 'NO_ENGINE_SUBSTITUTION';" > set_root_pass.sql
mysql -h 127.0.0.1 -P 4000 < set_root_pass.sql


