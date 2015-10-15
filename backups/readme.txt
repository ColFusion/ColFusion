To restore a backup:

# Set path to backup folder
BACKUP_DIR=/path/to/backup

# Shutdown services

$ /etc/init.d/apache2 stop
$ /etc/init.d/tomcat stop
$ /etc/init.d/cfopenrefine stop
$ /etc/rc6.d/K99_stop_neo4j

# restore web resources

$ rm -r /opt/Colfusion/ColFusion/assets/www
$ cp -r "${BACKUP_DIR}/ColFusionAssetsWww" /opt/Colfusion/ColFusion/assets/www

# restore Open Refine workspace

$ rm -r /opt/Colfusion/ColfusionOpenRefine/workspace
$ cp -r "${BACKUP_DIR}/OpenRefineWorkspace" /opt/Colfusion/ColfusionOpenRefine/workspace

# restore mysql table

$ mysql -uroot -p < "${BACKUP_DIR}/mysql.sql"

# restore neo4j
$ rm -r /opt/neo4j-community/data/graph.db
$ cp -r "${BACKUP_DIR}/Neo4jGraphDb" /opt/neo4j-community/data/graph.db

# restart services

$ /etc/init.d/apache2 start
$ /etc/init.d/tomcat start
$ /etc/init.d/cfopenrefine start
$ /etc/init.d/start_neo4j

