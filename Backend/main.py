from fastapi import FastAPI
from Backend.routers import file, homepages, laboratories, mailer

app = FastAPI()

app.include_router(laboratories.router)
app.include_router(file.router)
app.include_router(homepages.router)
app.include_router(mailer.router)

