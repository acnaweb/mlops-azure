"""Api"""

import logging
import uvicorn
from fastapi import FastAPI

LOG_FORMAT = "%(asctime)s %(message)s"
logging.basicConfig(level=logging.INFO, format=LOG_FORMAT)


app = FastAPI()


@app.get("/")
def index() -> str:
    """Index"""

    return "xpto"


if __name__ == "__main__":
    uvicorn.run(app)
