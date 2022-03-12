from fastapi import Body, FastAPI, HTTPException
from fastapi.responses import FileResponse
import qrcode
import os
from uuid import uuid4


def generateQRcode(link):
    myqrcode = qrcode.make(link)
    name = f"qrcodes/{str(uuid4()).replace('-','')}.jpg"
    myqrcode.save(name)
    return name



path = str(os.getcwd())
app = FastAPI()


@app.get("/")
def index():
    return "Bienvenu sur mon api de qrcode !"

@app.post("/qrcode",description="Cette API reçoit un lien et retourne un qrcode en format jpg")
def my_qrcode(link:str = Body(...)):
    file_path = os.path.join(path,f"{generateQRcode(link)}")
    if (os.path.exists(file_path)):
        return FileResponse(file_path)
    raise HTTPException(status_code=404,detail=f"File not found at {file_path}")