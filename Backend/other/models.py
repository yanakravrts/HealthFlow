from pydantic import BaseModel, EmailStr, HttpUrl
from datetime import date
from typing import List, Optional
from datetime import datetime

class Point(BaseModel):
    id: int
    name: str
    latitude: float
    longitude: float
    
class Event(BaseModel):
    title: str
    city: str
    date_time: datetime

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

class BloodDonationCenter(BaseModel):
    name: str
    address: str
    company: Optional[str]
    latitude: Optional[float]
    longitude: Optional[float]
    status_id: Optional[int]

class BloodDonationCentersResponse(BaseModel):
    blood_donation_centers: List[BloodDonationCenter]

class EmailSchema(BaseModel):
    """
    Pydantic model representing the structure of email data.
    """
    receiver_email: EmailStr
    subject: str
    body: str

class User(BaseModel):
    email: str
    password: str


class User(BaseModel):
    name: str
    sex_id: int
    email: EmailStr
    birth_day: str
