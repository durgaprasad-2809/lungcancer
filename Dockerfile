# Use slim Python base image
FROM python:3.9-slim

# Install required build dependencies for compiling numpy and pandas
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    g++ \
    libffi-dev \
    libssl-dev \
    libpq-dev \
    python3-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files
COPY . /app

# Upgrade pip and install numpy first to ensure headers exist before building pandas
RUN pip install --upgrade pip && \
    pip install numpy==1.23.5 && \
    grep -vE 'tf_nightly|numpy==' requirements.txt | uniq > clean_requirements.txt && \
    pip install --no-cache-dir -r clean_requirements.txt && \
    rm clean_requirements.txt

# Expose port (optional)
EXPOSE 5000

# Run the application
CMD ["python", "bot.py"]
