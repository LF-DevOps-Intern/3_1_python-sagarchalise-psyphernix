#!/usr/bin/bash
# helper script to parse html files
usage()
{
    echo "Usage: ./$0 [-u URL] [-s flag] [-h] [-i ]"
    echo "  -u: URL for the website to parse"
    echo "  -s: Flag to start Python http_server"
    echo "  -h: Print this help message"
    echo "  -i: Install required packages for HTTP Parser (use with caution)"
    exit 0
}

# installtion for http_parser (first run)
install()
{
    echo -e "Where do you want to setup virtual python environment [Default: Current Directory]? provide absoulte path: \c"
    read -r VIRTUAL_ENV_PATH
    echo -e "\nInstalling HTTP Parser................."
    echo -e "\nInstalling required programs..........."
    echo -e "\nInstalling Python......................"
    sudo apt install python3.8 -y
    sudo apt install python3-pip -y
    sudo apt install python3.8-venv -y
    if [ -z $VIRTUAL_ENV_PATH ]; then
        echo -e "Setting up environment in the current directory."
    else
        cd $VIRTUAL_ENV_PATH
        echo -e "Setting up enivronment in $VIRTUAL_ENV_PATH"
    fi
    sudo python3 -m venv htmlparser
    echo -e "\nInstalling required libraries.........."
    sudo htmlparser/bin/python3 -m pip install requests argparse
    echo -e "\nInstallation completed!"
    exit 0 #exit after installation with success
}

# argument parsing
while getopts :u:s:ih argument; do
    case $argument in
        u)
            url=$OPTARG
            ;;
        s)
            flag=$OPTARG
            ;;
        i)
            install
            ;;
        h)
            usage
            exit 0
            ;;
        *)
            usage
            exit 1
            ;;
    esac
done
# activate virtual environment
source htmlparser/bin/activate

# if flag is set, start http_server, else do parsing only
if [ -z $flag ]; then
    python3 htmlparser.py -u $url
else
    python3 htmlparser.py --url $url --http_server $flag
fi

# deactive virtual environment
deactivate
exit 0
