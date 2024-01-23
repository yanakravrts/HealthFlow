from fastapi import FastAPI, Form, Query
from fastapi.responses import JSONResponse, RedirectResponse
from pydantic import BaseModel, EmailStr
from typing import List
from datetime import date
from logger_file import logger
from error import Error
from models import ArticlePage, Profile, Article, HelpResponse, AboutAs, ProfileName, BloodDonationCenters
from data import blood_donation_data, profiles, articles, articles1
import random

app = FastAPI()
error = Error()

@app.get("/burger", response_model=ProfileName)
async def burger(profile_id: str):
    try:
        profile_data = profiles.get(profile_id)
        if profile_data:
            logger.info(f"Successfully retrieved profile with ID: {profile_id}")
            return {"username": profile_data["name"]}
        else:
            return error.error_404(f"Profile with ID {profile_id} not found")
    except Exception as e:
        return error.error_500(e, "Internal Server Error")
    
@app.post("/burger/change_profile", response_model=Profile)
async def change_profile(
    profile_id: str,
    name: str = Form(...),
    dob: date = Form(...),
    email: EmailStr = Form(...),
):
    logger.debug(f"Changing profile with ID: {profile_id}")
    try:
        if profile_id in profiles:
            profiles[profile_id].update({
                "name": name,
                "dob": dob,
                "email": email,
            })
            logger.info(f"Profile updated successfully. New data: {profiles[profile_id]}")
            return profiles[profile_id]
        else:
            return error.error_404("Profile not found")
    except Exception as e:
        return error.error_500(e, "Internal Server Error")

    
@app.get("/burger/help", response_model=HelpResponse)
async def help(question: str = Query(..., title="Your Question", description="Please enter your question here")):
    try:
        if not question:
            return error.error_404("Question text not found")
        else:
            logger.info(f"Received question: {question}")
            return JSONResponse(content={"text": "Thank you, we will look into your question"})
    except Exception as e:
        return error.error_500(e, "Internal Server Error")
    

@app.get("/burger/blood_donation_centers/", response_model=BloodDonationCenters)
async def get_blood_donation_centers(blood_group: str = Query(..., title="Blood Group", description="Enter your blood group")):
    try:
        blood_group = blood_group.upper()
        logger.debug(f"Search for {blood_group} blood group")
        addresses = [address for address, group in blood_donation_data.items() if group == blood_group]
        if not addresses:
            return error.error_404("No blood donation centers found for the specified blood group")
        else:
            logger.info(f"Banks of blood found")
            return {"blood_donation_centers": addresses}
    except Exception as e:
        return error.error_500(e, "Internal Server Error")
    
    
@app.get("/burger/AboutAS", response_model=AboutAs)
async def help():
    try:
        logger.info("Text about us")
        return JSONResponse(content={"text": "The HealthFlow app was created by the Elysian team..."})
    except Exception as e:
        return error.error_500(e, "Internal Server Error")
    

@app.get("/", response_model=List[Article])
async def home():
    try:
        num_articles = 2
        random_articles = [random.choice(articles1) for _ in range(min(num_articles, len(articles1)))]
        articles_data = [{"title": article.title, "image": str(article.image)} for article in random_articles]
        logger.info("Successfully retrieved random articles")
        return articles_data
    except ValueError:
        return error.error_404("Not enough articles available")
    except Exception as e:
        return error.error_500(e, "Internal Server Error")

@app.get("/article/{article_id}", response_model=Article, response_model_exclude={"id"})
def read_article(article_id: int):
    try:
        for article in articles:
            if article.id == article_id:
                logger.info(f"Successfully retrieved article with ID {article_id}")
                return article
            else:
                return error.error_404("Article not found")
    except Exception as e:
        return error.error_500(e, "Internal Server Error")


@app.get("/burger/change_profile/go_back")
async def go_back():
    try:
        logger.info("Redirecting back to /burger")
        return RedirectResponse(url="/burger", status_code=302)
    except Exception as e:
        return error.error_500(e, "Internal Server Error")
    

@app.get("/burger/help/go_back")
async def go_back():
    try:
        logger.info("Redirecting back to /burger")
        return RedirectResponse(url="/burger", status_code=302)
    except Exception as e:
        return error.error_500(e, "Internal Server Error")
    
    
@app.get("/burger/about_us/go_back")
async def go_back():
    try:
        logger.info("Redirecting back to /burger")
        return RedirectResponse(url="/burger", status_code=302)
    except Exception as e:
        return error.error_500(e, "Internal Server Error")
    
    
@app.get("/burger/article/go_back")
async def go_back():
    try:
        logger.info("Redirecting back to /burger")
        return RedirectResponse(url="/burger", status_code=302)
    except Exception as e:
        return error.error_500(e, "Internal Server Error")


@app.get("/burger/blood_donation_centers/go_back")
async def go_back():
    try:
        logger.info("Redirecting back to /burger")
        return RedirectResponse(url="/burger", status_code=302)
    except Exception as e:
        return error.error_500(e, "Internal Server Error")


@app.get("/article/go_to_external_link/{article_id}")
async def go_to_external_link(article_id: int):
    try:
        article = next((article for article in articles if article.id == article_id), None)
        if article:
            logger.info(f"Redirecting to external link for article with ID {article_id}")
            return RedirectResponse(url=article.link, status_code=302)
        else:
            return error.error_404("Article with ID {article_id} not found")
    except Exception as e:
        return error.error_500(e, "Internal Server Error")
    

