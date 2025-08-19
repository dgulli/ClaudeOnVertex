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
    Open the `.env` file and replace `"your-gcp-project-id"` with your actual Google Cloud Project ID. This is the only variable you need to change for a standard setup.

    ```dotenv
    # .env
    # ...
    export ANTHROPIC_VERTEX_PROJECT_ID="your-gcp-project-id"
    # ...
    ```
    The region is defaulted to `us-central1`. If you need to use a different region, you can change the `ANTHROPIC_VERTEX_REGION` variable to any of the other supported regions listed in the file.

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
2.  **Validates Configuration:** Checks that a valid `ANTHROPIC_VERTEX_PROJECT_ID` is set and that `ANTHROPIC_VERTEX_REGION` is one of the supported regions.
3.  **Authenticates with GCP:** Prompts you to log in to your Google Cloud account using `gcloud auth login`.
4.  **Sets GCP Project:** Configures the `gcloud` CLI to use the project ID specified in your `.env` file.
5.  **Enables Vertex AI API:** Enables the `aiplatform.googleapis.com` service for your project.
6.  **Provides Reminders:** Reminds you of the manual steps that cannot be automated.
