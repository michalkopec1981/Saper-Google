# Użyj oficjalnego obrazu Python zgodnego z Twoim runtime.txt
FROM python:3.10-slim

# Ustaw zmienną środowiskową, aby uniknąć buforowania outputu przez Pythona
ENV PYTHONUNBUFFERED True

# Ustaw katalog roboczy
WORKDIR /app

# Skopiuj plik z zależnościami i zainstaluj je
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Skopiuj resztę plików aplikacji
COPY . .

# Aplikacja będzie uruchomiona przez Cloud Build, ale ENTRYPOINT jest dobrą praktyką
ENTRYPOINT ["gunicorn"]

# Domyślne polecenie startowe, które zostanie nadpisane przez Cloud Run
CMD ["--bind", ":8080", "--workers", "1", "--worker-class", "gevent", "app:app"]

