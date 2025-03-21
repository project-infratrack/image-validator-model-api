FROM python:3.12-slim

WORKDIR /app

# Copy Pipenv files and install Pipenv
COPY ./Pipfile ./Pipfile.lock ./
RUN pip install pipenv

# Install dependencies using Pipenv (within the virtual environment)
RUN pipenv sync --system --dev

# Copy the application code
COPY ./ ./

EXPOSE 8000

# Run the application using Uvicorn
CMD ["uvicorn", "deployApi:app", "--host", "0.0.0.0", "--port", "8000"]