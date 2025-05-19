import os
from google.cloud import storage
from google.cloud import texttospeech

TARGET_LANGUAGE = os.environ.get("TARGET_LANGUAGE") # Set in Cloud Function configuration

def text_to_speech_converter(data, context):
    """
    This Cloud Function is triggered by a file upload to a Cloud Storage bucket.
    It takes the text content of the uploaded file, converts it to speech using
    the Google Text-to-Speech API, and uploads the resulting audio file to
    another Cloud Storage bucket.

    Args:
        data (dict): The event payload.
        context (google.cloud.functions_v1.context.Context): The event context.
    """
    # 1. Set up variables from environment and event
    source_bucket_name = data['bucket']
    source_file_name = data['name']
    destination_bucket_name = os.environ.get('TARGET_BUCKET_NAME')  # Get from environment variable
    if not destination_bucket_name:
        raise ValueError("Destination bucket name is not set in environment variable DESTINATION_BUCKET")

    # 2. Logging for debugging
    print(f"File {source_file_name} uploaded to {source_bucket_name}.")
    print(f"Destination bucket: {destination_bucket_name}")

    # 3. Check if the uploaded file is a text file
    if not source_file_name.lower().endswith(('.txt', '.md', '.rst')):
        print(f"File {source_file_name} is not a text file. Skipping Text-to-Speech conversion.")
        return  # Exit the function

    # 4. Initialize Cloud Storage and Text-to-Speech clients
    storage_client = storage.Client()
    tts_client = texttospeech.TextToSpeechClient()

    # 5. Get the text content from the uploaded file
    source_bucket = storage_client.bucket(source_bucket_name)
    source_blob = source_bucket.blob(source_file_name)
    try:
        text_content = source_blob.download_as_text()
    except Exception as e:
        print(f"Error downloading {source_file_name} from {source_bucket_name}: {e}")
        return  # Exit if download fails

    print(f"Downloaded {source_file_name} successfully.")

    # 6. Create Text-to-Speech request
    synthesis_input = texttospeech.SynthesisInput(text=text_content)
    voice = texttospeech.VoiceSelectionParams(
        language_code = TARGET_LANGUAGE,  # You can change the language code
        ssml_gender=texttospeech.SsmlVoiceGender.MALE,  # You can change the gender
    )
    audio_config = texttospeech.AudioConfig(
        audio_encoding=texttospeech.AudioEncoding.MP3  # You can change the encoding
    )

    # 7. Call the Text-to-Speech API
    try:
        response = tts_client.synthesize_speech(
            input=synthesis_input, voice=voice, audio_config=audio_config
        )
    except Exception as e:
        print(f"Error calling Text-to-Speech API: {e}")
        return  # Exit if TTS fails

    print("Text-to-Speech API call successful.")

    # 8. Upload the audio file to the destination bucket
    destination_bucket = storage_client.bucket(destination_bucket_name)
    # Generate a unique filename for the audio file
    audio_file_name = os.path.splitext(source_file_name)[0] + ".mp3"
    destination_blob = destination_bucket.blob(audio_file_name)

    try:
        destination_blob.upload_from_string(response.audio.audio_content)
    except Exception as e:
        print(f"Error uploading audio file to {destination_bucket_name}: {e}")
        return  # Exit if upload fails

    print(f"Uploaded audio file {audio_file_name} to {destination_bucket_name}.")
    print("Function execution completed.")
