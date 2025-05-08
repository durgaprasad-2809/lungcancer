# Start with Debian-based image with Python
FROM python:3.9-slim-buster

# Install system packages needed for building pandas and numpy
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    libffi-dev \
    libssl-dev \
    libpq-dev \
    libatlas-base-dev \
    build-essential \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files
COPY . /app

# Install pip packages
RUN pip install --upgrade pip && \
    pip install numpy==1.23.5 && \
    grep -vE 'tf_nightly|numpy==' requirements.txt > temp_requirements.txt && \
    pip install --no-cache-dir -r temp_requirements.txt && \
    rm temp_requirements.txt

# Expose port for Flask/Tkinter if needed
EXPOSE 5000

# Default command
CMD ["python", "bot.py"]
