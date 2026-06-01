
# DASH-docker-databricks

A minimal proof-of-concept for running a custom Docker container on an Azure Databricks cluster.

## What it does

`app.py` calls the OneBenthic API (hosted on a CEFAS Posit Connect instance) with a set of filter parameters and prints a preview of the returned data. The script runs inside a Docker container built on Databricks' own base image, which makes it compatible with Databricks cluster runtimes.

## Why Docker on Databricks?

By default, Databricks clusters run a managed environment you can't fully control. A custom Docker image lets you pin exact package versions, include non-Python dependencies and save time on compiling large installs at cluster start-up.

## Files

| File | Purpose | Reuseable? |
|---|---|---|
| `Dockerfile` | Builds the container from the Databricks base image and installs dependencies | Basic template |
| `app.py` | Script that runs inside the container. It calls the OneBenthic API and prints a preview | Probably not.. unless you want a fairly pointless app on your cluster |
| `requirements.txt` | Python dependencies (`pandas`, `requests`, `tabulate`) | No |
| `.github/workflows/docker-build.yml` | GitHub Actions workflow that builds and pushes the image to Docker Hub | Basic template |

## Building the image

The Docker image is built and pushed automatically by the GitHub Actions workflow on every push to `main`. The image for this example is published to Docker Hub as `tomkdefra/onebenthic-app:latest`.

The workflow authenticates to Docker Hub using two repository secrets: `DOCKER_USERNAME` and `DOCKER_PAT` (a personal access token).

## Configuring a cluster on Databricks

1. In the Databricks UI, create or edit a cluster. Under **Advanced Options > Docker**, set the image URL to `<dockerhub-username>/<image-name>:<version>` e.g.: (tomkdefra/onebenthic-app:latest) and enter your Docker Hub username and PAT as the registry credentials.
