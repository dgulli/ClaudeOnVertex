#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Configuration ---
# This script automates the setup for using Anthropic's Claude on Google Vertex AI.
# It enables the necessary API and provides guidance on manual setup steps.

# --- Pre-flight Checks ---
# Check if .env file exists and source it
if [ -f .env ]; then
  source .env
else
  echo "Error: .env file not found."
  echo "Please create a .env file with ANTHROPIC_VERTEX_PROJECT_ID and ANTHROPIC_VERTEX_REGION."
  exit 1
fi

# Check if gcloud is installed
if ! command -v gcloud &> /dev/null; then
    echo "gcloud command could not be found. Please install the Google Cloud SDK."
    exit 1
fi

# --- Main Setup ---
echo "Starting setup for Claude on Vertex AI..."

# Step 1: Authenticate with Google Cloud
echo "Step 1: Authenticating with Google Cloud..."
gcloud auth login
gcloud config set project $ANTHROPIC_VERTEX_PROJECT_ID

# Step 2: Enable the Vertex AI API
echo "Step 2: Enabling the Vertex AI API (aiplatform.googleapis.com)..."
gcloud services enable aiplatform.googleapis.com --project=$ANTHROPIC_VERTEX_PROJECT_ID

# Step 3: Manual Steps Reminder
echo "Step 3: Manual steps required:"
echo " - Ensure your GCP account has billing enabled."
echo " - Request access to Claude models in the Vertex AI Model Garden."
echo "   (This is a manual step in the Google Cloud Console)"

echo "---"
echo "Setup complete!"
echo "Your environment is now configured to use Claude on Vertex AI."
echo "Remember to set the ANTHROPIC_VERTEX_ENABLE=true environment variable in your application to activate the Vertex AI integration."
