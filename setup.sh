#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )"/.. && pwd )

#git clone https://github.com/ColFusion/ColfusionWeb.git $DIR/
#git clone https://github.com/ColFusion/ColfusionServer.git $DIR/
#git clone https://github.com/ColFusion/ColfusionOpenRefine.git $DIR/
#git clone https://github.com/ColFusion/PentahoKettle.git $DIR/


propertiesFile=$DIR"/ColfusionServer/ColFusionServerUtils/src/main/resources/config.properties"

echo "" >> $propertiesFile
echo "colfusion.static_files.root_location = " $DIR"/Colfusion/www" >> $propertiesFile
echo "colfusion.openrefine.folder = " $DIR"/Colfusion/ColfusionOpenRefine/workspace" >> $propertiesFile
echo "colfusion.openrefine.csv_file_dir = " $DIR"/Colfusion/ColfusionOpenRefine/workspace" >> $propertiesFile


