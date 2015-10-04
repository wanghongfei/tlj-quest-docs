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

参数：

| 参数名  | 必填   | 说明    | 
| ---- | ---- | ----- | 
| code | Y    | 图片验证码 | 

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

该接口需要登陆。

用户在第一次进入钱包时调用该接口。

``` 
POST /api/user/acc
```

参数:

| 参数名     | 必填   | 说明         | 
| ------- | ---- | ---------- | 
| dealPwd | Y    | 交易密码       | 
| phone   | N    | 用户手机号      | 
| code    | Y    | 用户收到的短信验证码 | 
| email   | N    | 用户邮箱       | 
| name    | N    | 用户姓名       | 

`code`参数是用户手机收到的短信验证码，可以调用`发送短信验证码`接口来发送短信。

> 如果用户是通过手机号码注册的，则不需要填写`phone`参数。如果为非手机号注册，则`phone`参数必填。

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

| 参数名       | 必填   | 说明    | 
| --------- | ---- | ----- | 
| amt       | Y    | 提现金额  | 
| alipayAcc | N    | 支付宝账户 | 
| bankAcc   | N    | 银行卡号  | 
| dealPwd   | Y    | 交易密码  | 

`alipayAcc`和`bankAcc`至少填写一项。



## C8 发起充值申请

商家、学生都可以发起充值申请，待管理员审核完成后账户金额自动增加。

``` 
POST /api/user/acc/charge
```

参数:

| 参数名      | 必填   | 说明     | 
| -------- | ---- | ------ | 
| amt      | Y    | 充值金额   | 
| tradeNum | Y    | 支付宝交易号 | 

## C9 解绑手机号

``` 
DELETE /api/user/acc/phone
```

参数：

| 参数名  | 必填   | 说明            | 
| ---- | ---- | ------------- | 
| code | Y    | 发送到用户老手机上的验证码 | 

## C10 绑定新手机号

``` 
PUT /api/user/acc/phone
```

参数：

| 参数名   | 必填   | 说明            | 
| ----- | ---- | ------------- | 
| code  | Y    | 发送到用户新手机上的验证码 | 
| phone | Y    | 新手机号          | 

> 注意：只有当用户先解绑手机后才能成功调用该接口。



## C11 商家身份认证申请

只有商家用户在登陆状态时才可以调用该接口。

``` 
POST /api/user/certi/emp
```

参数：

| 参数名      | 必填   | 说明   | 
| -------- | ---- | ---- | 
| compName | Y    | 公司全名 | 
| addr     | Y    | 公司地址 | 
| picIds   | Y    | 照片上传 | 

`picIds`参数为以`;`分隔的图片在又拍云的路径, 如:

``` 
/a.jpg;/b.jpg
```





## C12 学生身份认证申请

只有学生用户在登陆状态时才可以调用该接口。

``` 
POST /api/user/certi/emp
```

参数：

| 参数名       | 必填   | 说明      | 
| --------- | ---- | ------- | 
| name      | Y    | 真实姓名    | 
| collegeId | Y    | 所在大学的id | 
| schoolId  | Y    | 学在学院的id | 
| picIds    | Y    | 上传的认证图片 | 

`picIds`参数为以`;`分隔的图片在又拍云的路径, 如:

``` 
/a.jpg;/b.jpg
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

