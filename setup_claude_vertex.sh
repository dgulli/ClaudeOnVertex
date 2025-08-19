#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Configuration ---
# This script automates the setup for using Anthropic's Claude on Google Vertex AI.
# It enables the necessary API, validates configuration, and provides guidance.

# --- Pre-flight Checks ---
# Check if .env file exists and source it
if [ -f .env ]; then
  source .env
else
  echo "Error: .env file not found."
  echo "Please create a .env file with ANTHROPIC_VERTEX_PROJECT_ID."
  exit 1
fi

# Check if gcloud is installed
if ! command -v gcloud &> /dev/null; then
    echo "gcloud command could not be found. Please install the Google Cloud SDK."
    exit 1
fi

# --- Validation ---
# Validate required variables are set
if [ -z "$ANTHROPIC_VERTEX_PROJECT_ID" ] || [ "$ANTHROPIC_VERTEX_PROJECT_ID" == "your-gcp-project-id" ]; then
  echo "Error: ANTHROPIC_VERTEX_PROJECT_ID is not set in the .env file."
  exit 1
fi

echo "Configuration validated successfully."

# --- Main Setup ---
echo "Starting setup for Claude on Vertex AI..."

# Step 1: Authenticate with Google Cloud if not already logged in
echo "Step 1: Checking gcloud authentication status..."
if gcloud config get-value account > /dev/null 2>&1; then
  ACCOUNT=$(gcloud config get-value account)
  echo "--> Already authenticated as $ACCOUNT."
else
  echo "--> Not authenticated. Please log in to your Google Cloud account."
  gcloud auth login
fi

# Step 2: Set the active GCP project
echo "Step 2: Setting GCP project to $ANTHROPIC_VERTEX_PROJECT_ID..."
gcloud config set project $ANTHROPIC_VERTEX_PROJECT_ID

# Step 3: Enable the Vertex AI API
echo "Step 3: Enabling the Vertex AI API (aiplatform.googleapis.com)..."
gcloud services enable aiplatform.googleapis.com --project=$ANTHROPIC_VERTEX_PROJECT_ID

# Step 4: Grant IAM permissions for Vertex AI
echo "Step 4: Granting Vertex AI User role to the current user..."
ACCOUNT=$(gcloud config get-value account)
gcloud projects add-iam-policy-binding $ANTHROPIC_VERTEX_PROJECT_ID \
    --member="user:$ACCOUNT" \
    --role="roles/aiplatform.user"

# Step 5: Manual Steps Reminder
echo "Step 5: Manual steps required:"
echo " - Ensure your GCP account has billing enabled."
echo " - Request access to Claude models in the Vertex AI Model Garden."
echo "   (This is a manual step in the Google Cloud Console)"

echo "---"
echo "Setup complete!"
echo "Your environment is now configured to use Claude on Vertex AI."