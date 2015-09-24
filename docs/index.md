# 开发者联系方式

王鸿飞(后端): brucewhf^gmail.com

王富诚(前端): wangfucheng56^gmail.com



> 最后更新时间: 2015-9-24



# 权限认证

## Token

### 生成

由于所有接口都以`HTTP RESTful`的形式提供，因此在非Web环境下我们采用Token进行客户端身份识别。用户在app登陆后，服务器会返回一个**由字母组成、20位长的随机字符串**，后续请求带上该参数即可。



### 有效期

Token一旦生成不会自动过期。只有当用户主动注销登陆时，当前Token才会失效。**每个用户仅有一个token**，如果用户未注销前再次登陆，则上次的token自动失效，服务器最新返回的token有效。



### 使用方式

如果接口接受`GET`请求，则需将token添加到URL Query String中：

``` 
GET /api/job/list?appToken=WEFEIASIWEdfrilkzxcv
```

如果接口接受`POST`请求，则需将token添加到请求Body中：

``` 
paramA=XXXX&paramB=XXXX&appToken=WEFEIASIWEdfrilkzxcv
```

​

# 服务器返回报文格式

Demo:

``` 
{
  "message": "success",
  "code": 0, // 0表示操作成功
  "data": null,  // 没有返回数据
  "ok": true
}
```

参数说明：

|       参数名        |  必填  |                    说明                    |         示例          | 
| :--------------: | :--: | :--------------------------------------: | :-----------------: | 
|     message      |  Y   |               返回信息简短的文字说明                | not logged in(未登陆时) | 
|       code       |  Y   |                   错误代码                   |                     | 
|        ok        |  Y   |                 本次操作是否成功                 |    true / false     | 
|       data       |  Y   |        本次操作返回的业务数据，根据业务的不同格式也不同。         |                     | 
| data.resultCount |  N   | 如果返回的数据有多条(如一次查询多个用户信息), 则data.resultCount表示结果的总条数(用于计算页码) |                     | 
|    data.list     |  N   | 如果返回的数据有多条(如一次查询多个用户信息), 则data字段是一个名为lis的JSON数组 |                     | 

带返回数据的Demo:

``` 
{
  "message": "success",
  "code": 0,
  "data": { // data字段是一个名为list的json数组
    "list": [
      {
        "id": 1,
        "name": "cate1",
        "memo": null,
        "themeColor": null,
        "level": 1
      }
    ],
    "resultCount": 2  // 表示一共有2条数据，但本次只请求了第1条
  },
  "ok": true
}
```



# 错误代码表

|  代码  |    含义     | 
| :--: | :-------: | 
|  -1  |   操作失败    | 
|  0   |   操作成功    | 
|  1   |  操作过于频繁   | 
|  2   |  用户名不合法   | 
|  3   |   密码错误    | 
|  4   |   用户不存在   | 
|  5   |   用户已存在   | 
|  6   |   用户被封号   | 
|  7   |    未登陆    | 
|  8   |  两次输入不一致  | 
|  9   |   分类不为空   | 
|  10  |  必填字段为空   | 
|  11  |   非法参数    | 
|  12  |    不存在    | 
|  13  |   权限不足    | 
|  14  | 不能删除当前用户  | 
|  15  |   已经存在    | 
|  16  | 已经喜欢/收藏过了 | 
|  17  |   非法数字    | 
|  18  |  账户余额不足   | 
|  19  |  现金账户不存在  | 
|  20  |  任务重复领取   | 
|  21  |   任务已领完   | 
|  22  |   任务已结束   | 
|  23  |           | 