import pprint
import pickle
import os.path
from googleapiclient.discovery import build
from google_auth_oauthlib.flow import InstalledAppFlow
from google.auth.transport.requests import Request

# If modifying these scopes, delete the file token.pickle.
SCOPES = ["https://www.googleapis.com/auth/drive.metadata.readonly"]
SCOPES = ["https://www.googleapis.com/auth/drive.metadata"]

pp = pprint.PrettyPrinter()

from pathlib import Path

home = str(Path.home())


def get_result():
    creds = None
    # The file token.pickle stores the user's access and refresh tokens, and is
    # created automatically when the authorization flow completes for the first
    # time.
    credential = home + "/Dropbox/secret/google_client_api_credentials.json"
    token = home + "/Dropbox/secret/google_client_api_token.pickle"
    if os.path.exists(token):
        with open(token, "rb") as token:
            creds = pickle.load(token)
    # If there are no (valid) credentials available, let the user log in.
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file(credential, SCOPES)
            creds = flow.run_local_server(port=0)
        # Save the credentials for the next run
        with open(token, "wb") as token:
            pickle.dump(creds, token)

    service = build("drive", "v3", credentials=creds)

    nextPageToken = ""
    # Call the Drive v3 API
    pageSize = 100
    all_files = []
    while True:
        results = (
            service.files()
            .list(
                pageSize=pageSize,
                # 控制输出范围
                # fields="nextPageToken, files(id, name, kind, mimeType)",
                fields="*",
                pageToken=nextPageToken,
            )
            .execute()
        )
        nextPageToken = results.get("nextPageToken", "")
        files = results["files"]
        all_files.extend(files)

        print(len(files))

        if len(files) < pageSize:
            break

    print("file count: {}".format(len(all_files)))

    # print shared files
    shared_files = []
    for f in all_files:
        if f["shared"] and f["ownedByMe"]:
            shared_files.append(f)
    print("shared file count: {}".format(len(shared_files)))
    for f in shared_files:
        print("文档名称: {}".format(f["name"]))
        print("文档链接: {}".format(f["webViewLink"]))


if __name__ == "__main__":
    get_result()
