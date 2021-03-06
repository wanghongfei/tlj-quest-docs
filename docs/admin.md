> 以下所有接口需要以管理员身份登陆才能成功调用。

注意: 移动端不需要使用后台接口。

# 分类操作

## D1 创建轻兼职分类

``` 
POST /api/manage/quest/cate
```

参数：

| 参数名        | 必填   | 说明                     |
| ---------- | ---- | ---------------------- |
| name       | Y    | 要创建的分类的名字              |
| memo       | N    | 分类备注                   |
| themeColor | N    | 分类的颜色，以十六进制表示，如#FFFFFF |
| level      | N    | 分类的层级，暂时无用             |

返回报文data字段：

如果操作成功，则data字段为刚刚创建的**新分类的id**。

``` json
{
  "message": "success",
  "code": 0,
  "data": 5, // 新分类的id为5
  "ok": true
}
```



## D2 更新分类信息

``` 
PUT /api/manage/quest/cate/{cateId}
```

> cateId: 要更新的分类的id号

参数：

| 参数名        | 必填   | 说明                     |
| ---------- | ---- | ---------------------- |
| name       | N    | 要创建的分类的名字              |
| memo       | N    | 分类备注                   |
| themeColor | N    | 分类的颜色，以十六进制表示，如#FFFFFF |
| level      | N    | 分类的层级，暂时无用             |

> 注：以上参数中需至少填写一项



## D3 删除分类

``` html
DELETE /api/manage/quest/cate/{cateId}
```

> cateId: 要删除的分类的id号
> 
> 只有当该分类下没有帖子时才能成功删除，否则返回错误代码9.



# 审核操作

## D4 任务完成审核

学生提交任务完成申请后，管理员审核是否通过。

``` 
PUT /api/manage/quest/submit/{reqId}
```

> reqId: 任务完成申请的id

参数：

| 参数名    | 必填   | 说明   |
| ------ | ---- | ---- |
| status | Y    | 审核结果 |
| memo   | N    | 审核备注 |

其中，status参数取值如下：

| 取值   | 含意       |
| ---- | -------- |
|      |          |
| 01   | 等待审核     |
| 02   | 商家审核不通过  |
| 03   | TLJ审核不通过 |
| 04   | 自动通过     |
| 05   | 商家通过     |
| 06   | TLJ通过    |

> 如果审核不通过，应当传入memo参数说明审核失败的原因。



## D4.1 任务发布审核

``` 
PUT /api/manage/quest/{questId}
```

`questId`: 要审核的任务id

参数：

| 参数名    | 必填   | 说明   |
| ------ | ---- | ---- |
| status | Y    | 审核结果 |

`status`取值如下：

| 取值   | 含意   |
| ---- | ---- |
| 2    | 审核失败 |
| 3    | 审核通过 |

## D5 提现申请审核

用户提交提现申请后，管理员审核是否通过。

``` 
PUT /api/manage/acc/withdraw
```

参数：

| 参数名    | 必填   | 说明           |
| ------ | ---- | ------------ |
| drawId | Y    | 等待审核的提现申请的id |
| status | Y    | 审核结果         |
| memo   | N    | 审核结果说明       |

其中，`status`参数的取值如下：

| 取值   | 含意        |
| ---- | --------- |
| 00   | 等待审核      |
| 01   | 审核通过，等待派现 |
| 02   | 已派现       |
| 03   | 审核未通过     |

> 注：如果审核失败，应当传入`memo`参数以说明失败原因。



## D6 [X]充值申请审核

``` 
PUT /api/manage/acc/charge
```

参数：

| 参数名     | 必填   | 说明   |
| ------- | ---- | ---- |
| orderId | Y    | 订单id |
| status  | Y    | 审核结果 |
| memo    | N    | 审核说明 |

`status`取值如下：

| 取值   | 含意    |
| ---- | ----- |
| 00   | 等待审核  |
| 01   | 审核通过  |
| 02   | 审核未通过 |

>  如果审核未通过，则应填写`memo`参数说明原因。



## D7 商家身份审核

管理员审核商家提交的身份认证信息。

``` 
PUT /api/manage/certi/emp
```

参数：

| 参数名     | 必填   | 说明     |
| ------- | ---- | ------ |
| certiId | Y    | 申请单的id |
| status  | Y    | 审核结果   |
| memo    | N    | 结果说明   |

`status`取值如下：

| 取值   | 含意   |
| ---- | ---- |
| 01   | 等待审核 |
| 02   | 审核通过 |
| 03   | 审核失败 |

## D7.1 查询商家认证审核列表

``` 
GET /api/manage/certi/emp/list
```

参数和取值同接口`D7`



## D8 学生身份审核

管理员审核学生上传的身份认证信息。

``` 
PUT /api/manage/certi/stu
```

参数和取值同`D7:商家身份审核`。



## D8.1 个人身份认证审核

``` 
PUT /api/manage/certi/id
```

参数：

| 参数名     | 必填   | 说明     |
| ------- | ---- | ------ |
| certiId | Y    | 申请单id号 |
| status  | Y    | 审核结果   |
| memo    | N    | 结果说明   |

`status`参数取值同接口`D7`



## D8.1.1 查询个人认证申请列表

``` 
GET /api/manage/certi/id/list
```

参数同接口`D8.2`



## D8.2 查询学生认证申请列表

``` 
GET /api/manage/certi/stu/list
```

参数：

| 参数名    | 必填   | 说明                                       |
| ------ | ---- | ---------------------------------------- |
| status | Y    | 根据状态刷选. `01`:等待审核, `02`:审核通过, `03`:审核未通过 |
| pn     | N    |                                          |
| ps     | N    |                                          |

# 查询操作

## D9 查询提现申请列表

``` 
GET /api/manage/acc/withdraw/list
```

参数:

| 参数名    | 必填   | 说明                                       |
| ------ | ---- | ---------------------------------------- |
| status | N    | 是否根据状态过虑结果. `00`:等待审核, `02`:已完成, `03`: 失败 |
| pn     | N    |                                          |
| ps     | N    |                                          |

## D10 查询单条提现申请

``` 
GET /api/manage/acc/withdraw/{drawId}
```

> drawId: 提现申请的id



## D11 [X]查询充值申请列表

``` 
GET /api/manage/acc/charge/list
```

参数：

| 参数名    | 必填   | 说明         |
| ------ | ---- | ---------- |
| status | N    | 是否根据状态过虑结果 |
| pn     | N    |            |
| ps     | N    |            |

## D12 [X]查询单条充值申请

``` 
GET /api/manage/acc/charge/{orderId}
```

> orderId: 充值订单的id



## D13 查询指定用户的现金账户信息

``` 
GET /api/manage/acc/query/{memId}
```

> memId: 要查询的用户的id



## D14 查询代审核列表

管理员在后台可查询商家提交的代审核申请。

``` 
GET /api/manage/audit/list
```

参数：

| 参数名     | 必填   | 说明                      |
| ------- | ---- | ----------------------- |
| questId | N    | 任务id                    |
| minLeft | N    | 根据剩余数量筛选, 区间下限(include) |
| maxLeft | N    | 根据剩余数量筛选, 区间上限()        |
| pn      | N    |                         |
| ps      | N    |                         |

## D15 查询所有订单

``` 
GET /api/manage/order/list
```

参数：

| 参数名  | 必填   | 说明   |
| ---- | ---- | ---- |
| pn   | N    |      |
| ps   |      |      |

返回报文：

``` json
{
  "message": "success",
  "code": 0,
  "data": {
    "list": [
      {
        "id": 58,
        "cashAccId": 3,
        "memberId": 3,
        "title": "钱包充值",
        "createdTime": "2015-10-30 02:41:46",
        "updateTime": "2015-10-30 02:41:46",
        "amount": 1, // 充值数量
        "type": "00", // 见下面表格
        "status": "00", // 见下面表格
        "payChan": 0, // 充值渠道. 0: 支付宝, 1:微信支付
        "alipayTradeNum": null,
        "memo": null
      },
      {
        "id": 57,
        "cashAccId": 1,
        "memberId": 1,
        "title": "钱包充值",
        "createdTime": "2015-10-30 02:24:20",
        "updateTime": "2015-10-30 02:24:20",
        "amount": 1.1,
        "type": "03",
        "status": "03",
        "payChan": 0,
        "alipayTradeNum": null,
        "memo": null
      },
      {
        "id": 56,
        "cashAccId": 3,
        "memberId": 3,
        "title": "钱包充值",
        "createdTime": "2015-10-30 02:23:01",
        "updateTime": "2015-10-30 02:23:01",
        "amount": 1,
        "type": "00",
        "status": "01",
        "payChan": 0,
        "alipayTradeNum": null,
        "memo": null
      }
    ],
    "resultCount": 3
  },
  "ok": true
}
```

`type`字段：

| 取值   | 含意      |
| ---- | ------- |
| 00   | 钱包充值订单  |
| 01   | 任务推荐订单  |
| 02   | 任务加标签订单 |
| 03   | 发布任务订单  |

`status`字段：

| 取值   | 含意   |
| ---- | ---- |
| 00   | 等待支付 |
| 01   | 交易成功 |
| 02   | 支付失败 |
| 03   | 支付成功 |

## D15.1 根据id查询订单

``` 
GET /api/manage/order/{id}
```

返回报文类似`D15`😬



# 账号操作

## D16 重置用户密码

``` 
PUT /api/manage/user/{userId}/pwd
```

参数：

| 参数名    | 必填   | 说明       |
| ------ | ---- | -------- |
| newPwd | N    | 新1 ~ 30位 |

## D17 封号

``` 
PUT /api/manage/user/block/{userId}
```



## D18 解封

``` 
DELETE /api/manage/user/block/{userId}
```



## D19 查询所有用户

``` 
GET /api/manage/user/list
```

参数：

| 参数名  | 必填   | 说明   |
| ---- | ---- | ---- |
| pn   | N    |      |
| ps   | N    |      |

## D20 根据用户名精确查询用户

``` 
POST /api/manage/user/name
```

参数：

| 参数名      | 必填   | 说明      |
| -------- | ---- | ------- |
| username | Y    | 要查询的用户名 |

## D21 根据用户名模糊查询用户

``` 
POST /api/manage/user/search
```

参数：

| 参数名      | 必填   | 说明                        |
| -------- | ---- | ------------------------- |
| username | Y    | 查询所有用户名中包含`username`的用户信息 |
| pn       |      |                           |
| ps       |      |                           |



## D22 过虑查询用户

``` 
POST /api/manage/user/filter
```

参数：

| 参数名   | 必填   | 说明                       |
| ----- | ---- | ------------------------ |
| un    | N    | 用户名                      |
| valid | N    | 是否封号. `0`: 封号, `1`: 没封号  |
| role  | N    | 角色名, 如`ADMIN`, `STUDENT` |
| pn    | N    |                          |
| ps    | N    |                          |