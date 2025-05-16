import requests
from config import API_EXTERNAL_URL
from auth import Account, get_token


def get_lubricants():
    url = f"{API_EXTERNAL_URL}/implantation/mobile/static/get_lubricants"
    credentials = Account(username="dev_intern", password="nTinIctUAtwAtO")
    token = get_token(credentials)
    access_token = token["access"]

    headers = {"Authorization": f"Bearer {access_token}"}

    response = requests.get(url, headers=headers)
    response.raise_for_status()

    return response.json()
