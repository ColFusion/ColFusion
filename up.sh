#!/usr/bin/env bash
set -o errexit

# This script deploys a Colfusion environment

until [ -z "$1" ]; do
    case $1 in
        "--prod")
            shift
            PROD=true
            ;;
        "--help")
            echo "Deploys a Colfusion environment"
            echo
            echo "Usage: $0 [--prod]"
            echo
            echo "  --prod      Nearly full utilization of hardware"
            echo
            exit 0
            ;;
        *)
            echo "Unrecognized option: $1"
            exit 1
            ;;
    esac
done

if [ "${PROD}" == true ]; then
      if [ -z "CF_CPUS" ]; then
            CF_CPUS="$(nproc)"
            if [ $CF_CPUS -gt 1 ]; then
                CF_CPUS="$(($CF_CPUS-1))"
            fi
            export CF_CPUS
      fi
      if [ -z "CF_MEM" ]; then
            CF_MEM="$(cat /proc/meminfo | grep MemTotal | awk '{ print $2 }')"
            CF_MEM="$(($CF_MEM/1024))" # convert to megabytes
            CF_MEM="$((($CF_MEM*7)/10))" # use 70%
            export CF_MEM
      fi
fi

COLFUSION_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )"/.. && pwd )

pwd

vagrant up

echo "Clearing cache"

TEMPLATES_C="${COLFUSION_DIR}/ColfusionWeb/cache/templates_c"
if [ -d "${TEMPLATES_C}" ]; then
    rm -r "${TEMPLATES_C}"
fi

echo "Running maven to install all dependencies (skipping running tests)"
cd "${COLFUSION_DIR}/ColfusionServer"
mvn install -DskipTests

echo "Run flyway migrations to setup database tables"

cd $COLFUSION_DIR/ColFusion

bash ./db_migrate.sh

