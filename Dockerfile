# Use slim Python image
FROM python:3.9-slim

# Install build dependencies for pandas, numpy, etc.
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc g++ build-essential \
    libffi-dev libssl-dev libpq-dev python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy code
COPY . /app

# Clean requirements and install dependencies
RUN pip install --upgrade pip && \
    # remove duplicates and problematic packages
    grep -vE 'tf_nightly|numpy==' requirements.txt | uniq > clean_requirements.txt && \
    echo "numpy==1.23.5" >> clean_requirements.txt && \
    pip install --no-cache-dir -r clean_requirements.txt && \
    rm clean_requirements.txt

# Expose port (if needed)
EXPOSE 5000

# Run the app
CMD ["python", "bot.py"]
