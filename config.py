from dotenv import load_dotenv
import os

load_dotenv()

API_EXTERNAL_URL = os.getenv("API_EXTERNAL_URL")
API_USERNAME = os.getenv("API_USERNAME")
API_PASSWORD = os.getenv("API_PASSWORD")
