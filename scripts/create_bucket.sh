#!/bin/bash
set -e

# Expect these env vars to be injected from the GitHub Actions workflow:
# - STATE_BUCKET
# - STATE_BUCKET_REGION
# - GCP_PROJECT_ID

echo "Checking if GCS bucket exists: gs://${STATE_BUCKET}"

if ! gsutil ls -b "gs://${STATE_BUCKET}" > /dev/null 2>&1; then
  echo "Creating GCS bucket: ${STATE_BUCKET}"
  gcloud storage buckets create "${STATE_BUCKET}" \
    --project="${GCP_PROJECT_ID}" \
    --location="${STATE_BUCKET_REGION}"
else
  echo "GCS bucket already exists: ${STATE_BUCKET}"
fi
