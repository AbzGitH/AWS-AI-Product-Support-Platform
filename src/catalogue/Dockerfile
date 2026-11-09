# Use a lightweight Python environment
FROM python:3.13-slim

# Set the application working directory
WORKDIR /app

# Prevent unnecessary Python cache files and buffered logs
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Install application dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application into the container
COPY app.py .

# Run the application as a non-root user
RUN useradd --create-home appuser
USER appuser

# Document the port used by the API
EXPOSE 8080

# Start the Flask application using a production WSGI server
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "app:app"]
