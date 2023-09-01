from dotenv import load_dotenv
from os import environ

load_dotenv()

port = environ.get("PORT")

if port is None:
    raise Exception("Could not read from .env file. Did you specify a port?")

bind = f"0.0.0.0:{port}"  # Define the host and port
workers = 4  # Number of worker processes
