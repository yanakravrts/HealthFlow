FROM python:3.9

WORKDIR /code

COPY requirements.txt /code/requirements.txt

RUN pip install  -r /code/requirements.txt

COPY Backend /code/Backend

CMD ["uvicorn", "Backend.main:app", "--proxy-headers", "--host", "0.0.0.0", "--port", "80"]
