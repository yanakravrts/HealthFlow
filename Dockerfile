FROM python:3.9

WORKDIR /code

COPY requirements.txt /code/requirements.txt

COPY .env /code/.env

RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

COPY Backend /code/Backend

CMD ["uvicorn", "Backend.main:app", "--proxy-headers", "--host", "0.0.0.0", "--port", "80"]
