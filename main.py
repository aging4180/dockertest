from fastapi import FastAPI
from fastapi.responses import FileResponse
from pydantic import BaseModel
import opencc

converter_opencc = opencc.OpenCC('tw2s.json')
converter_opencc_to_tc = opencc.OpenCC('s2tw.json')

def converter_t2s(s:str):
    ret = ""
    temp = converter_opencc.convert(s)
    for idx,h in enumerate(temp):
        if ord(h) > 0xffff:
            o = s[idx]
            if o == h:
                ret += converter_opencc_to_tc.convert(h)
            else:
                ret += o
        else:
            ret += h
    return ret

app = FastAPI()

@app.get("/tw2s")
async def get_json(q: str = ""):
    return {"data": converter_t2s(q)}

class Item(BaseModel):
    q: str = ''

@app.post("/tw2s")
async def create_item(item: Item):
    return { "data": converter_t2s(item.q) }

@app.get("/s2tw")
async def get_json(q: str = ""):
    return {"data": converter_opencc_to_tc.convert(q)}

@app.post("/s2tw")
async def create_item(item: Item):
    return { "data": converter_opencc_to_tc.convert(item.q) }

@app.get("/", response_class=FileResponse)
async def get_html():
    return "res.html"

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=3000)
