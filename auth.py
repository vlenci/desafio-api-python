import requests
from config import API_EXTERNAL_URL
from pydantic import BaseModel


class Account(BaseModel):
    username: str
    password: str


def get_token(account: Account):
    url = f"{API_EXTERNAL_URL}/token"
    user_data = {"username": account.username, "password": account.password}
    response = requests.post(url, data=user_data)
    response.raise_for_status()
    return response.json()
