
# DASH-docker-databricks

A minimal proof-of-concept for running a custom Docker container on an Azure Databricks cluster.

## What it does

`app.py` calls the OneBenthic API (hosted on a CEFAS Posit Connect instance) with a set of filter parameters and prints a preview of the returned data. The script runs inside a Docker container built on Databricks' own base image, which makes it compatible with Databricks cluster runtimes.

## Why Docker on Databricks?

By default, Databricks clusters run a managed environment you can't fully control. A custom Docker image lets you pin exact package versions, include non-Python dependencies, and reproduce the environment precisely — locally and on the cluster.

## Files

| File | Purpose |
|---|---|
| `Dockerfile` | Builds the container from the Databricks base image and installs dependencies |
| `app.py` | Script that runs inside the container — calls the OneBenthic API and prints a preview |
| `requirements.txt` | Python dependencies (`pandas`, `requests`, `tabulate`) |
| `.github/workflows/docker-build.yml` | GitHub Actions workflow that builds and pushes the image to Docker Hub |

## Building the image

The Docker image is built and pushed automatically by the GitHub Actions workflow on every push to `main`. The image is published to Docker Hub as `tomkdefra/onebenthic-app:latest`.

The workflow authenticates to Docker Hub using two repository secrets: `DOCKER_USERNAME` and `DOCKER_PAT` (a personal access token).

## Running on Databricks

1. In the Databricks UI, create or edit a cluster. Under **Advanced Options > Docker**, set the image URL to `tomkdefra/onebenthic-app:latest` and enter your Docker Hub username and PAT as the registry credentials.
2. Attach a notebook to that cluster.
3. In a shell cell, run:

```sh
%sh python /onebenthic/app.py
```
