#importing required libraries
import argparse as ap # importing argparse module as ap
from unittest.main import main
import sys
import requests
import subprocess
from datetime import datetime
from requests.exceptions import SSLError # importing SSLError from requests module

# defining function for arugument parsing
def argparser():
    '''
    Input Patameter: None
    Return: args - Argument Value
    Purpose: To parse arguments from command line
    '''
    try: # error handling
        parser = ap.ArgumentParser(allow_abbrev=True ,description="This is a program to parse html data from a website.") # creating argument parser
        parser.add_argument("-u", "--url", type=str, required=True, help="Enter the full url to parse")  # adding argument for url
        parser.add_argument("-s", "--http_server", type=str, help="Enter Flag to start http server")  # adding argument for http server
        args = parser.parse_args() # parsing arguments
        return args # returning arguments

    except ValueError: # incase of invalid argument
        print("Invalid argument")
        sys.exit(1)

# defining function for html parsing
def htmlparser(url):
    '''
    Input Parameter: url - uniform resource locator for website to parse
    Return: data - Parsed html data in bytes
    Purpose: To parse html data of a given website
    '''
    try:
        data = requests.get(url) # getting html data from url
        return data.content # returning parsed html data

    except SSLError: # incase of ssl error
        print("There is problem with SSL of the website.")
        sys.exit(1)

    except requests.exceptions.MissingSchema: # incase of missing schema
        print("Invalid URL")
        sys.exit(1)
    
    except requests.exceptions.InvalidURL: # incase of invalid url
        print("Invalid URL")
        sys.exit(1)

    except requests.exceptions.ConnectionError: # incase of connection error
        print("Unable to connect to the website.")
        sys.exit(1)

    except requests.exceptions.InvalidSchema: # incase of invalid schema
        print("Invalid URL")
        sys.exit(1)

    except requests.exceptions.InvalidHeader: # incase of invalid header
        print("Invalid URL")
        sys.exit(1)

# defining the function for starting http server
def httpserver(flag):
    '''
    Input: flag - flag to start http server
    Return: None
    Purpose: To run http server if flag is given
    '''
    if flag != None: # checking if flag is given
        subprocess.call(["python3","-m","http.server","--bind","localhost","8888"]) # starting http server using subprocess module
    else: # if flag is not given
        print("HTTP Server has not been started as per arguments the user provided.")
    return None
    
# defining function to save parsed data in a file
def data_save(data):
    '''
    Input Parameter: data - parsed html data
    Return: None
    Purpose: To save parsed html data in a file
    '''
    try: #
        date = datetime.now().strftime("%Y%m%d%H%M%S") # date and time in format of YYYYMMDDHHMMSS
        name = "Get Response @" + date + ".html" # name of the file
        file_name = "Responses/" + name # full path of the file
        with open(file_name, 'wb') as file: # opening file in write mode
            file.write(data) # writing data in file
            file.close() # closing file
        print("Data is successfully saved with the filename {0}".format(name)) # printing message
        return None # returning None

    except:
        print("Invalid data") 
        sys.exit(1) # exiting with failure status

# defining main function    
def main():
    '''
    Input Parameter: None
    Return: None
    Purpose: Main module to call all required modules.
    '''
    try:
        arg = argparser() # calling argparser function
        url = arg.url # getting url from argument
        data = htmlparser(str(url)) # calling htmlparser function
        data_save(data) # calling data_save function
        httpserver(arg.http_server) # calling httpserver function
        return None

    except KeyboardInterrupt: # incase of programm termination by user
        print("Program is terminated by the User.") # printing message
        print("Exiting...")
        sys.exit(0) # exiting with success status

if __name__=='__main__':
    main() # calling main function
