from pydantic import BaseModel, EmailStr, HttpUrl
from datetime import date
from typing import List

class ArticlePage(BaseModel):
    id: int
    title: str
    content: str
    link: HttpUrl
    image: HttpUrl

class Profile(BaseModel):
    name: str
    dob: date
    email: EmailStr

class Article(BaseModel):
    title: str
    image: HttpUrl

class HelpResponse(BaseModel):
    text: str

class AboutAs(BaseModel):
    text: str

class ProfileName(BaseModel):
    username: str

class BloodDonationCenters(BaseModel):
    blood_donation_centers: List[str]
