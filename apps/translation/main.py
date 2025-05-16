import os
import uuid
from google.cloud import storage
from google.cloud import translate_v2 as translate


# Environment variables (set in Cloud Function configuration)
SOURCE_BUCKET_NAME = os.environ.get("SOURCE_BUCKET_NAME")
TARGET_BUCKET_NAME = os.environ.get("TARGET_BUCKET_NAME")
TARGET_LANGUAGE = os.environ.get("TARGET_LANGUAGE", "fr")  # Default to French

def translate_file_on_upload(event, context):
    """
    Cloud Function triggered by file upload to a GCS bucket.
    Translates the content of the uploaded file and saves
    the translated content to another GCS bucket.
    """
    bucket_name = event['bucket']
    file_name = event['name']
    content_type = event.get('contentType', '')

    print(f"New file detected in bucket: {bucket_name}, file: {file_name}")

    if bucket_name == SOURCE_BUCKET_NAME:
        if not file_name.endswith('/'):  # Ignore directory uploads
            try:
                # Initialize GCS client
                storage_client = storage.Client()

                # Get the source bucket and file
                source_bucket = storage_client.bucket(SOURCE_BUCKET_NAME)
                source_blob = source_bucket.blob(file_name)

                # Download the file content
                file_content = source_blob.download_as_text()
                print(f"Successfully downloaded file: {file_name}, size: {len(file_content)} bytes")

                # Initialize Translate client
                translate_client = translate.Client()

                # Detect the source language
                detection_response = translate_client.detect_language(file_content)
                source_language = detection_response["language"]
                print(f"Detected source language: {source_language}")

                if source_language == TARGET_LANGUAGE:
                    print(f"Source language is the same as target language ({TARGET_LANGUAGE}). Skipping translation.")
                    return

                # Translate the text
                translation_response = translate_client.translate(
                    file_content,
                    target_language=TARGET_LANGUAGE,
                    source_language=source_language
                )
                translated_text = translation_response['translatedText']
                print(f"Successfully translated file to {TARGET_LANGUAGE}, size: {len(translated_text)} bytes")

                # Get the target bucket
                target_bucket = storage_client.bucket(TARGET_BUCKET_NAME)

                # Create the target blob name (e.g., translated_en_document.txt)
                base_name, ext = os.path.splitext(file_name)
                translated_file_name = f"{base_name}_translated_{TARGET_LANGUAGE}_{uuid.uuid4().hex}_{ext}"
                target_blob = target_bucket.blob(translated_file_name)

                # Upload the translated text to the target bucket
                target_blob.upload_from_string(translated_text, content_type=content_type)
                print(f"Successfully uploaded translated file to: {TARGET_BUCKET_NAME}/{translated_file_name}")

            except Exception as e:
                print(f"Error processing file {file_name}: {e}")
    else:
        print(f"File uploaded to a different bucket ({bucket_name}). Skipping.")
