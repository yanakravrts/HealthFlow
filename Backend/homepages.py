from fastapi import FastAPI, HTTPException, Query
from fastapi.responses import RedirectResponse
from datetime import datetime
import re

app = FastAPI()

article_title = "Example Article"
article_content = "This is the content of the article."
article_link = "https://www.figma.com/file/mVCdcvldOpw2F0DFff3TYk/HealthFlow?type=design&node-id=12-8&mode=design"
name = "Name"

email_regex = re.compile(r"[^@]+@[^@]+\.[^@]+")
name_regex = re.compile(r"^[A-Za-zА-Яа-я]+$")

@app.get("/")
async def read_root():
    return {"title": article_title, "content": article_content}


@app.get("/burger")
async def burger():
    return {"username": name}


def validate_name(name: str):
    return name and name_regex.match(name)


def validate_name(name: str):
    return name and name_regex.match(name)


def validate_date_format(date_string: str):
    try:
        datetime.strptime(date_string, "%Y-%m-%d")
        return True
    except ValueError:
        return False


def validate_email(email: str):
    return email and email_regex.match(email)


@app.get("/burger/change_profile")
async def change_profile(name: str = Query(...), dob: str = Query(...), email: str = Query(...)):
    if not validate_name(name) or not validate_date_format(dob) or not validate_email(email):
        return RedirectResponse(url=f"/burger/change_profile?name={name}&dob={dob}&email={email}")
    return {"message": "Profile changed successfully", "name": name, "dob": dob, "email": email}


@app.get("/burger/change_profile/go_back")
async def go_back():
    return RedirectResponse(url="/burger")


@app.get("/burger/help")
async def help(question: str = Query(..., title="Your Question", description="Please enter your question here")):
    return {"text": f"Thank you, we will look into your question"}


@app.get("/burger/help/go_back")
async def go_back():
    return RedirectResponse(url="/burger")


@app.get("/burger/about_us")
async def about_us():
    return {"message": "Learn more about us!"}


@app.get("/burger/about_us/go_back")
async def go_back():
    return RedirectResponse(url="/burger")


@app.get("/article")
async def read_article():
    return {
        "title": article_title,
        "content": article_content,
        "link": article_link
    }


@app.get("/article/go_back")
async def go_back():
    return RedirectResponse(url="/")


@app.get("/article/go_to_external_link")
async def go_to_external_link():
    return RedirectResponse(url=article_link)



@app.get("/burger/blood_bank")
async def blood_bank(blood_group: str = Query(..., title="Blood Group", description="Please enter your blood group"),
                     center_address: str = Query(..., title="Center Address", description="Please enter the center address")):
    return {"message": "Blood group successfully added",
            "blood_group": blood_group,
            "center_address": center_address}

