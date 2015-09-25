# 生成又拍上传凭证

``` 
GET /api/sign
```

部分参数：

| 参数名     | 必填   | 说明    | 
| ------- | ---- | ----- | 
| picType | Y    | 图片的类型 | 

`picType`的取值为：

| 取值   | 含意       | 
| ---- | -------- | 
| 0    | 与兼职相关的图片 | 
| 1    | 与二手相关的图片 | 
| 2    | 用户头像     | 

如，对于请求

``` 
GET /api/sign?picType=1&expiration=827716
```

返回报文为：

``` json
{
  "message": "success",
  "code": 0,
  "data": {
    "sign": "4dde086b4f7a87523f0f9a3f0b727657",
    "policy": "eyJzYXZlLWtleSI6InNoLTE5IiwiYnVja2V0IjoidGFvbGlqaWUtcGljIiwiZXhwaXJhdGlvbiI6ODI3NzE2fQ==",
    "saveKey": "sh-19"
  },
  "ok": true
}
```

