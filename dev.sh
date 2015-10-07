#!/usr/bin/env bash
set -o errexit

# A script for modifying development options

help() {
    echo "Configures Development Options"
    echo
    echo "Usage: $0 [--cfserverhost|--cfserverguest] [--openrefinehost|--openrefineguest]"
    echo
    echo "  --cfserverhost     Use ColfusionServer running on host"
    echo "  --cfserverguest    Use ColfusionServer running on guest"
    echo "  --openrefinehost   Use openrefine running on host"
    echo "  --openrefineguest   Use openrefine running on guest"
    echo
    exit 0
}

if [ -z "$1" ]; then
    help  
fi

until [ -z "$1" ]; do
    case $1 in
        "--cfserverhost")
            shift
            CFSERVERHOST=true
            ;;
        "--cfserverguest")
            shift
            CFSERVERGUEST=true
            ;;
        "--openrefinehost")
            shift
            OPENREFINEHOST=true
            ;;
        "--openrefineguest")
            shift
            OPENREFINEGUEST=true
            ;;
        "--help")
            help
            ;;
        *)
            echo "Unrecognized option: $1"
            exit 1
            ;;
    esac
done

COLFUSION_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )"/.. && pwd )
cd "${COLFUSION_DIR}/ColFusion/"

if [ "${CFSERVERHOST}" == true ]; then
    vagrant ssh -c 'sudo sed -i '"'"'/$ID_COLFUSION_SERVER/d'"'"' /etc/hosts'
    vagrant ssh -c 'echo -e '"'"'192.168.33.1\tcolfusionserver # $ID_COLFUSION_SERVER'"'"' | sudo tee -a /etc/hosts'    
fi

if [ "${CFSERVERGUEST}" == true ]; then
    vagrant ssh -c 'sudo sed -i '"'"'/$ID_COLFUSION_SERVER/d'"'"' /etc/hosts'
    vagrant ssh -c 'echo -e '"'"'127.0.0.1\tcolfusionserver # $ID_COLFUSION_SERVER'"'"' | sudo tee -a /etc/hosts'    
fi

if [ "${OPENREFINEHOST}" == true ]; then
    vagrant ssh -c 'sudo sed -i '"'"'/$ID_OPENREFINE_SERVER/d'"'"' /etc/hosts'
    vagrant ssh -c 'echo -e '"'"'192.168.33.1\tcolfusionserver # $ID_COLFUSION_SERVER'"'"' | sudo tee -a /etc/hosts'    
fi

if [ "${OPENREFINEGUEST}" == true ]; then
    vagrant ssh -c 'sudo sed -i '"'"'/$ID_OPENREFINE_SERVER/d'"'"' /etc/hosts'
    vagrant ssh -c 'echo -e '"'"'127.0.0.1\tcolfusionserver # $ID_COLFUSION_SERVER'"'"' | sudo tee -a /etc/hosts'    
fi
