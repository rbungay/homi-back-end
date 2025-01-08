FROM python:3.11-slim

# Set the working directory
WORKDIR /app

# Install system dependencies required for psycopg2
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    gcc \
    libc6-dev \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Install pipenv
RUN pip install pipenv

# Copy Pipfile and Pipfile.lock
COPY Pipfile Pipfile.lock /app/

# Install dependencies from Pipfile
RUN pipenv install --deploy --ignore-pipfile

# Copy the rest of the code
COPY . /app/

# Expose port 8000
EXPOSE 8000

# Command to run the app
CMD ["pipenv", "run", "python", "manage.py", "runserver", "0.0.0.0:8000"]
