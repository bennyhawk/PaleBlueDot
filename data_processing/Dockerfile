FROM --platform=linux/amd64 python:3.9-slim
LABEL authors="swapnil"

# Set environment variables to prevent Python from writing .pyc files
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Install dependencies in one layer to reduce build time
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy source code files
COPY *.csv .
COPY main.py .

CMD ["python", "main.py"]