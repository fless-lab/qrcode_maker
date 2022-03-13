from fastapi import Body, FastAPI, HTTPException
from fastapi.responses import FileResponse
import qrcode
import os
from uuid import uuid4

def generateQRcode(link):
    myqrcode = qrcode.make(link)
    name = f"{str(uuid4()).replace('-','')}.jpg"
    temp = f"qrcodes/{name}"
    myqrcode.save(temp)
    return name



path = str(os.getcwd())
app = FastAPI()


@app.get("/")
def index():
    return "Bienvenu sur mon api de qrcode !"

@app.get("/get_qrcode")
def img(name:str):
    file_path = os.path.join(path,f"qrcodes/{name}")
    if (os.path.exists(file_path)):
        return FileResponse(file_path)
    raise HTTPException(status_code=400,detail=f"File not found at {path}")

@app.post("/qrcode",description="Cette API reçoit un lien et retourne un qrcode en format jpg")
def my_qrcode(link:str = Body(...)):
    return generateQRcode(link)