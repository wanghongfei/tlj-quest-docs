# 图片上传流程

S1: 用户进入图片上传页面并选择要上传的图片。

S2: 浏览器调用`生成又拍上传凭证`接口，获取上传参数。

S3: 浏览器调用又拍`HTML Form`上传接口，传入刚刚获取到的参数。

S4: 上传成功后，浏览器调用`更新二手帖子图片URL`接口。

# 生成又拍上传凭证

调用此接口需要登陆。

同一用户最小调用间隔时间为`2s`。

``` 
GET /api/user/sign
```

部分参数：

| 参数名     | 必填   | 说明    | 
| ------- | ---- | ----- | 
| picType | Y    | 图片的类型 | 

> 其它参数与又拍HTML FORM上传接口中的参数一致。

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
    "sign": "2b405758a6bbd83de95a3cc2beb2ac8d",
    "policy": "eyJzYXZlLWtleSI6Ii8yMDE1LzgvMjcvam9iLTE4LWdpcmwuanBnIiwiYnVja2V0IjoidGFvbGlqaWUtcGljIiwiZXhwaXJhdGlvbiI6MTU0MzIyOTc1OH0=",
    "saveKey": "/2015/8/27/sh-18"
  },
  "ok": true
}
```



# 更新二手帖子图片URL

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