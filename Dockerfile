# Use a slightly more complete base image
FROM python:3.9-slim-buster

# Install essential system dependencies for building packages like pandas and numpy
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    libffi-dev \
    libssl-dev \
    libpq-dev \
    libatlas-base-dev \
    build-essential \
    python3-dev \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files
COPY . /app

# Upgrade pip and install numpy first to provide header files
RUN pip install --upgrade pip && \
    pip install numpy==1.23.5 && \
    grep -vE 'tf_nightly|numpy==' requirements.txt > temp_requirements.txt && \
    pip install --no-cache-dir -r temp_requirements.txt && \
    rm temp_requirements.txt

# Expose the port if needed
EXPOSE 5000

# Start the application
CMD ["python", "bot.py"]
