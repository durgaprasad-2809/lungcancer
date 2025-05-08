# Start from a compatible Python base image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy all files to the container
COPY . /app

# Upgrade pip and install dependencies (excluding incompatible tf_nightly)
RUN pip install --upgrade pip && \
    grep -v 'tf_nightly' requirements.txt > temp_requirements.txt && \
    pip install --no-cache-dir -r temp_requirements.txt && \
    rm temp_requirements.txt

# Optional: expose port if running a Flask or similar web app
EXPOSE 5000

# Set the default command to run your app
CMD ["python", "bot.py"]
