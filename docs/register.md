# 注册

1. 调用`请求短信验证码`接口向用户手机发送短信
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
|            |      |                            |
| username   | Y    | 手机号，作为登陆名使用. 6 ~ 12个字符     |
| password   | Y    | 登陆密码, 6 ~25个字符             |
| rePassword | Y    | 重复密码                       |
| nickname   | Y    | 昵称                         |
| isEmployer | Y    | 传递true表示开通商家账户，false开通学生账户 |

## A1.1 完善企业信息

商家用户在完成注册后调用该接口完善企业资料。

需要登陆。

``` 
PUT /api/user/emp
```

参数：

| 参数名      | 必填   | 说明          |
| -------- | ---- | ----------- |
| compName | Y    | 公司名(60字以内)  |
| compAddr | Y    | 公司地址(60字以内) |
| compDesp | Y    | 公司简介(50字以内) |

## A2: 请求短信验证码(App使用)

该接口会向目标手机号发送一条短信验证码。

``` 
GET /register/sms
```

参数：

| 参数名    | 必填   | 说明                     |
| ------ | ---- | ---------------------- |
| mobile | Y    | 手机号                    |
| reg    | N    | 仅在通过手机重置密码时使用, 需要传递`1` |

返回报文：

``` json
{
  "message": "success",
  "code": 0,
  "data": null,
  "ok": true
}
```

>  验证码有效时间为5分钟。



# 登陆

## A3 登陆接口

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



## A4 通过手机找回密码

用户输入账号绑定的手机号码，通过验证码的方式重设密码。

``` 
POST /findPwd
```

参数：

| 参数名    | 必填   | 说明    |
| ------ | ---- | ----- |
| mobile | Y    | 手机号   |
| newPwd | Y    | 新密码   |
| code   | Y    | 手机验证码 |

## A5 绑定微信openid

为当前用户绑定openId，需要登陆。

``` 
POST /api/user/acc/bind/wechat
```

参数：

| 参数名    | 必填   | 说明     |
| ------ | ---- | ------ |
| openId | Y    | openid |

## A6 查询用户资料

``` 
GET /api/user/{id}
```

> `id`: 用户id

返回数据：

``` json
{
  "message": "success",
  "code": 0,
  "data": {
    "id": 2,
    "username": "wanghongfei",
    "regType": 0,
    "name": "wang",
    "idCerti": "02",
    "stuCerti": "02",
    "empCerti": "00",
    "companyName": "name", // 公司名
    "companyAddr": "addr", // 公司地址
    "companyDesp": "desp", // 公司简介
    "createdTime": "2015-10-14 16:00:00",
    "valid": true,
    "complaint": 0,
    "wechatToken": "1234",
    "credits": 0,
    "roleList": [
      {
        "rid": 2,
        "rolename": "STUDENT",
        "memo": "学生"
      }
    ]
  },
  "ok": true
}
```



## A7 修改登陆密码

``` 
PUT /api/user/pwd
```

参数：

| 参数名    | 必填   | 说明         |
| ------ | ---- | ---------- |
| oldPwd | Y    | 老密码        |
| newPwd | Y    | 新密码(不超过30) |

## A8 头像上传

需要登陆。

``` 
POST /user/changePhoto
```

参数：

| 参数名  | 必填   | 说明   |
| ---- | ---- | ---- |
| file | Y    | 图片文件 |

返回报文只有一个整数，表示刚才上传的图片id:

``` 
12
```

读取图片时，调用：

``` 
GET /static/images/users/{12}
```