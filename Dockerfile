# Start from a Python base image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy all files
COPY . /app

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Optional: expose a port (adjust based on your app)
EXPOSE 5000

# Set the command to run your app (update as needed)
CMD ["python", "bot.py"]
