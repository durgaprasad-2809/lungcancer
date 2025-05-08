# Use full Debian-based Python image (more build tools pre-included)
FROM python:3.9-buster

# Set working directory
WORKDIR /app

# Copy app files
COPY . /app

# Upgrade pip and install dependencies in correct order
RUN pip install --upgrade pip && \
    pip install numpy==1.23.5 && \
    grep -vE 'tf_nightly|numpy==' requirements.txt > temp_requirements.txt && \
    pip install --no-cache-dir -r temp_requirements.txt && \
    rm temp_requirements.txt

# Expose port if needed
EXPOSE 5000

# Run the app
CMD ["python", "bot.py"]
