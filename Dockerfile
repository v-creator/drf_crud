FROM python:3.9

WORKDIR /src

COPY ./requirements.txt /src/requirements.txt
RUN pip install -r /src/requirements.txt

COPY . /src

ARG DRF_GRUD
ENV SECRET_KEY=django-insecure-nw^y+m^wmxza1asgk+)!ua2qx9)g+#v=6%76-9i8i(6eqiw94j \
    DEBUG=True \
    ALLOWED_HOSTS=89.108.79.43 \
    DB_ENGINE=django.db.backends.sqlite3 \
    DB_NAME=netology_stocks_products \
    DB_HOST=127.0.0.1 \
    DB_PORT=5432

RUN python manage.py migrate
RUN python manage.py collectstatic

EXPOSE 8000

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "stocks_products.wsgi"]