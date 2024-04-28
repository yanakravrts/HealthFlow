from fastapi import APIRouter, Query, Depends
from fastapi.responses import JSONResponse, RedirectResponse
from typing import List
from Backend.other.logger_file import logger
from Backend.other.error import Error
from Backend.other.models import Article, HelpResponse, AboutAs, ProfileName, BloodDonationCentersResponse
from Backend.base.supa_client import supabase_client
from datetime import datetime, timezone
from Backend.managers.mailer_manager import oauth2_scheme

router = APIRouter()
error = Error()


@router.get("/burger", response_model=ProfileName, tags=["homepages"])
async def burger(profile_id: str, token: str = Depends(oauth2_scheme)):
    """
    Retrieves the username of a profile from the database based on the provided profile ID.

    Query Parameters:
    - profile_id: A string representing the ID of the profile to retrieve.

    Response Model: ProfileName
    - username: A string representing the username of the profile.
    """
    try:
        response = supabase_client.supabase.table("user").select("name").eq("id", profile_id).execute()
        profile_data = response.data
        if profile_data:
            logger.info(f"Successfully retrieved profile with ID: {profile_id}")
            return {"username": profile_data[0]["name"]}
        else:
            return error.error_404(f"Profile with ID {profile_id} not found")
    except Exception as e:
        return error.error_500(e, "Internal Server Error")


@router.post("/burger/update_profile", tags=["homepages"])
async def update_user_profile(user_id: int = Query(..., description="User ID"),
                              name: str = Query(None, description="User name"),
                              sex_id: int = Query(None, description="User sex ID"),
                              email: str = Query(None, description="User email"),
                              birth_day_timestamp: int = Query(None, description="User birth day as Unix timestamp"),
                              token: str = Depends(oauth2_scheme)):
    """
    Updates the user profile with the provided information.

    Args:
        user_id (int): The ID of the user whose profile is to be updated.
        name (str, optional): The updated name of the user.
        sex_id (int, optional): The updated sex ID of the user.
        email (str, optional): The updated email of the user.
        birth_day_timestamp (int, optional): The updated birth day of the user as Unix timestamp.

    Returns:
        dict: The response from the database after updating the user profile.
    """
    try:
        current_user = supabase_client.supabase.table("user").select("name", "sex_id", "email", "birth_day").eq("id", user_id).execute().data
        if not current_user:
            return error.error_404("User not found")

        current_user = current_user[0]
        updated_user = {
            "name": name if name else current_user["name"],
            "sex_id": sex_id if sex_id else current_user["sex_id"],
            "email": email if email else current_user["email"],
            "birth_day": datetime.fromtimestamp(birth_day_timestamp, tz=timezone.utc).strftime('%Y-%m-%d') if birth_day_timestamp else current_user["birth_day"]
        }
        response = supabase_client.supabase.table("user").update(updated_user).eq("id", user_id).execute()
        return response
    except Exception as e:
        return error.error_500(e, f"An error occurred while trying to update the user profile: {str(e)}")


@router.get("/burger/help", response_model=HelpResponse, tags=["homepages"])
async def help(question: str = Query(..., title="Your Question", description="Please enter your question here"),
               token: str = Depends(oauth2_scheme)):
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


@router.get("/burger/blood_donation_centers/", response_model=BloodDonationCentersResponse, tags=["homepages"])
async def get_blood_donation_centers(blood_group: str = Query(..., title="Blood Group", description="Enter your blood group"),
                                     token: str = Depends(oauth2_scheme)):
    try:
        blood_group = blood_group.upper()
        logger.debug(f"Search for {blood_group} blood group")

        response = supabase_client.supabase.table("blood_need").select("bank_id").eq("blood_type", blood_group).execute()
        bank_ids = [data["bank_id"] for data in response.data]

        blood_donation_centers = []
        for bank_id in bank_ids:
            response = supabase_client.supabase.table("blood_bank").select("name", "address", "company", "latitude", "longitude", "status_id").eq("id", bank_id).execute()
            bank_data = response.data[0]
            blood_donation_centers.append(bank_data)

        if not blood_donation_centers:
            return error.error_404("No blood donation centers found for the specified blood group")
        else:
            logger.info("Banks of blood found")
            return {"blood_donation_centers": blood_donation_centers}
    except Exception as e:
        return error.error_500(e, "Internal Server Error")


@router.get("/burger/AboutAS", response_model=AboutAs, tags=["homepages"])
async def about_as(token: str = Depends(oauth2_scheme)):
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
async def home(token: str = Depends(oauth2_scheme)):
    """
    Retrieves a list of recent articles for the homepage.

    Returns:
        List[Article]: A list of recent articles, each containing the title and image URL.
    """
    try:
        num_articles = 2
        response = supabase_client.supabase.table("article").select("id", "title", "photo", "link", "timestamp", "text").execute()
        articles_data = response.data
        if articles_data:
            sorted_articles = sorted(articles_data, key=lambda x: x["timestamp"], reverse=True)
            selected_articles = sorted_articles[:num_articles]
            articles = []
            for article in selected_articles:
                articles.append(Article(title=article["title"], image=article["photo"], text=article["text"]))
            return articles
        else:
            return error.error_404("Not enough articles available")
    except Exception as e:
        return error.error_500(e, "Internal Server Error")


@router.get("/article/{article_id}", tags=["homepages"])
def read_article(article_id: int, token: str = Depends(oauth2_scheme)):
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
        response = supabase_client.supabase.table("article").select("id", "title", "photo", "link", "timestamp").execute()
        articles = response.data
        for article in articles:
            if article["id"] == article_id:
                logger.info(f"Successfully retrieved article with ID {article_id}")
                return article
        return error.error_404("Article not found")
    except Exception as e:
        return error.error_500(e, "Internal Server Error")


@router.get("/article/go_to_external_link/{article_id}", tags=["homepages"])
async def go_to_external_link(article_id: int, token: str = Depends(oauth2_scheme)):
    """
    Redirects the user to an external link associated with a specific article based on its ID.

    Path Parameters:
    - article_id (int): The unique identifier of the article to retrieve the external link.

    Response Model: RedirectResponse
    Redirects the user to the external link associated with the specified article.`
    """
    try:
        response = supabase_client.supabase.table("article").select("id", "title", "photo", "link", "timestamp").execute()
        articles = response.data
        article = next((article for article in articles if article["id"] == article_id), None)
        if article:
            logger.info(f"Redirecting to external link for article with ID {article_id}")
            return RedirectResponse(url=article["link"], status_code=302)
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
