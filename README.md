# Claude on Vertex AI Setup

This repository contains a script to automate the setup process for using Anthropic's Claude models on Google Cloud's Vertex AI. The script is based on the official documentation found [here](https://docs.anthropic.com/en/docs/claude-code/google-vertex-ai).

## Prerequisites

Before you begin, ensure you have the following:

1.  A Google Cloud Platform (GCP) account with billing enabled.
2.  The [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) (`gcloud`) installed on your local machine.
3.  Requested access to the Claude models in the Vertex AI Model Garden.

## Setup Instructions

1.  **Clone the repository (if you haven't already):**
    ```bash
    git clone <repository-url>
    cd <repository-directory>
    ```

2.  **Configure Your Project ID:**
    Copy the `.env.template` file to `.env` and replace `"dgulli-host"` with your actual Google Cloud Project ID. This is the only variable you need to change. All other settings are pre-configured.

    ```bash
    cp .env.template .env
    ```

    Then edit the `.env` file:
    ```dotenv
    # .env
    # Replace with your actual Google Cloud Project ID
    export ANTHROPIC_VERTEX_PROJECT_ID="your-gcp-project-id"
    
    # Pre-configured settings (do not change)
    export CLAUDE_CODE_USE_VERTEX=1
    export CLOUD_ML_REGION=us-east5
    export DISABLE_PROMPT_CACHING=1
    ```

3.  **Make the script executable:**
    ```bash
    chmod +x setup_claude_vertex.sh
    ```

4.  **Run the setup script:**
    ```bash
    ./setup_claude_vertex.sh
    ```

## What the Script Does

The `setup_claude_vertex.sh` script performs the following actions:

1.  **Sources Environment Variables:** Loads the configuration from your `.env` file.
2.  **Validates Configuration:** Checks that a valid `ANTHROPIC_VERTEX_PROJECT_ID` is set and `gcloud` is installed.
3.  **Authenticates with GCP:** Checks if you are logged in to `gcloud` and prompts you to log in if necessary.
4.  **Sets GCP Project:** Configures the `gcloud` CLI to use the project ID specified in your `.env` file.
5.  **Enables Vertex AI API:** Enables the `aiplatform.googleapis.com` service for your project.
6.  **Grants IAM Permissions:** Automatically grants the `roles/aiplatform.user` role to your authenticated account.
7.  **Sets Environment Variables:** Configures Claude Code to use Vertex AI with the us-east5 region.
8.  **Provides Reminders:** Reminds you of the manual steps that cannot be automated.

## Configuration Details

The `.env` file contains the following settings:

- **ANTHROPIC_VERTEX_PROJECT_ID**: Your Google Cloud Project ID (required)
- **CLAUDE_CODE_USE_VERTEX**: Enables Vertex AI integration (pre-configured to 1)
- **CLOUD_ML_REGION**: GCP region for Claude models (pre-configured to us-east5)
- **DISABLE_PROMPT_CACHING**: Disables prompt caching (pre-configured to 1)

Optional model configuration (commented out by default):
- **ANTHROPIC_VERTEX_MODELS**: Specific models to use
- **ANTHROPIC_VERTEX_DEFAULT_MODEL**: Default model selection

## Manual Steps Required

After running the setup script, you still need to:

1. **Enable Billing:** Ensure your GCP project has billing enabled
2. **Request Model Access:** Request access to Claude models in the Vertex AI Model Garden through the Google Cloud Console

## Troubleshooting

- If you encounter permission errors, ensure your account has the necessary IAM roles
- If the Vertex AI API is not available in your region, the script defaults to us-east5
- Check that your project ID is correct in the `.env` file
