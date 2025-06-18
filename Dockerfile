# Use a compatible Databricks runtime base image
FROM databricksruntime/standard:16.4-LTS

# Set working directory
WORKDIR /onebenthic

# Copy requirements and install packages using Databricks Python
COPY requirements.txt .
RUN /databricks/python3/bin/pip install -r requirements.txt

# Copy the python app
COPY app.py .
