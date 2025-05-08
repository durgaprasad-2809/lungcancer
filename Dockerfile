# ✅ Use a fuller base image with prebuilt binary support
FROM python:3.9-buster

# 📁 Set working directory
WORKDIR /app

# 📦 Copy app files
COPY . /app

# 🚀 Upgrade pip and install dependencies with cleaned requirements
RUN pip install --upgrade pip && \
    grep -vE 'tf_nightly|numpy==' requirements.txt > temp_requirements.txt && \
    echo "numpy==1.23.5" >> temp_requirements.txt && \
    pip install --no-cache-dir -r temp_requirements.txt && \
    rm temp_requirements.txt

# 🔓 Expose port (adjust as needed)
EXPOSE 5000

# 🚀 Start the application
CMD ["python", "bot.py"]
