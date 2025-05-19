from fastapi import Depends, FastAPI
from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer
from auth import get_token, verify_token, refresh_token, Account
from api_client import get_user_data

app = FastAPI()
app_scheme = HTTPBearer()


@app.post("/token")
def login_route(account: Account):
    return get_token(account)


@app.post("/token/verify")
def verify_route(token: str):
    return verify_token(token)


@app.post("/token/refresh")
def refresh_route(token: str):
    return refresh_token(token)


@app.get("/usercorp")
def usercorp_route(credentials: HTTPAuthorizationCredentials = Depends(app_scheme)):
    token = credentials.credentials

    return get_user_data(token)
