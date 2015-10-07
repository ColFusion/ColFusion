#!/usr/bin/env bash
set -o errexit

# This script deploys a Colfusion environment with nearly full utilization of resources

if [ -z "${CF_CPUS}" ]; then
      CF_CPUS="$(nproc)"
      if [ $CF_CPUS -gt 1 ]; then
          CF_CPUS="$(($CF_CPUS-1))"
      fi
      export CF_CPUS
fi
if [ -z "${CF_MEM}" ]; then
      CF_MEM="$(cat /proc/meminfo | grep MemTotal | awk '{ print $2 }')"
      CF_MEM="$(($CF_MEM/1024))" # convert to megabytes
      CF_MEM="$((($CF_MEM*7)/10))" # use 70%
      export CF_MEM
fi

pwd

vagrant up
