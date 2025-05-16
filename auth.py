from fastapi import HTTPException, Header
import requests
from config import API_EXTERNAL_URL
from pydantic import BaseModel


class Account(BaseModel):
    username: str
    password: str


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


def get_bearer_token(authorization: str = Header(...)) -> str:
    if not authorization.startswith("Bearer "):
        raise HTTPException(
            status_code=401, detail="Invalid authorization header format"
        )
    return authorization.split(" ")[1]


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
