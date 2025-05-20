from fastapi import HTTPException
import requests
from app.config import API_EXTERNAL_URL
from app.auth.models import Account


def get_token(account: Account):
    url = f"{API_EXTERNAL_URL}/token"
    user_data = {"username": account.username, "password": account.password}
    try:
        response = requests.post(url, json=user_data)
        response.raise_for_status()
        return response.json()
    except requests.HTTPError as err:
        raise HTTPException(
            status_code=err.response.status_code, detail=err.response.json()
        )


def verify_token(token: str):
    url = f"{API_EXTERNAL_URL}/token/verify"
    token_data = {"token": token}
    try:
        response = requests.post(url, json=token_data)
        response.raise_for_status()
        return response.json()
    except requests.HTTPError as err:
        raise HTTPException(
            status_code=err.response.status_code, detail=err.response.json()
        )


def refresh_token(refresh: str):
    url = f"{API_EXTERNAL_URL}/token/refresh"
    token_data = {"refresh": refresh}
    try:
        response = requests.post(url, json=token_data)
        response.raise_for_status()
        return response.json()
    except requests.HTTPError as err:
        raise HTTPException(
            status_code=err.response.status_code, detail=err.response.json()
        )
