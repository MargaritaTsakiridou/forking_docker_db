# Use a compatible Databricks runtime base image
FROM databricksruntime/standard:16.4-LTS

# Create non-root user named deployment
#RUN useradd -m deployment

# Set working directory and ensure it's owned by the non-root user
WORKDIR /app
#RUN chown -R deployment:deployment /app

# Switch to non-root user
#USER deployment

# Copy requirements and install packages using Databricks Python
COPY requirements.txt .
RUN /databricks/python3/bin/pip install -r requirements.txt

# Copy script with correct ownership
COPY app.py .

# Default command (optional; can be overridden in job config)
#CMD ["/databricks/python3/bin/python", "app.py"]
