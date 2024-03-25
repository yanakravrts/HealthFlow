import hashlib

# Функція для хешування паролю
def hash_password(password: str) -> str:
    # Використовуємо sha256 для хешування паролю
    hashed_password = hashlib.sha256(password.encode()).hexdigest()
    return hashed_password
