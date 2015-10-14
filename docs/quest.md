# 分类

任务分类是任务的类型，每一个任务都有且仅属于一个分类。

## B1 查询分类列表

``` html
GET /api/quest/cate/list
```

参数:

| 参数名  | 是否必填 |             说明              | demo |
| :--: | :--: | :-------------------------: | :--: |
|  pn  |  N   | pageNumber, 查询第pn页的记录, 默认为0 |      |
|  ps  |  N   |  pageSize, 每页显示ps条记录, 默认为8  |      |

返回报文data字段格式：

data字段是一个名为”list”的JSON数组，数组中的每一个元素即代表一个分类对象。

下面是一个返回报文data字段示例：

``` json
"data": {
    "list": [
      {
        "id": 1,
        "name": "cate1",
        "memo": null,
        "themeColor": null,
        "level": 1
      },
      {
        "id": 2,
        "name": "cate2",
        "memo": null,
        "themeColor": null,
        "level": null
      }
    ],
    "resultCount": 2
  }
```



|  参数名  |     说明     | demo  |
| :---: | :--------: | :---: |
|  id   | 分类的唯一标识，整数 |   1   |
| name  |    分类名     | 朋友圈推广 |
| memo  |     备注     |       |
| level | 分类层级，暂时无用  |       |

## B2 通过id查询分类

``` 
GET /api/quest/cate/{id}
```

参数：

| 参数名  |  必填  |   说明   |
| :--: | :--: | :----: |
|  id  |  Y   | 分类的id号 |

返回报文data字段：

data字段中直接是分类JSON对象, 若不存在则为`data: null`

``` json
"data": {
        "id": 1,
        "name": "cate1",
        "memo": null,
        "themeColor": null,
        "level": 1
  }
```



## B3 通过分类名查询分类信息

``` 
GET /api/quest/cate/name/{name}
```

参数：

| 参数名  |  必填  |  说明  |
| :--: | :--: | :--: |
| name |  Y   | 分类名  |

返回报文data字段：

data字段中直接是分类JSON对象, 若不存在则为`data: null`

``` json
"data": {
        "id": 1,
        "name": "cate1",
        "memo": null,
        "themeColor": null,
        "level": 1
  }
```



# 任务

任务的发布、修改、审核和领取相关接口

## B4 商家发布任务

``` 
POST /api/user/quest
```

> 只有以商家用户登陆才能成功调用。

参数：

| 参数名          | 必填   | 说明                              |
| ------------ | ---- | ------------------------------- |
| title        | Y    | 任务标题                            |
| questCateId  | Y    | 任务分类的id                         |
| startTime    | Y    | 任务开始时间                          |
| endTime      | Y    | 任务结束时间                          |
| totalAmt     | Y    | 任务总数量                           |
| award        | Y    | 单个任务的赏金                         |
| contactName  | Y    | 联系人姓名                           |
| contactPhone | Y    | 联系人手机号                          |
| description  | Y    | 任务简述(100字以内)                    |
| questDetail  | Y    | 任务详细描述(1000字以内)                 |
| url          | N    | 任务链接                            |
| memo         | N    | 任务备注                            |
| provinceId   | Y    | 任务对象：省                          |
| cityId       | Y    | 任务对象：市                          |
| regionId     | Y    | 任务对象：区                          |
| collegeIds   | Y    | 任务对象：大学. 以`;`分隔的id字符串，如`1;2;3`  |
| schoolIds    | Y    | 任务对象：学院. 以`;`分隔的id字符串，如`2;5;19` |

接口调用后，服务器会自动计算总任务赏金，并从发布者的现金账户中扣除可用余额。

> 扣除的金额 = [ (1 + 费率) * 单个任务赏金 ] * 任务数量



## B5 任务领取

只有登陆状态下的学生用户才可以领取任务。

``` 
POST /api/user/quest/assign/{questId}
```

> questId: 要领取的任务的id



## B6 提交任务完成申请

学生用户完成任务以后，在线提交申请，等待管理员审核。

> 只有已登陆的学生用户才能发起该请求。

``` 
POST /api/user/quest/submit/{questId}
```

> questId: 已完成的任务的id

参数：

| 参数名         | 必填   | 说明                      |
| ----------- | ---- | ----------------------- |
| description | Y    | 说明文字                    |
| imageIds    | Y    | 图片说明。以;分隔的图片id。 如：1;2;3 |
| name        | N    | 申请人姓名                   |
| memo        | N    | 备注                      |

# 任务查询

## B7 查询任务发布记录

需要商家用户登陆。

``` 
GET /api/user/quest/publish/list
```

参数：

| 参数名  | 必填   | 说明                   |
| ---- | ---- | -------------------- |
| pn   | N    | 显示第几页. default = 0   |
| ps   | N    | 一页多少条记录. default = 8 |

返回示例：

``` json
{
  "message": "success",
  "code": 0,
  "data": {
    "list": [
      {
        "id": 1,
        "title": "quest1",
        "createdTime": "2015-09-24 09:17:30", // 创建时间
        "questCateId": 1,	// 任务分类id
        "startTime": "2015-10-09 16:00:00", // 任务开始时间
        "endTime": "2015-12-31 16:00:00", // 任务结束时间	
        "limitTime": 2, // 任务领取后完成限制时间
        "totalAmt": 10, // 任务总数量
        "leftAmt": 9, // 任务剩余数量
        "award": 1, // 单个任务赏金
        "memberId": 1, // 任务发布者id
        "finalAward": 1, // 计算费率后的单个任务赏金
        "contactName": "whf", // 联系人姓名
        "contactPhone": "11111111111",
        "description": "task", // 任务简述
        "questDetail": "task", // 任务详细
        "url": null, // 任务链接地址
        "memo": null,
        "offline": false, // 是否已经下线
        "provinceId": 1, // 任务对象：省id
        "cityId": 1, // 任务对象：城市id
        "regionId": 1, // 任务对象：区域id
        "collegeId": null,
        "schoolId": null
      }
    ],
    "resultCount": 1
  },
  "ok": true
}
```



## B8 查询任务领取记录

需要学生用户登陆。

``` 
GET /api/user/quest/assign/list
```

参数：

| 参数名    | 必填   | 说明                 |
| ------ | ---- | ------------------ |
| status | N    | 根据任务状态过虑，不填写表示查询所有 |
| pn     | N    |                    |
| ps     | N    |                    |

返回示例：

``` json
{
  "message": "success",
  "code": 0,
  "data": {
    "list": [
      {
        "id": 1,
        "memberId": 1, // 领取者id
        "username": "hanxinxin", // 领取者用户名
        "questId": 1, // 领取的任务id
        "questTitle": "quest1", // 领取的任务标题
        "assignTime": "2015-10-09 16:00:00", // 领取日期
        "status": "00" // 领取状态
      }
    ],
    "resultCount": 1
  },
  "ok": true
}
```



## B9 查询任务提交记录

需要学生用户登陆状态。

``` 
GET /api/user/quest/submit/list
```

参数：

| 参数名  | 必填   | 说明   |
| ---- | ---- | ---- |
| pn   | N    |      |
| ps   | N    |      |

返回报文：

``` json
{
  "message": "success",
  "code": 0,
  "data": {
    "list": [
      {
        "id": 7,
        "questId": 1,
        "memberId": 2, // 提交者id
        "username": "taolijie", // 提交者用户名
        "createdTime": "2015-10-01 07:21:50", // 提交时间
        "auditTime": "2015-10-01 07:22:00", // 审核时间
        "description": "I'm done", // 提交理由
        "imageIds": "1;2;3;4;5",
        "status": "03",
        "memo": "",
        "name": null // 提交者姓名
      }
    ],
    "resultCount": 1
  },
  "ok": true
}
```





## B10 查询指定任务的提交记录

只有商家和ADMIN可以调用。

``` 
GET /api/user/quest/submit/{questId}/list
```

| 参数名     | 必填   | 说明         |
| ------- | ---- | ---------- |
| questId | Y    | 任务id       |
| status  | N    | 根据任务状态筛选结果 |
| pn      | N    |            |
| ps      | N    |            |

`status`取值如下：

| 取值   | 含意    |
| ---- | ----- |
| 00   | 已通过审核 |
| 01   | 待审核   |
| 02   | 审核失败  |

返回报文:

``` JSON
{
  "message": "success",
  "code": 0,
  "data": {
    "list": [
      {
        "id": 7,
        "questId": 1,
        "memberId": 2, // 任务提交用户的id
        "username": "taolijie", // 任务提交用户的用户名
        "createdTime": "2015-10-01 07:21:50", // 提交时间
        "auditTime": "2015-10-01 07:22:00", // 审核时间
        "description": "I'm done",
        "imageIds": "1;2;3;4;5",
        "status": "03",
        "memo": "",
        "name": null
      }
    ],
    "resultCount": 1
  },
  "ok": true
}
```





## B11 条件查询

任何人都可以调用该接口.

``` 
GET /api/quest/list
```

参数：

| 参数名      | 必填   | 说明               |
| -------- | ---- | ---------------- |
| cateId   | N    | 填写表示根据分类过虑结果     |
| min      | N    | 任务的最低赏金(include) |
| max      | N    | 任务的最高赏金(include) |
| pn       | N    |                  |
| ps       | N    |                  |
| regionId | N    | 区域id             |
| schoolId | N    | 学校id             |

> 只填写`min`不填`max`表示查询赏金`>= min`的任务。
> 
> 只填写`max`不填`min`表示查询赏金`<= max`的任务。
> 
> 同时填写表示查询赏金在`min`与`max`之间的任务。

返回报文：

``` json
{
  "message": "success",
  "code": 0,
  "data": {
    "list": [
      {
        "id": 5,
        "title": "newQuest", // 任务标题
        "createdTime": "2015-09-29 09:53:00", // 任务创建时间
        "questCateId": 1, // 任务分类id
        "startTime": "2015-10-09 16:00:00", // 任务开始时间
        "endTime": "2015-10-15 16:00:00", // 任务结束时间
        "limitTime": 2, // 任务完成限制时间
        "totalAmt": 1, // 任务总数
        "leftAmt": 1, // 任务剩余数量
        "award": 0.1, // 单个任务赏金
        "memberId": 1, // 发布者id
        "finalAward": 0.1, // 计算费率后的单个任务赏金
        "contactName": "whf",
        "contactPhone": "1111111",
        "description": "des",
        "questDetail": "detail",
        "url": null,
        "memo": null,
        "offline": false,
        "provinceId": 1,
        "cityId": 1,
        "regionId": 1,
        "collegeId": null,
        "schoolId": null,
        "status": null
      }

    ],
    "resultCount": 1
  },
  "ok": true
}
```





## B12 根据id查询任务

不需要登陆。

``` 
GET /api/quest/{questId}
```

> questId: 任务id

返回报文的`data`字段中有一个`status`参数，该参数的取值和含意如下：

| 取值   | 意义   |
| ---- | ---- |
| 0    | 未领取  |
| 1    | 已领取  |
| 2    | 已结束  |
| 3    | 已完成  |

# Taolijie代审核

## B13 计算桃李街代审核费用

商家可以申请桃李街代审核任务完成申请。

``` 
GET /api/user/quest/audit/fee
```

参数：

| 参数名  | 必填   | 说明       |
| ---- | ---- | -------- |
| amt  | Y    | 代审核的任务数量 |

如，对于请求

``` 
GET /api/user/quest/audit/fee?amt=56&appToken=XXXXX
```

返回结果为：

``` json
{
  "message": "success",
  "code": 0,
  "data": 56, // 需要56元
  "ok": true
}
```



## B14 申请Taolijie代审核任务

商家可以申请桃李街代审核任务完成申请。

``` 
POST /api/user/quest/audit
```

参数：

| 参数名     | 必填   | 说明       |
| ------- | ---- | -------- |
| questId | Y    | 要申请的任务id |
| amt     | Y    | 代审核的数量   |

> 注: 同一个任务只能申请一次，重复申请会失败。



## B15 查询代审核明细

商家可以查询自己申请过的代审核状态。

只有商家才能调用该接口。

``` 
GET /api/user/quest/audit/list
```

参数：

| 参数名     | 必填   | 说明        |
| ------- | ---- | --------- |
| questId | N    | 代审核的任务的id |
| pn      | N    |           |
| ps      | N    |           |

返回报文：

``` JSON
{
  "message": "success",
  "code": 0,
  "data": {
    "list": [
      {
        "id": 2,
        "questId": 1, // 代审核的任务is
        "questTitle": "quest1", // 代审核的任务的标题
        "totAmt": 5, // 代审核总数量
        "leftAmt": 5, // 代审核剩余数量
        "empId": 1, // 申请者用户id
        "empUsername": "hanxinxin", // 申请者用户名
        "createdTime": "2015-10-15 16:00:00" // 申请时间
      }
    ],
    "resultCount": 1
  },
  "ok": true
}
```





# 收藏

## B16 收藏任务

``` 
POST /api/user/co
```

参数：

| 参数名     | 必填   | 说明   |
| ------- | ---- | ---- |
| questId | Y    | 任务   |

## B17 取消收藏任务

``` 
DELETE /api/user/co/quest/{questId}
```

> questId: 任务id



## B18 查询收藏列表

``` 
GET /api/user/co/list
```

参数：

| 参数名  | 必填   | 说明   |
| ---- | ---- | ---- |
| pn   | N    |      |
| ps   | N    |      |

返回报文：

``` json
{
  "message": "success",
  "code": 0,
  "data": {
    "list": [
      {
        "id": 1,
        "createdTime": "2015-05-09 16:00:00", // 收藏时间
        "memberId": 1, // 收藏者用户id
        "questId": 1, // 收藏的任务id
        "questTitle": "quset1" // 收藏的任务标题
      }
    ],
    "resultCount": 1
  },
  "ok": true
}
```





## B19 查询任务是否已经收藏

``` 
GET /api/user/co/check
```

参数：

| 参数名     | 必填   | 说明   |
| ------- | ---- | ---- |
| questId | Y    | 任务id |

返回报文：

``` json
{
  "message": "success",
  "code": 0,
  "data": true, // 表示已经收藏
  "ok": true
}
```