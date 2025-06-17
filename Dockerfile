# Use a compatible Databricks runtime base image
FROM databricksruntime/standard:16.4-LTS

# Set working directory and ensure it's owned by the non-root user
WORKDIR /onebenthic

# Copy requirements and install packages using Databricks Python
COPY requirements.txt .
RUN /databricks/python3/bin/pip install -r requirements.txt

# Copy script with correct ownership
COPY app.py .
