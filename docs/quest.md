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

| 参数名          | 必填   | 说明                                       |
| ------------ | ---- | ---------------------------------------- |
| title        | Y    | 任务标题                                     |
| questCateId  | Y    | 任务分类的id                                  |
| startTime    | Y    | 任务开始时间                                   |
| endTime      | Y    | 任务结束时间                                   |
| totalAmt     | Y    | 任务总数量                                    |
| award        | Y    | 单个任务的赏金                                  |
| contactName  | Y    | 联系人姓名                                    |
| contactPhone | Y    | 联系人手机号                                   |
| description  | Y    | 任务简述(100字以内)                             |
| questDetail  | Y    | 任务详细描述(1000字以内)                          |
| url          | N    | 任务链接                                     |
| memo         | N    | 任务备注                                     |
| orderId      | N    | 订单号。**如果填写此参数则不从钱包中扣钱, 而是验证对应的订单是否正确**   |
| collegeIds   | (Y)  | 任务对象，仅当`all`参数为`0`时需要填写：大学. 以`;`分隔的id字符串，如`1;2;3` |
| cityIds      | (Y)  | 任务对象,仅当`all`参数为`0`时需要填写：城市. 同上           |
| proIds       | (Y)  | 任务对象,仅当`all`参数为`0`时需要填写：省. 同上            |
| couponTitle  | (N)  | 卡券名                                      |
| couponDesp   | (N)  | 卡券使用规则                                   |
| expiredTime  | (N)  | 卡券过期时间, yyyy-mm-dd                       |
| storeName    | N    | 店铺名(20字内)                                |
| storeAddr    | N    | 店铺地址(45字内)                               |
| logo         | N    | 卡券店铺logo在又拍的路径                           |
| couponAmt    | (N)  | 卡券数量                                     |
| save         | N    | `0`: 直接发布. `1`: 保存但不发布(一样扣钱). 默认为`0`     |
| all          | N    | 任务对象是否为所有人. `0`: 默认值,学生. `1`: 所有人       |

接口调用后，服务器会自动计算总任务赏金，并从发布者的现金账户中扣除可用余额。

> 扣除的金额 = [ (1 + 费率) * 单个任务赏金 ] * 任务数量

从`couponTitle`到`couponAmt`为卡券信息，**如果需要发布卡券则这些参数全部必填(logo可以不填)**，如果不需要卡券则不需要填写。

**带有`(N)`的参数要么全不填，要么全填。**

## B4.1 商家发布答题、问卷任务

``` 
POST /api/user/quest/question
```

参数：

该接口只接受`JSON`字符串参数，在`javascript`中需要将`JSON`对象转换为`JSON`字符串，然后添加`Content-Type: application/json; charset=utf-8`请求头。

格式如下(做为请求参数时去掉注释)：

``` json
{
  	// questions是json数组
  	// 数组中每个对象代表一个问题
    "questions": [
        { // question-1 starts
          	"opts": [{ 						// opts: 该问题对应的选择项
                "optName": "a", 			// 选项名
                "optContent": "optContent", // 选项内容
                "orderIndex": 0, 			// 选项排序值，越小越靠前
                "correct": true 			// 该选项是否是正确答案. 如果是问卷类问题，忽略该属性
            },
            {
                "optName": "b",
                "optContent": "optContent",
                "orderIndex": 1,
                "correct": true
            }],
            "content": "content", 	// 问题的内容
            "orderIndex": 0, 		// 问题的排序值，越小越靠前
          	"type": 0 				// 问题的类型。 0: 答题 1:问卷
        },// question-1 ends
        { // question-2 starts
            "opts": [{
                "optName": "a",
                "optContent": "optContent",
                "orderIndex": 0,
                "correct": true
            },
            {
                "optName": "b",
                "optContent": "optContent",
                "orderIndex": 1,
                "correct": true
            }],
            "content": "content",
            "orderIndex": 1,
            "type": 0
        } // question-2 ends

    ],

  	// 任务信息
    "quest": {
        "title": "testTTTTT",
        "questCateId": 1,
        "startTime": "2015-11-11 10:10:10",
        "endTime": "2016-11-11 10:10:10",
        "totalAmt": 5, // 任务总数量
        "award": 10, // 答对所有问题时给学生的赏金
        "contactName": "whf",
        "contactPhone": "111111",
        "description": "description",
        "questDetail": "detail",
        "provinceId": 1,
        "cityId":1,
        "regionId":1

    },
  	"orderId": 10,  // 订单号, 可选参数. 如果不填写会从钱包中扣钱，填写会检查对应的订单信息(不从钱包扣钱)	

  	// 任务对象
    "collegeIds": "1;2;3",
    "schoolIds": "1;2;3",
  	"cityIds": "1;2",
  	"proIds": "1;2",

  	"save": 0 或 1 // 可选参数. 0: 直接发布. 1: 保存但不发布(一样扣钱). 默认为0
}
```

> 服务器会自动计算答对每个问题的赏金。如, `award = 10`且一共有4个问题时，学生每答对一题的赏金为`award / 4 = 2.50`

## B4.2 计算任务发布费用

需要登陆。

``` 
GET /api/user/quest/fee
```

参数：

| 参数名   | 必填   | 说明     |
| ----- | ---- | ------ |
| award | Y    | 单个任务赏金 |
| amt   | Y    | 任务总数量  |

对于请求

``` 
GET /api/user/quest/fee?award=10&amt=10
```

返回报文为：

``` json
{
  "message": "success",
  "code": 0,
  "data": 110, // 110元
  "ok": true
}
```



## B4.3 刷新任务

刷新任务可以使任务排名更靠前。

需要登陆。

``` 
PUT /api/user/quest/flush/{id}
```

> `id`为要刷新的任务id



## B4.4 商家审核任务

只有商家用户可调用。

``` 
PUT /api/user/quest/submit/{reqId}
```

> `reqId`: 任务提交申请的id号

参数：

| 参数名    | 必填   | 说明   |
| ------ | ---- | ---- |
| status | Y    | 审核结果 |
| memo   | N    | 备注   |

其中，status参数取值如下：

| 取值   | 含意      |
| ---- | ------- |
| 01   | 等待审核    |
| 02   | 商家审核不通过 |
| 05   | 商家通过    |

> 如果审核不通过，应当传入memo参数说明审核失败的原因。



## B4.5 发布线下任务

需要先完成个人身份认证。

单个用户接口调用最小间隔为`10s`

``` 
POST /api/user/offquest
```

参数：

| 参数名   | 必填   | 说明                                     |
| ----- | ---- | -------------------------------------- |
| title | Y    | 任务标题(45字内)                             |
| cate  | Y    | 任务分类id                                 |
| award | Y    | 任务赏金( > 0 )                            |
| wt    | Y    | 任务执行的时间(2020-12-12 10:10:10)，必须填写未来的时间 |
| wp    | Y    | 任务执行的地点                                |
| desp  | Y    | 任务要求，描述，说明                             |
| proid | Y    | 任务所在省                                  |
| cid   | Y    | 任务所在市                                  |
| rid   | Y    | 任务所在区                                  |
| la    | Y    | 纬度. 如: `37.20`                         |
| lo    | Y    | 经度. 如: `122.18`                        |

## B4.6 上(下)架线下任务

需要登陆。

``` 
PUT api/user/offquest/offline
```

参数：

| 参数名  | 必填   | 说明                           |
| ---- | ---- | ---------------------------- |
| q    | Y    | 任务id                         |
| off  | N    | 是否下线. `1`: 下线(默认值 ), `0`: 上线 |

## B4.7 刷新线下任务

需要登陆。

``` 
PUT /api/user/offquest/f
```

参数：

| 参数名  | 必填   | 说明   |
| ---- | ---- | ---- |
| q    | Y    | 任务id |

## 4.8 删除任务草稿

需要登陆，只能删除处于草稿状态的任务。

``` 
DELETE /api/user/quest/{id}
```

> `id`: 要删除的任务id



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

## B6.1 提交问卷答案

调用场景：用户选择完一个问题的选项点击提交时调用。

需要用户登陆且领取对应任务。

``` 
GET /api/user/quest/question/check
```

参数：

| 参数名        | 必填   | 说明                          |
| ---------- | ---- | --------------------------- |
| questionId | Y    | 被答问题的id                     |
| optIds     | Y    | 用户选择的选项id, 以`;`分隔。如，`1;2;3` |

返回报文：

``` json
{
  "message": "success",
  "code": 0,
  "data": false, // false表示答案错误, true表示回答正确
  "ok": true
}
```



# 任务查询

## B7 查询任务发布记录

需要商家用户登陆。

``` 
GET /api/user/quest/publish/list
```

参数：

| 参数名    | 必填   | 说明                                       |
| ------ | ---- | ---------------------------------------- |
| pn     | N    | 显示第几页. default = 0                       |
| ps     | N    | 一页多少条记录. default = 8                     |
| status | Y    | `0`:未发布`1`:审核中 `2`:审核失败 `3`:审核通过 `4`: 已结束 |
| memId  | N    | **该参数只对管理员有效**，表示查询指定用户的发布记录             |

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
        "empStatus": 1, // 状态. 0:未发布 1:审核中 2:审核失败 3:审核通过
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

## B7.1 查询指定任务的答题记录

需要登陆，用于判断一个问卷中有哪些题目已答，哪些未答。

``` 
GET /api/user/quest/question/record
```

参数：

| 参数名     | 必填   | 说明               |
| ------- | ---- | ---------------- |
| questId | Y    | 任务id, 必须是答题或问卷任务 |

返回报文：

``` json
{
  "message": "success",
  "code": 0,
  "data": {
    "list": [
      {
        "id": 1,
        "createdTime": "2015-10-22 13:58:16", // 答题时间
        "questionId": 9, // 问题id
        "memberId": 2, // 答题者用户id
        "questId": 14 // 题目对应的任务id
      },
      {
        "id": 2,
        "createdTime": "2015-10-23 08:22:25",
        "questionId": 10,
        "memberId": 2,
        "questId": 14
      }
    ],
    "resultCount": 2
  },
  "ok": true
}
```



## B7.2 查询问卷中所有题目

需要登陆且已经领取该任务。

``` 
GET /api/user/quest/question
```

参数：

| 参数名     | 必填   | 说明   |
| ------- | ---- | ---- |
| questId | Y    | 任务   |

对于请求

``` 
GET /api/user/quest/question?questId=14
```

返回报文：

``` json
{
  "message": "success",
  "code": 0,
  "data": {
    "list": [ // list数组中每一个对象表示一道题目
      {
        "id": 9, // 题目的id号
        "createdTime": "2015-10-22 10:26:03", // 题目创建时间
        "content": "content", // 题目内容
        "questId": 14, // 当前任务id
        "orderIndex": 1, //排序值 ，越小越靠前
        "type": 1, // 题目类型。 0: 答题 1:问卷
        "userAmt": 5, // 答过此题的人数
        "correctAmt": 0, // 答对此题的人数
        "opts": [ // 题目对应的选项
          {
            "id": 9, // 选项id
            "optName": "a", // 选项名
            "optContent": "optContent", // 选项内容 
            "questionId": 9, // 选项对应的问题id
            "answerAmt": 2, // 选择过此选项的用户人数
            "orderIndex": 0 // 排序值 ，越小越靠前
          },
          {
            "id": 10,
            "optName": "b",
            "optContent": "optContent",
            "questionId": 9,
            "answerAmt": 0,
            "orderIndex": 1
          }
        ]
      },
      {
        "id": 10,
        "createdTime": "2015-10-22 10:26:03",
        "content": "content",
        "questId": 14,
        "orderIndex": 1,
        "type": 0,
        "userAmt": 8,
        "correctAmt": 2,
        "opts": [
          {
            "id": 11,
            "optName": "a",
            "optContent": "optContent",
            "questionId": 10,
            "answerAmt": 7,
            "orderIndex": 1
          },
          {
            "id": 12,
            "optName": "b",
            "optContent": "optContent",
            "questionId": 10,
            "answerAmt": 4,
            "orderIndex": 1
          }
        ]
      }
    ],
    "resultCount": 2
  },
  "ok": true
}
```

## B7.3 查询答题统计数据

需要登陆，只有题目的发布者才能调用。

``` 
GET /api/user/quest/question/result
```

| 参数名     | 必填   | 说明   |
| ------- | ---- | ---- |
| questId | Y    | 任务   |

返回报文：

``` json
{
  "message": "success",
  "code": 0,
  "data": {
    "list": [
      {
        "questionId": 9, // 问题id
        "totUser": 5, // 参与答该题的总人数
        "correctUser": 0, // 答对的人数
        "percentage": 0, // 正确率
        "opts": { // 问题选项统计数据
          "9": "2", // 选择id = 9选项的人数
          "10": "0" // 选择id = 10选项的人数
        }
      },
      {
        "questionId": 10,
        "totUser": 8,
        "correctUser": 2,
        "percentage": 0.25, // 正确率
        "opts": {
          "11": "7",
          "12": "4"
        }
      }
    ],
    "resultCount": 2
  },
  "ok": true
}
```



## B7.4 查询当前用户发布的线下任务

需要登陆。

``` 
GET /api/user/offquest/list
```

参数：

| 参数名  | 必填   | 说明   |
| ---- | ---- | ---- |
| pn   | N    |      |
| ps   |      |      |

对于请求

``` 
GET /api/user/offquest/list?ps=1
```

返回报文为：

``` json
{
  "message": "success",
  "code": 0,
  "data": {
    "list": [
      {
        "id": 13,
        "memId": 2,
        "username": "wanghongfei", // 发布者用户名
        "title": "title", // 线下任务标题
        "cateId": 1, // 任务分类id
        "cateName": "off_cate", // 任务分类名称
        "award": 10.5, // 赏金
        "createdTime": "2015-12-01 14:24:58", // 发布时间
        "workTime": "2020-02-02 02:10:20", // 任务执行时间
        "workPlace": "work place", // 工作地点
        "description": "description", // 工作详情
        "contactPhone": "18518369058", // 联系电话
        "status": "00",
        "provinceId": 1, // 工作所在省id
        "cityId": 1, // 工作所在城市id
        "regionId": 1 // 工作所在区域id
      }
    ],
    "resultCount": 9
  },
  "ok": true
}
```

`status`取值如下：

| 取值   | 含意   |
| ---- | ---- |
| 00   | 已发布  |
| 02   | 已下线  |

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



## B9.1 查询已领取的卡券

只有学生才能调用。

``` 
GET /api/user/quest/coupon/list
```

参数：

| 参数名    | 必填   | 说明         |
| ------ | ---- | ---------- |
| status | N    | 是否根据卡券状态过虑 |
| pn     | N    |            |
| ps     | N    |            |

`status`取值如下：

| 取值   | 说明                   |
| ---- | -------------------- |
| 0    | 未被领取(学生调用该接口不会出现此状态) |
| 1    | 已被领取                 |
| 2    | 已使用                  |

反回报文：

``` json
{
  "message": "success",
  "code": 0,
  "data": {
    "list": [
      {
        "id": 1,
        "code": "PdcWjcnYiPELfvnTWvkKJmCScNAYbU", // 卡券编号
        "createdTime": "2015-10-27 03:07:40", // 商家创建卡券的日期
        "acquireTime": "2015-10-27 07:57:26", // 领取日期
        "empId": 1, // 发卡商家用户id
        "memId": 2, // 领取者用户id
        "questTitle": "title", // 卡标题
        "questId": 27, // 卡对应的任务
        "compName": null, // 商家店铺名
        "title": "coupon", // 卡券标题
        "description": "desp", // 卡券使用说明
        "expiredTime": "2019-12-31 16:00:00", // 过期时间
        "logoPath": "logo.jpg", // logo图片的URL地址(可以为空)
        "status": 1 // 卡券状态值 
      },
      {
        "id": 2,
        "code": "mghBLXpEATOrQrlglIOwwfobypEajZ",
        "createdTime": "2015-10-27 03:07:40",
        "acquireTime": "2015-10-27 07:57:26",
        "empId": 1,
        "memId": 2,
        "questTitle": "title",
        "questId": 27,
        "compName": null,
        "title": "coupon",
        "description": "desp",
        "expiredTime": "2019-12-31 16:00:00",
        "logoPath": "logo",
        "status": 2
      }
    ],
    "resultCount": 2
  },
  "ok": true
}
```



## B9.2 商家验证卡券

只有商家用户可调用。

商家通过手机扫描客户出示的二维码，识别出`code`值，然后调用该接口。

``` 
GET /api/user/quest/coupon/check
```

参数：

| 参数名  | 必填   | 说明   |
| ---- | ---- | ---- |
| code | Y    | 卡券编号 |

## B9.3 商家查询已经创建的卡券信息

只有商家可以调用。

``` 
GET /api/user/quest/coupon/emp/list
```

参数：

| 参数名  | 必填   | 说明   |
| ---- | ---- | ---- |
| pn   | N    |      |
| ps   |      |      |

返回报文示例：

``` json
{
  "message": "success",
  "code": 0,
  "data": {
    "list": [ // list中的每一条记录表示一张卡券信息
      {
        // 卡券详细信息
        "coupon": {
          "id": 1,
          "createdTime": "2015-10-27 03:07:40",
          "empId": 1, // 创建卡券的用户id
          "memId": 2, // 忽略
          "questTitle": "title", // 卡券对应的任务的标题
          "questId": 27, // 卡券对应的任务id
          "title": "coupon", // 卡券标题
          "description": "desp", // 卡券描述
          "expiredTime": "2019-12-31 16:00:00",
          "logoPath": "logo" // 卡券logo路径
        },
        "total": 1, // 卡券总数量
        "left": 1 // 目前剩余数量
      },
      {
        "coupon": {
          "id": 21,
          "createdTime": "2015-10-27 03:15:23",
          "empId": 1,
          "questTitle": "title",
          "questId": 28,
          "title": "coupon",
          "description": "desp",
          "expiredTime": "2019-12-31 16:00:00",
          "logoPath": "logo"
        },
        "total": 10,
        "left": 10
      },
      {
        "coupon": {
          "id": 41,
          "createdTime": "2015-11-12 15:11:45",
          "empId": 1,
          "questTitle": "SHIT2",
          "questId": 45,
          "title": "couponTitle",
          "description": "desp",
          "expiredTime": "2020-10-09 16:00:00"
        },
        "total": 10,
        "left": 10
      },
      {
        "coupon": {
          "id": 141,
          "createdTime": "2015-11-13 14:20:26",
          "empId": 1,
          "questTitle": "SHIT2",
          "questId": 46,
          "title": "couponTitle",
          "description": "desp",
          "expiredTime": "2020-10-09 16:00:00"
        },
        "total": 4,
        "left": 4
      },
      {
        "coupon": {
          "id": 241,
          "createdTime": "2015-11-13 14:24:56",
          "empId": 1,
          "questTitle": "SHIT2",
          "questId": 47,
          "title": "couponTitle",
          "description": "desp",
          "expiredTime": "2020-10-09 16:00:00"
        },
        "total": 4,
        "left": 3
      }
    ],
    "resultCount": 5
  },
  "ok": true
}
```



## B9.4 根据id查询卡券

需要登陆，只能查询自己领取的卡券。

``` 
GET /api/user/quest/coupon/{id}
```

> `id`: 卡券id号



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

| 取值   | 含意       |
| ---- | -------- |
| 01   | 待审核      |
| 02   | 商家审核未通过  |
| 03   | 桃李街审核未通过 |
| 04   | 自动通过     |
| 05   | 商家审核通过   |
| 06   | 桃李街审核通过  |

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



## B10.1 查询商家任务审核列表

需要商家登陆状态。

``` 
GET /api/user/quest/submit/audit/list
```

参数:

| 参数名  | 必填   | 说明   |
| ---- | ---- | ---- |
| pn   | N    |      |
| ps   | N    |      |

返回数据：

``` json
{
  "message": "success",
  "code": 0,
  "data": {
    "list": [
      {
        "questId": 27,
        "quest": {  // 对应的任务信息
          "id": 27,
          "title": "title", // 任务标题
          "createdTime": "2015-10-27 03:07:40", // 显示该时间
          "totalAmt": 4, // 任务总数量

        },
        "cateName": "cate1", // 任务分类名
        "empId": 1,
        "imageIds": "1;2",
        "amt": 1 // 已经提交的数量
      },
      {
        "questId": 1,
        "quest": {
          "id": 1,
          "title": "quest-1",
          "createdTime": "2015-10-15 02:09:43",
          "totalAmt": 10  
        },
        "cateName": "cate1",
        "empId": 1,
        "imageIds": "/sh/;2/;",
        "amt": 2
      }
    ],
    "resultCount": 2
  },
  "ok": true
}
```





## B11 条件查询线上任务

任何人都可以调用该接口.

非管理员调用该接口，只返回`empStatus == 3`(已审核通过)的任务，如果是管理员调用，则可以指定`empStatus`类型。

``` 
GET /api/quest/list
```

参数：

| 参数名       | 必填   | 说明                                      |
| --------- | ---- | --------------------------------------- |
| cateId    | N    | 填写表示根据分类过虑结果                            |
| min       | N    | 任务的最低赏金(include)                        |
| max       | N    | 任务的最高赏金(include)                        |
| pn        | N    |                                         |
| ps        | N    |                                         |
| regionId  | N    | 区域id                                    |
| schoolId  | N    | 学校id                                    |
| empStatus | N    | ****只有管理员可以使用该参数**。填写表示根据empStatus值筛选结果 |

> 只填写`min`不填`max`表示查询赏金`>= min`的任务。
> 
> 只填写`max`不填`min`表示查询赏金`<= max`的任务。
> 
> 同时填写表示查询赏金在`min`与`max`之间的任务。

`empStatus`取值 ：

| 取值   | 含意        |
| ---- | --------- |
| 0    | 未发布(草稿状态) |
| 1    | 审核中       |
| 2    | 审核不通过     |
| 3    | 审核通过      |

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





## B12 根据id查询线上任务

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

返回报文示例：

``` json
{
  "message": "success",
  "code": 0,
  "data": {
    "id": 1,
    "title": "quest-1",
    "createdTime": "2015-10-15 02:09:43",
    "flushTime": 1445829952000,
    "questCateId": 1,
    "startTime": "2014-12-31 16:00:00",
    "endTime": "2019-12-31 16:00:00",
    "limitTime": 2,
    "totalAmt": 10,
    "leftAmt": 9,
    "award": 1,
    "memberId": 1,
    "finalAward": 1,
    "contactName": "whf",
    "contactPhone": "111111",
    "description": "description",
    "questDetail": "detail",
    "offline": false,
    "tagExpireTime": "2015-10-21 18:04:35",
    "questionAmt": 0,
    "coupon": false,
    "couponLeft": 0,
    "empStatus": 3,
    "provinceId": 1,
    "cityId": 1,
    "regionId": 1,
    "schools": [ // 任务对象: 学院信息
      {
        "id": 1,
        "questId": 1,
        "schoolId": 2,
        "schoolName": "计算机学院"
      },
      {
        "id": 2,
        "questId": 1,
        "schoolId": 3,
        "schoolName": "电气学院"
      }
    ],
    "colleges": [ // 任务对象：大学
      {
        "id": 1,
        "questId": 1,
        "collegeId": 1,
        "collegeName": "山东理工大学"
      }
    ],
    "cities": [ // 任务对象：城市
  	 {
        "id": 1,
        "questId": 1,
        "cityId": 1,
        "cityName": "淄博"
      }
	], 
    "pros": [ // 任务对象：省
  	{
        "id": 1,
        "questId": 1,
        "provinceId": 1,
        "provinceName": "山东"
      }
	] 
  },
  "ok": true
}
```



## B12.1 查询附近的线下任务

不需要登陆。

``` 
GET /api/offquest/near
```

参数：

| 参数名  | 必填   | 说明               |
| ---- | ---- | ---------------- |
| lo   | Y    | 当前经度, 如`120.234` |
| la   | Y    | 当前纬度, 如`25.12`   |
| ps   | N    | 一页显示的记录数，默认为8条   |

返回报文：

``` json
{
  "message": "success",
  "code": 0,
  "data": {
    "list": [
      {
        "id": 6,
        "memId": 2,
        "username": "wanghongfei", // 任务发布者用户名
        "title": "title",
        "cateId": 1,
        "cateName": "off_cate", // 任务分类名
        "award": 10.5,
        "createdTime": "2015-12-01 10:52:40", // 任务发布时间(不要显示)
        "workTime": "2020-02-02 02:10:20",
        "workPlace": "work place",
        "description": "description",
        "contactPhone": "18518369058",
        "status": "00",
        "provinceId": 1,
        "cityId": 1,
        "regionId": 1,
        "flushTime": null, // 任务最近一次刷新的时间(总是给客户显示这个时间)
        "distance": 69 // 该任务距离当前位置的距离，单位: 米
      }
    ],
    "resultCount": 1 // 忽略该值
  },
  "ok": true
}
```



## B12.2 根据区域查询线下任务

不需要登陆。

``` 
GET /api/offquest/region
```

参数：

| 参数名  | 必填   | 说明   |
| ---- | ---- | ---- |
| rid  | Y    | 区域id |
| pn   | N    |      |
| ps   | N    |      |

返回结果同`B12.1`



## B12.3 根据id查询线下任务

不需要登陆。

``` 
GET /api/offquest/{id}
```

> `id`: 线下任务id号

返回报文：

``` json
{
  "message": "success",
  "code": 0,
  "data": {
    "id": 19,
    "memId": 2,
    "username": "wanghongfei",
    "title": "title",
    "cateId": 1,
    "cateName": "off_cate",
    "award": 10.5,
    "createdTime": "2015-12-02 06:47:13",
    "workTime": "2020-02-02 02:10:20",
    "workPlace": "work place",
    "description": "description",
    "contactPhone": "185XXXX9058",
    "status": "00",
    "provinceId": 1,
    "cityId": 1,
    "regionId": 1,
    "flushTime": "2015-12-02 06:47:13",
    "distance": null
  },
  "ok": true
}
```



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