#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )"/.. && pwd )

cd $DIR

git clone https://github.com/ColFusion/ColfusionWeb.git
git clone https://github.com/ColFusion/ColfusionServer.git
git clone https://github.com/ColFusion/ColfusionOpenRefine.git
git clone https://github.com/ColFusion/PentahoKettle.git

propertiesFile="ColfusionServer/ColFusionServerUtils/src/main/resources/config.properties"

: > $propertiesFile # creates zero-length file (or wipes existing file to zero-length)
echo "colfusion.properties.source = custom in main" >> $propertiesFile
echo "colfusion.static_files.root_location = $DIR/Colfusion/assets/www" >> $propertiesFile
echo "colfusion.openrefine.folder = $DIR/Colfusion/ColfusionOpenRefine/workspace" >> $propertiesFile
echo "colfusion.openrefine.csv_file_dir = $DIR/Colfusion/ColfusionOpenRefine/workspace" >> $propertiesFile