#!/bin/bash

set -euo pipefail

# --- Input parameters ---
PROJECT_ID="$1"
STATE_BUCKET="$2"
REGION="$3"

# --- Validate parameters ---
if [ $# -ne 3 ]; then
  usage
fi

echo "Checking if GCS bucket exists: gs://${PROJECT_ID}-${STATE_BUCKET}"

if ! gsutil ls -b "gs://${PROJECT_ID}-${STATE_BUCKET}" > /dev/null 2>&1; then
  echo "Creating GCS bucket: ${PROJECT_ID}-${STATE_BUCKET}"
  gcloud storage buckets create "gs://terraform/state/${PROJECT_ID}-${STATE_BUCKET}" \
    --project="${PROJECT_ID}" \
    --location="${REGION}" \
    --uniform-bucket-level-access
else
  echo "GCS bucket already exists: ${PROJECT_ID}-${STATE_BUCKET}"
fi
