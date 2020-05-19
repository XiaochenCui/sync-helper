# api: https://developers.google.com/drive/api/v3/reference/files

import json
import pprint
import pickle
import os.path
from pathlib import Path

from googleapiclient.discovery import build
from google_auth_oauthlib.flow import InstalledAppFlow
from google.auth.transport.requests import Request

# If modifying these scopes, delete the file token.pickle.
SCOPES = ["https://www.googleapis.com/auth/drive.metadata.readonly"]
SCOPES = ["https://www.googleapis.com/auth/drive.metadata"]
SCOPES = ["https://www.googleapis.com/auth/drive"]

pp = pprint.PrettyPrinter()
home = str(Path.home())


def init_service():
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
    return service


# 获取所有共享文件（由我创建的）
def get_shared_files():
    service = init_service()

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

            # 更新权限
            try:
                # update_file(f["id"])
                pass
            except Exception:
                pp.pprint(f)
                print("update failed")
                return

    print("shared file count: {}".format(len(shared_files)))
    for f in shared_files:
        print("文档名称: {} (链接： {})".format(f["name"], f["webViewLink"]))


def get_file():
    file_id = "1xhXR8Y_Lq-4vW2pTvHQLxFtjUDybfdNa4rspAMX96ns"
    service = init_service()
    result = service.files().get(fileId=file_id, fields="*").execute()
    # print(result)
    pp.pprint(result)
    import json

    print(json.dumps(result))


# 使文件分享为所有人有权限编辑
def update_file(file_id):
    service = init_service()

    # file_id = "1xhXR8Y_Lq-4vW2pTvHQLxFtjUDybfdNa4rspAMX96ns"

    # list permissions
    # result = service.files().get(fileId=file_id, fields="*").execute()
    # print("premissions:")
    # pp.pprint(result["permissions"])

    # insert permissions
    # new_permission = {"type": "anyone", "role": "commenter"}
    new_permission = {"type": "anyone", "role": "writer"}
    result = service.permissions().create(fileId=file_id, body=new_permission).execute()
    # print("insert finished, premissions:")
    # pp.pprint(result)

    # result = service.files().update(fileId=file_id, fields="*", key=None, a='b').execute()
    # print(result)


def new_func():
    from pydrive.auth import GoogleAuth
    from pydrive.drive import GoogleDrive

    gauth = GoogleAuth()
    gauth.settings["client_config_file"] = (
        home + "/Dropbox/secret/google_client_api_credentials.json"
    )
    gauth.settings["save_credentials_file"] = (
        home + "/Dropbox/secret/google_client_api_token.pickle"
    )
    gauth.LocalWebserverAuth()

    drive = GoogleDrive(gauth)

    # Create GoogleDriveFile instance with file id of file1.
    file2 = drive.ListFile()
    CreateFile({"id": file1["id"]})
    print("title: %s, mimeType: %s" % (file2["title"], file2["mimeType"]))
    # title: HelloWorld.txt, mimeType: text/plain


if __name__ == "__main__":
    get_shared_files()

    # update_file()

    # get_file()

    # new_func()
