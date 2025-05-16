from fastapi import FastAPI
from auth import get_token, Account
from api_client import get_lubricants

app = FastAPI()


@app.post("/token")
def login_route(account: Account):
    return get_token(account)


@app.get("/lubricants")
def lubricants_route():
    return get_lubricants()
