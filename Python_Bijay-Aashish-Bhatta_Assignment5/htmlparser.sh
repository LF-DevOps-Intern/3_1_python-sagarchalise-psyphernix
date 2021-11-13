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
    echo -e "Where do you want to setup virtual python environment? (absoulte path)\c"
    read -s VIRTUAL_ENV_PATH
    echo "\nInstalling HTTP Parser................."
    echo "\nInstalling required programs..........."
    echo "\nInstalling Python......................"
    sudo apt install python3 -y
    sudo apt install python3-pip -y
    sudo pip3 install python3-venv
    echo"\nSetting up virtual python environment..."
    sudo python3 -m venv $VIRTUAL_ENV_PATH/htmlparser
    echo "\nInstalling required libraries.........."
    $VIRTUAL_ENV_PATH/htmlparser/bin/python3 -m pip install requests argparse unittest subprocess sys datetime
    echo "\nInstallation completed!"
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