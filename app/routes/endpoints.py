from fastapi import APIRouter, Depends
from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer
from app.auth.handlers import get_token, verify_token, refresh_token
from app.auth.models import Account
from app.services.portal import get_user_data, get_tree

router = APIRouter()
security = HTTPBearer()


@router.post("/token")
def login_route(account: Account):
    return get_token(account)


@router.post("/token/verify")
def verify_route(token: str):
    return verify_token(token)


@router.post("/token/refresh")
def refresh_route(token: str):
    return refresh_token(token)


@router.get("/usercorp")
def usercorp_route(credentials: HTTPAuthorizationCredentials = Depends(security)):
    token = credentials.credentials

    return get_user_data(token)


@router.get("/implantation/mobile/tree")
def tree_route(
    credentials: HTTPAuthorizationCredentials = Depends(security), site_id: int = 0
):
    token = credentials.credentials

    return get_tree(token, site_id)
