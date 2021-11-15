Before running http parser app, please setup environment using followinng command:

    $ ./htmlparser.sh -i

After install you can use app by using following commands:

    $ ./htmlparser.sh -u url_of_website (to parse only)
    $ ./htmlparser.sh -u url_of_website -s flag (to run htttp server after parsing)

Example:

    $ ./htmlparser.sh -u https://www.wikipedia.org -s yes
