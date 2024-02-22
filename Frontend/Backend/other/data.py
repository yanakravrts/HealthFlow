from Backend.other.models import ArticlePage, Article

blood_donation_data = {
    "Address1": "A+",
    "Address2": "B-",
    "Address3": "A+",
}

profiles = {
    "1": {
        "name": "John Doe",
        "dob": "1990-05-15",
        "email": "john.doe@example.com",
    },
    "2": {
        "name": "Jane Smith",
        "dob": "1985-08-22",
        "email": "jane.smith@example.com",
    },
}

articles = [
    ArticlePage(id=1, title="Article 1", content="Content of Article 1", link="https://www.figma.com", image="https://example.com/image/1"),
    ArticlePage(id=2, title="Article 2", content="Content of Article 2", link="https://example.com/article/2", image="https://example.com/image/2"),
    ArticlePage(id=3, title="Article 3", content="Content of Article 3", link="https://example.com/article/3", image="https://example.com/image/3"),
]

articles1 = [
    Article(title="Article 1", image="https://example.com/article/1"),
    Article(title="Article 2", image="https://example.com/article/2"),
    Article(title="Article 3", image="https://example.com/article/3"),
]
