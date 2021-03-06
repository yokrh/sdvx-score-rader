#!/usr/bin/env bash

# Change env configuration
cp .env envbackup
# Create temporary backup
sed 's/ENV=development/ENV=production/g' envbackup > .env
# Prepare GCP SA Credentials
sh ./copy_sa_credentials.sh
# Build a container image, push it to the GCP Container Registory, and deploy new one to Cloud Run
gcloud builds submit --config=./cloud-build.yml
# Delete temporary backup
cp envbackup .env && rm envbackup


#---------------------------------------------#
# The following traditional method is unused. #
# Use GCP cloud-build instead.                #
#---------------------------------------------#

# Variables
# IMAGE_NAME=sdvx-score-rader-api
# IMAGE_VERSION=1.0.0
# CONTAINER_REGISTRY_URL=
# CONTAINER_REGISTRY_USERNAME=
# CONTAINER_REGISTRY_PASSWORD=
# CONTAINER_REPOSITORY_URL=

# Push a container image
# echo $CONTAINER_REGISTRY_PASSWORD | docker login -u=$CONTAINER_REGISTRY_USERNAME --password-stdin $CONTAINER_REGISTRY_URL
# docker tag $IMAGE_NAME:$IMAGE_VERSION $CONTAINER_REPOSITORY_URL:$IMAGE_VERSION
# docker push $CONTAINER_REPOSITORY_URL:$IMAGE_VERSION
