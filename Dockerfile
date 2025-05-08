# Start from a Python base image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy all files
COPY . /app

# Upgrade pip and install dependencies
# Remove tf_nightly and numpy lines, replace with compatible numpy version
RUN pip install --upgrade pip && \
    grep -vE 'tf_nightly|numpy==' requirements.txt > temp_requirements.txt && \
    echo "numpy==1.23.5" >> temp_requirements.txt && \
    pip install --no-cache-dir -r temp_requirements.txt && \
    rm temp_requirements.txt

# Optional: expose a port (adjust if needed)
EXPOSE 5000

# Run the bot
CMD ["python", "bot.py"]
