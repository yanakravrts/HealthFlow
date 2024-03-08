from fastapi import APIRouter, Form, Query
from fastapi.responses import JSONResponse, RedirectResponse
from pydantic import EmailStr
from typing import List
from datetime import date
from Backend.other.logger_file import logger
from Backend.other.error import Error
from Backend.other.models import Profile, Article, HelpResponse, AboutAs, ProfileName, BloodDonationCenters, Event
from Backend.other.data import blood_donation_data, profiles, articles, articles1
import random

router = APIRouter()
error = Error()


@router.get("/burger", response_model=ProfileName, tags=["homepages"])

async def burger(profile_id: str):
    """
    Retrieves the username of a profile from the database based on the provided profile ID.

    Query Parameters:
    - profile_id: A string representing the ID of the profile to retrieve.

    Response Model: ProfileName
    - username: A string representing the username of the profile.
    """
    try:
        profile_data = profiles.get(profile_id)
        if profile_data:
            logger.info(f"Successfully retrieved profile with ID: {profile_id}")
            return {"username": profile_data["name"]}
        else:
            return error.error_404(f"Profile with ID {profile_id} not found")
    except Exception as e:
        return error.error_500(e, "Internal Server Error")
    


@router.post("/burger/change_profile", response_model=Profile, tags=["homepages"])

async def change_profile(
    profile_id: str,
    name: str = Form(...),
    dob: date = Form(...),
    email: EmailStr = Form(...),
):
    """
    Updates the profile information in the database for the provided profile ID.

    Request Body Parameters:
    - profile_id: A string representing the ID of the profile to update.
    - name: A string representing the new name for the profile.
    - dob: A date representing the new date of birth for the profile.
    - email: A string representing the new email address for the profile.

    Response Model: Profile
    - id: A string representing the ID of the updated profile.
    - name: A string representing the updated name of the profile.
    - dob: A date representing the updated date of birth of the profile.
    - email: A string representing the updated email address of the profile.
    """
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


@router.get("/burger/help", response_model=HelpResponse, tags=["homepages"])

async def help(question: str = Query(..., title="Your Question", description="Please enter your question here")):
    """
    Accepts a question from the user.

    Query Parameters:
    - question: A string representing the user's question.

    Response Model: HelpResponse
    - text: A string containing the response message acknowledging the user's question.
    """
    try:
        if not question:
            return error.error_404("Question text not found")
        else:
            logger.info(f"Received question: {question}")
            return JSONResponse(content={"text": "Thank you, we will look into your question"})
    except Exception as e:
        return error.error_500(e, "Internal Server Error")
    


@router.get("/burger/blood_donation_centers/", response_model=BloodDonationCenters, tags=["homepages"])

async def get_blood_donation_centers(blood_group: str = Query(..., title="Blood Group", description="Enter your blood group")):
    """
    Retrieves blood donation centers based on the specified blood group.

    Query Parameters:
    - blood_group: A string representing the blood group for which donation centers are requested.

    Response Model: BloodDonationCenters
    - blood_donation_centers: A list of strings representing the addresses of blood donation centers.
    """
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
    
    

@router.get("/burger/AboutAS", response_model=AboutAs, tags=["homepages"])

async def about_as():
    """
    Retrieves information about the HealthFlow app and its creators.

    Query Parameters: None

    Response Model: AboutAs
    - text: A string containing information about the HealthFlow app and its creators.
    """
    try:
        logger.info("Text about us")
        return JSONResponse(content={"text": "The HealthFlow app was created by the Elysian team..."})
    except Exception as e:
        return error.error_500(e, "Internal Server Error")
    


@router.get("/", response_model=List[Article], tags=["homepages"])

async def home():
    """
    Retrieves a list of random articles for the homepage.

    Query Parameters: None

    Response Model: List[Article]
    - Each element in the list represents an article and has the following attributes:
    - title: The title of the article.
    - image: The URL or path to the image associated with the article.
    """
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



@router.get("/article/{article_id}", response_model=Article, response_model_exclude={"id"}, tags=["homepages"])

def read_article(article_id: int):
    """
    Retrieves details of a specific article based on its ID.

    Path Parameters:
    - article_id (int): The unique identifier of the article to retrieve.

    Response Model: Article
    - The response represents the article and has the following attributes:
    - title: The title of the article.
    - content: The content of the article.
    - author: The author of the article.
    - published_at: The date and time when the article was published.
    """
    try:
        for article in articles:
            if article.id == article_id:
                logger.info(f"Successfully retrieved article with ID {article_id}")
                return article
            else:
                return error.error_404("Article not found")
    except Exception as e:
        return error.error_500(e, "Internal Server Error")
    

@router.get("/article/go_to_external_link/{article_id}", tags=["homepages"])

async def go_to_external_link(article_id: int):
    """
    Redirects the user to an external link associated with a specific article based on its ID.

    Path Parameters:
    - article_id (int): The unique identifier of the article to retrieve the external link.

    Response Model: RedirectResponse
    Redirects the user to the external link associated with the specified article.`
    """
    try:
        article = next((article for article in articles if article.id == article_id), None)
        if article:
            logger.info(f"Redirecting to external link for article with ID {article_id}")
            return RedirectResponse(url=article.link, status_code=302)
        else:
            return error.error_404("Article with ID {article_id} not found")
    except Exception as e:
        return error.error_500(e, "Internal Server Error")
    


# @app.get("/burger/change_profile/go_back")
# async def go_back():
#     try:
#         logger.info("Redirecting back to /burger")
#         return RedirectResponse(url="/burger", status_code=302)
#     except Exception as e:
#         return error.error_500(e, "Internal Server Error")
    

# @app.get("/burger/help/go_back")
# async def go_back():
#     try:
#         logger.info("Redirecting back to /burger")
#         return RedirectResponse(url="/burger", status_code=302)
#     except Exception as e:
#         return error.error_500(e, "Internal Server Error")
    
    
# @app.get("/burger/about_us/go_back")
# async def go_back():
#     try:
#         logger.info("Redirecting back to /burger")
#         return RedirectResponse(url="/burger", status_code=302)
#     except Exception as e:
#         return error.error_500(e, "Internal Server Error")
    
    
# @app.get("/burger/article/go_back")
# async def go_back():
#     try:
#         logger.info("Redirecting back to /burger")
#         return RedirectResponse(url="/burger", status_code=302)
#     except Exception as e:
#         return error.error_500(e, "Internal Server Error")


# @app.get("/burger/blood_donation_centers/go_back")
# async def go_back():
#     try:
#         logger.info("Redirecting back to /burger")
#         return RedirectResponse(url="/burger", status_code=302)
#     except Exception as e:
#         return error.error_500(e, "Internal Server Error")


# @app.get("/calendar")
# async def get_calendar():
#     try:
#         current_datetime = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
#         return JSONResponse(content={"current_datetime": current_datetime})
#     except Exception as e:
#         return error.error_500(e, "Internal Server Error")
    

# @app.post("/calendar/add_event", response_model= Event)
# async def add_event(event: Event):
#     try:
#         return event
#     except ValueError:
#         return error.error_422("The data is not correct")
#     except Exception as e:
#         return error.error_500(e, "Internal Server Error")