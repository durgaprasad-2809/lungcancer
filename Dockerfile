FROM python:3.9-slim

# Create and set working directory
RUN mkdir /app
WORKDIR /app

# Copy project files
COPY . /app

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Default command
CMD ["python3", "main.py"]
