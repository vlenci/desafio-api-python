from fastapi import HTTPException
import requests
from app.config import API_EXTERNAL_URL


def get_user_data(access_token: str):
    url = f"{API_EXTERNAL_URL}/usercorp"
    headers = {"Authorization": f"Bearer {access_token}"}
    try:
        response = requests.get(url=url, headers=headers)
        response.raise_for_status()
        return response.json()
    except requests.HTTPError as err:
        status = err.response.status_code
        try:
            detail = err.response.json()
        except ValueError:
            detail = err.response.text
        raise HTTPException(status_code=status, detail=detail)


def get_tree(access_token: str, site_id: int):
    url = f"{API_EXTERNAL_URL}/implantation/mobile/tree?site={site_id}"
    headers = {"Authorization": f"Bearer {access_token}"}
    try:
        response = requests.get(url=url, headers=headers)
        response.raise_for_status()
        return response.json()
    except requests.HTTPError as err:
        status = err.response.status_code
        try:
            detail = err.response.json()
        except ValueError:
            detail = err.response.text
        raise HTTPException(status_code=status, detail=detail)
