#!/bin/bash

COLFUSION_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )"/.. && pwd )

cd $COLFUSION_DIR

echo "About to clone ColfusionWeb project. Progress (1/4)"

git clone https://github.com/ColFusion/ColfusionWeb.git

echo "About to clone ColfusionServer project. Progress (2/4)"

git clone https://github.com/ColFusion/ColfusionServer.git

echo "About to clone ColfusionOpenRefine project. Progress (3/4)"

git clone https://github.com/ColFusion/ColfusionOpenRefine.git

echo "About to clone PentahoKettle project. Progress (4/4)"

git clone https://github.com/ColFusion/PentahoKettle.git

echo "Configuring ColfusionServer properties"

propertiesFile="ColfusionServer/ColFusionServerUtils/src/main/resources/config.properties"

: > $propertiesFile # creates zero-length file (or wipes existing file to zero-length)
echo "colfusion.properties.source = custom in main" >> $propertiesFile
echo "colfusion.static_files.root_location = $COLFUSION_DIR/Colfusion/assets/www" >> $propertiesFile
echo "colfusion.openrefine.folder = $COLFUSION_DIR/Colfusion/ColfusionOpenRefine/workspace" >> $propertiesFile
echo "colfusion.openrefine.csv_file_dir = $COLFUSION_DIR/Colfusion/ColfusionOpenRefine/workspace" >> $propertiesFile

echo "Done with setup"
