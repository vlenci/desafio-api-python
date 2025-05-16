from fastapi import FastAPI
from auth import get_token, Account
from api_client import get_user_data

app = FastAPI()


@app.post("/token")
def login_route(account: Account):
    return get_token(account)


@app.get("/usercorp")
def usercorp_route():
    return get_user_data()
