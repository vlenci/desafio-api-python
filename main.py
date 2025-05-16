from fastapi import FastAPI
from auth import get_token, Account

app = FastAPI()


@app.post("/token")
def token_route(account: Account):
    return get_token(account)
