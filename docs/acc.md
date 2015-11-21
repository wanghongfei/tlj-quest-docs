# 验证码

## C1 发送验证码到指定手机

需要登陆。

``` 
GET /api/user/code/sms
```

参数：

| 参数名    | 必填   | 说明                              |
| ------ | ---- | ------------------------------- |
| mobile | Y    | 手机号                             |
| code   | Y    | 用户在页面上填写的验证码, 只有该验证码正确时才会真正发送短信 |

> 手机短信中的验证码有效时间为5分钟。



## C2 发送验证码到当前登陆用户手机

需要登陆。

``` 
POST /api/user/code/sms
```



## C3 生成一个6位图片验证码

该接口用于生成一个随机验图片证码，防机器人

需要登陆。

``` 
GET /gen.do
```

参数：

| 参数名  | 必填   | 说明        |
| ---- | ---- | --------- |
| mId  | Y    | 当前登陆用户的id |

# 更新操作

## C4 开通现金账户(钱包)

该接口需要登陆，且只允许APP调用。

用户在第一次进入钱包时调用该接口。

``` 
POST /api/user/acc
```

参数:

| 参数名       | 必填   | 说明          |
| --------- | ---- | ----------- |
| dealPwd   | Y    | 交易密码        |
| seContent | Y    | 密保问题(45字以内) |
| seAnswer  | Y    | 密保答案(45字以内) |
| email     | N    | 用户邮箱        |
| name      | N    | 用户姓名        |

## C4.1 修改交易密码

需要登陆，且已经开通了钱包、设置过密保。

``` 
PUT /api/user/acc/dealPwd
```

参数：

| 参数名     | 必填   | 说明    |
| ------- | ---- | ----- |
| answer  | Y    | 密保答案  |
| dealPwd | Y    | 新交易密码 |

## C5 修改支付宝账号

``` 
PUT /api/user/acc/alipay
```

参数：

| 参数名    | 必填   | 说明     |
| ------ | ---- | ------ |
| alipay | Y    | 新支付宝账户 |
| code   | Y    | 手机验证码  |

## C6 修改银行卡账号

``` 
PUT/ api/user/acc/bank
```

参数：

| 参数名     | 必填   | 说明    |
| ------- | ---- | ----- |
| bankAcc | Y    | 新银行卡号 |
| code    | Y    | 手机验证码 |

## C7 发起提现申请

商家、学生都可以申请提现。

``` 
POST /api/user/acc/withdraw
```

参数：

| 参数名     | 必填   | 说明                                    |
| ------- | ---- | ------------------------------------- |
| amt     | Y    | 提现金额                                  |
| dealPwd | N    | 交易密码                                  |
| payType | Y    | `0`: 支付到支付宝, `1`:支付到微信钱包, `2`:支付到银行卡号 |

当提现到支付宝或银行卡号时，用户必须先绑定支付宝或银行卡，否则接口会返回错误信息。

当提现到微信钱包时，用户必须先绑定微信账户，否则接口会返回错误信息。



## C8 支付宝下单

需要登陆状态。

``` 
POST /api/pay/order
```

参数:

| 参数名       | 必填   | 说明                        |
| --------- | ---- | ------------------------- |
| subject   | Y    | 同alipay的`subject`         |
| totalFee  | Y    | 订单总金额，同alipay的`total_fee` |
| body      | Y    | 同alipay的`body`            |
| orderType | Y    | 订单类型                      |
| payChan   | Y    | 支付渠道; `0`:支付宝 `1`: 微信     |

`orderType`取值：

| 取值   | 含意       |
| ---- | -------- |
| 00   | 钱包充值订单   |
| 01   | 任务置顶推荐订单 |
| 02   | 任务加标签订单  |
| 03   | 任务发布订单   |

返回报文：

``` json
{
  "message": "success",
  "code": 0,
  "data": {
    "orderId": 57, // 订单号
    "sign": // 签名 "uy9MEVOu3EUrsElX4DXtEgh8qg6CUTbDowcnFX1Ys/N2SxALw018hRyC7iAg10+kdpIR2IRJVeoaXg4Y/l7/2ARsEx3XwrgQ2b6PeDuh91zJLTzyBtuQF8LBtP1GWypHXeve9RtqA8Q4KE9Tyydxw9QnkALKZKF+DekmhJh9Ou4=",
    "servName": "mobile.securitypay.pay", // 对应alipay的service参数
    "partner": "2088021861615600", // 对应alipay的partner参数
    "charset": "utf-8", // 对应alipay的_input_charset参数
    "signType": "RSA" // 对应alipay的sign_type参数
  },
  "ok": true
}
```



## C8.1 钱包充值

需要登陆。

调用该接口必须先调用`C8下单`。

``` 
POST /api/user/acc/charge
```

参数：

| 参数名     | 必填   | 说明    |
| ------- | ---- | ----- |
| orderId | Y    | 充值订单号 |

## C9 (无效)解绑手机号

``` 
DELETE /api/user/acc/phone
```

参数：

| 参数名  | 必填   | 说明            |
| ---- | ---- | ------------- |
| code | Y    | 发送到用户老手机上的验证码 |

## C10 更换手机号

``` 
PUT /api/user/acc/phone
```

参数：

| 参数名    | 必填   | 说明                |
| ------ | ---- | ----------------- |
| code   | Y    | 发送到用户新手机上的验证码     |
| phone  | Y    | 新手机号              |
| answer | N    | 密保答案. 不填写表示不用密保验证 |

> 注意：只有当用户先解绑手机后才能成功调用该接口。



## C11 商家身份认证申请

只有商家用户在登陆状态时才可以调用该接口。

``` 
POST /api/user/certi/emp
```

参数：

| 参数名       | 必填   | 说明          |
| --------- | ---- | ----------- |
| compName  | Y    | 公司全名(45字以内) |
| addr      | Y    | 公司地址(45字以内) |
| picIds    | Y    | 照片上传        |
| cateId    | Y    | 行业分类的id号    |
| compPhone | N    | 联系电话        |
| contName  | Y    | 企业联系人姓名     |

`picIds`参数为以`;`分隔的图片在又拍云的路径, 如:

``` 
/a.jpg;/b.jpg
```



## C11.1 个人身份认证申请

需要登陆。

``` 
POST /api/user/certi/id
```

参数：

| 参数名    | 必填   | 说明              |
| ------ | ---- | --------------- |
| name   | Y    | 真实姓名            |
| id     | Y    | 身份证号            |
| picIds | Y    | 上传的证件图片, 以`;`分隔 |

## C12 学生身份认证申请

只有学生用户在登陆状态时才可以调用该接口。

``` 
POST /api/user/certi/stu
```

参数：

| 参数名       | 必填   | 说明            |
| --------- | ---- | ------------- |
| name      | Y    | 真实姓名(不超过10字符) |
| cityId    | Y    | 所在城市的id       |
| collegeId | Y    | 所在大学的id       |
| picIds    | Y    | 上传的认证图片       |
| cname     | N    | 班级            |

`picIds`参数为以`;`分隔的图片在又拍云的路径, 如:

``` 
/2015/10.12/sef72390sfxcvbx89asdfzb89;/2015/10.12/sef72sadsfxcvbx89asdfzb89
```



# 查询操作

## C13 查询当前用户的现金账户

需要登陆。

``` 
GET /api/user/acc
```

该接口不需要参数。

返回报文：

``` json
{
  "message": "success",
  "code": 0,
  "data": {
    "id": 2,
    "availableBalance": 1, // 可用余额
    "frozenBalance": 0, // 无用字段
    "totalBalance": 1, // 无用字段
    "status": "00", // 账户状态
    "updateTime": "2015-09-24 12:50:54", // 最后更新时间
    "createdTime": "2015-09-24 12:50:54", // 开户时间
    "memberId": 2, // 账户所有者id
    "username": "taolijie", // 所有者用户名
    "memberRole": "STUDENT", // 所有者用户类型
    "phoneNumber": "1828312368" // 所有者手机号
  },
  "ok": true
}
```



## C13.1 查询当前账户余额

调用该接口查询余额以节省流量。

``` 
GET /api/user/acc/balance
```

返回报文：

``` json
{
  "message": "success",
  "code": 0,
  "data": 7.4, // 可用余额
  "ok": true
}
```





## C14 查询账户资金变化记录

需要登陆。

``` 
GET /api/user/acc/flow
```

参数：

| 参数名   | 必填   | 说明                |
| ----- | ---- | ----------------- |
| start | N    | 开始日期。 如，2015-9-14 |
| end   | N    | 结束日期。如，2015-9-20  |
| pn    | N    |                   |
| ps    | N    |                   |

对于请求

``` 
/api/user/acc/flow?appToken=token&ps=2
```

返回报文为：

``` json
{
  "message": "success",
  "code": 0,
  "data": {
    "list": [
      {
        "id": 14,
        "createdTime": "2015-10-01 14:07:06",
        "accId": 1, // 现金账户id
        "actionType": "00", // 资金变动的原因
        "avaBalanceCh": -5, // 可用余额变化值
        "froBalanceCh": 0, // 无用字段
        "totBalanceCh": 0, // 无用字段
        "avaBalanceNew": 186.9, // 可用余额变化后的新值 
        "froBalanceNew": 0, // 无用
        "totBalanceNew": 0, // 无用
        "memo": null
      },
      {
        "id": 12,
        "createdTime": "2015-09-29 09:53:00",
        "accId": 1,
        "actionType": "00",
        "avaBalanceCh": -0.1,
        "froBalanceCh": 0,
        "totBalanceCh": 0,
        "avaBalanceNew": 191.9,
        "froBalanceNew": 0,
        "totBalanceNew": 0,
        "memo": null
      }
    ],
    "resultCount": 8
  },
  "ok": true
}
```



## C15 查询密保问题

需要登陆，且已经设置过密保。

``` 
GET /api/user/acc/question
```

不需要参数。

返回报文：

``` json
{
  "message": "success",
  "code": 0,
  "data": {
    "id": 1,
    "createdTime": "2015-10-25 03:25:24",
    "memberId": 3,
    "accId": 3,
    "content": "content" // 密保问题
  },
  "ok": true
}
```