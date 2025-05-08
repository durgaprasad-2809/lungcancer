# Start from a Python base image
FROM python:3.9-slim

# Install system dependencies required for building pandas, numpy, etc.
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    libffi-dev \
    libssl-dev \
    libpq-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy all files
COPY . /app

# Upgrade pip and install Python dependencies
RUN pip install --upgrade pip && \
    grep -vE 'tf_nightly|numpy==' requirements.txt > temp_requirements.txt && \
    echo "numpy==1.23.5" >> temp_requirements.txt && \
    pip install --no-cache-dir -r temp_requirements.txt && \
    rm temp_requirements.txt

# Optional: expose a port
EXPOSE 5000

# Start the app
CMD ["python", "bot.py"]
