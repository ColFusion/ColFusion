#!/usr/bin/env bash
set -o errexit

echo "Running colfusion.sh script as user: " $(whoami)

echo "Installing carte"

/opt/Colfusion/ColFusion/assets/scripts/carte.sh

echo "Clearing cache"

TEMPLATES_C="/opt/Colfusion/ColfusionWeb/cache/templates_c"
if [ -d "${TEMPLATES_C}" ]; then
    rm -r "${TEMPLATES_C}"
fi

echo "Installing ColfusionServer"
 
/opt/Colfusion/ColFusion/assets/scripts/cfserver.sh

echo "Run flyway migrations to setup database tables"

/opt/Colfusion/ColFusion/assets/scripts/db_migrate.sh

echo "Done Installing ColfusionServer"

echo "Installing Open Refine"

/opt/Colfusion/ColFusion/assets/scripts/cfopenrefine.sh

echo "Done Installing Open Refine"
