# 注册

1. 调用`请求短信验证码`接口向用户手机发送短信，并得到服务器返回的15位标识符。
2. 调用`App注册`接口，传入Step 1中得到的标识符和短信验证码，完成注册。



## A1: App注册

用户通过App注册账号，账号为手机号码。 

``` 
POST /register
```

参数：

| 参数名        | 必填   | 说明                         | 
| ---------- | ---- | -------------------------- | 
| regType    | Y    | 该参数必须传递1                   | 
| code       | Y    | 用户收到的短信验证码                 | 
| identifier | Y    | 用户请求发送短信验证码时服务器返回的字符串      | 
| username   | Y    | 手机号，作为登陆名使用. 6 ~ 12个字符     | 
| password   | Y    | 登陆密码, 6 ~25个字符             | 
| rePassword | Y    | 重复密码                       | 
| nickname   | Y    | 昵称                         | 
| isEmployer | Y    | 传递true表示开通商家账户，false开通学生账户 | 

## A2: 请求短信验证码(App注册时)

该接口会向目标手机号发送一条短信验证码。

``` 
GET /register/sms
```

参数：

| 参数名    | 必填   | 说明   | 
| ------ | ---- | ---- | 
| mobile | Y    | 手机号  | 

服务器返回15位标识符：

``` json
{
  "message": "success",
  "code": 0,
  "data": "LgWwtTjhAHooqmW", // 15位标识符
  "ok": true
}
```

标识符号需作为`App注册`接口的`identifer`参数传递。

>  验证码有效时间为5分钟。



# 登陆

## 登陆接口

``` 
POST /login
```

参数：

| 参数名        | 必填   | 说明                   | 
| ---------- | ---- | -------------------- | 
| username   | Y    | 用户名                  | 
| password   | Y    | 密码                   | 
| rememberMe | N    | false/true, 默认为false | 
| m          | N    | 如果是从移动端口登陆，则需传递1     | 

当参数`m`不填写时，返回报文如下：

``` json
{
  "message": "success",
  "code": 0,
  "data": null,
  "ok": true
}
```

当`m = 1`时，返回报文如下：

``` json
{
  "message": "success",
  "code": 0,
  "data": {
    "id": 3, // 用户的id号
    "appToken": "SwONnQnfIEaKDYHwSzXY"
  },
  "ok": true
}
```

