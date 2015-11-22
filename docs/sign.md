# 图片上传流程

S1: 用户进入图片上传页面并选择要上传的图片。

S2: 浏览器调用`生成又拍上传凭证`接口，获取上传参数。

S3: 浏览器调用又拍`HTML Form`上传接口，传入刚刚获取到的参数。

S4: 上传成功后，浏览器调用`更新二手帖子图片URL`接口。

# E1 生成又拍上传凭证

调用此接口需要登陆。

同一用户最小调用间隔时间为`1s`。

``` 
GET /api/user/sign
```

部分参数：

| 参数名        | 必填   | 说明      |
| ---------- | ---- | ------- |
| picType    | Y    | 图片的类型   |
| expiration | Y    | 同又拍对应参数 |

> 其它参数与又拍HTML FORM上传接口中的参数一致。

`picType`的取值为：

| 取值   | 含意         |
| ---- | ---------- |
| 0    | 与兼职相关的图片   |
| 1    | 与二手相关的图片   |
| 2    | 用户头像       |
| 3    | 商家认证时上传的照片 |
| 4    | 学生认证时上传的照片 |

如，对于请求

``` 
GET /api/user/sign?picType=1&expiration=827716
```

返回报文为：

``` json
{
  "message": "success",
  "code": 0,
  "data": {
    "sign": "aa4c5128a2c579ee92133ffb4344f065",
    "policy": "eyJzYXZlLWtleSI6Ii8yMDE1LzExLzEyL2YzNDdiM2JjNzkwZDkxMWI0YmFiZDVhMDVmNDY4NDA4IiwiYnVja2V0IjoidGFvbGlqaWUtcGljIiwiZXhwaXJhdGlvbiI6ODI3NzE2fQ==",
    "saveKey": "/2015/11/12/f347b3bc790d911b4babd5a05f468408"
  },
  "ok": true
}
```



# E2 更新二手帖子图片URL

用户在浏览器中上传图片到又拍成功后需调用此接口，将图片地址传入。

``` 
PUT /api/u/{shId}/pic
```

参数：

| 参数名     | 必填   | 说明               |
| ------- | ---- | ---------------- |
| shId    | Y    | 二手id, 在URL中包含该参数 |
| picAddr | Y    | 图片地址             |
|         |      |                  |

其中，`picAddr`是一个以`;`分隔的字符串，每个字符串表示图片在`bucket`中的路径。如：

``` 
/sh/1.jpg;/sh/121.jpg;/sh/888.jpg
```

表示该帖子有3张图片。



## E3 生成7牛上传token

调用此接口需要登陆。

同一用户最小调用间隔时间为`1s`。

``` 
GET /api/user/sign/n
```

返回报文：

``` json
{
  "message": "success",
  "code": 0,
  "data": {
    "sign": "jiCcIJ426S8uHSN4fqL5OGjEmqSdENWTnk4Ze8I6:xKTc1kWT4IyofIEBANgbfVoPt94=:eyJzY29wZSI6InRhb2xpamllOi8yMDE1LzExLzIyLzI4MGNhMTI5YTJhYjkwNGZhZmM3ZGI0ZTRhMDI0MjBmIiwiZGVhZGxpbmUiOjE0NDgyMDUwNDF9", // 对应token参数
    "saveKey": "/2015/11/22/280ca129a2ab904fafc7db4e4a02420f" // 对应key参数
  },
  "ok": true
}
```

