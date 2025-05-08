# Start from a Python base image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy all files
COPY . /app

# Fix numpy conflict by removing all pinned numpy and tf_nightly lines
RUN pip install --upgrade pip && \
    grep -vE 'tf_nightly|numpy==' requirements.txt > temp_requirements.txt && \
    echo "numpy==1.21.6" >> temp_requirements.txt && \
    pip install --no-cache-dir -r temp_requirements.txt && \
    rm temp_requirements.txt

# Optional: expose a port (adjust if needed)
EXPOSE 5000

# Set the default command
CMD ["python", "bot.py"]
