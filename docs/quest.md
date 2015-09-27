# 分类

任务分类是任务的类型，每一个任务都有且仅属于一个分类。

## 查询分类列表

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

## 通过id查询分类

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



## 通过分类名查询分类信息

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

## 商家发布任务

``` 
POST /api/quest
```

> 只有以商家用户登陆才能成功调用。

参数：

| 参数名           | 必填   | 说明              | 
| ------------- | ---- | --------------- | 
| title         | Y    | 任务标题            | 
| quest_cate_id | Y    | 任务分类的id         | 
| startTime     | Y    | 任务开始时间          | 
| endTime       | Y    | 任务结束时间          | 
| totalAmt      | Y    | 任务总数量           | 
| award         | Y    | 单个任务的赏金         | 
| contactName   | Y    | 联系人姓名           | 
| contactPhone  | Y    | 联系人手机号          | 
| description   | Y    | 任务简述(100字以内)    | 
| questDetail   | Y    | 任务详细描述(1000字以内) | 
| url           | N    | 任务链接            | 
| memo          | N    | 任务备注            | 
| province_id   | Y    | 任务对象：省          | 
| city_id       | Y    | 任务对象：市          | 
| region_id     | Y    | 任务对象：区          | 
| college_id    | N    | 任务对象：大学         | 
| school_id     | N    | 任务对象：学院         | 
|               |      |                 | 

接口调用后，服务器会自动计算总任务赏金，并从发布者的现金账户中扣除可用余额。

> 扣除的金额 = [ (1 + 费率) * 单个任务赏金 ] * 任务数量



## 任务领取

只有登陆状态下的学生用户才可以领取任务。

``` 
POST /api/user/quest/assign/{questId}
```

> questId: 要领取的任务的id



## 提交任务完成申请

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

## 查询任务发布记录

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
        "createdTime": "2015-09-24 09:17:30",
        "questCateId": 1,
        "startTime": "2015-10-09 16:00:00",
        "endTime": "2015-12-31 16:00:00",
        "limitTime": 2,
        "totalAmt": 10,
        "leftAmt": 9,
        "award": 1,
        "memberId": 1,
        "finalAward": 1,
        "contactName": "whf",
        "contactPhone": "11111111111",
        "description": "task",
        "questDetail": "task",
        "url": null,
        "memo": null,
        "offline": false,
        "provinceId": 1,
        "cityId": 1,
        "regionId": 1,
        "collegeId": null,
        "schoolId": null
      }
    ],
    "resultCount": 1
  },
  "ok": true
}
```



## 查询任务领取记录

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
        "memberId": 1,
        "username": "hanxinxin",
        "questId": 1,
        "questTitle": "quest1",
        "assignTime": "2015-10-09 16:00:00",
        "status": "00"
      }
    ],
    "resultCount": 1
  },
  "ok": true
}
```



## 查询所有任务

任何人都可以调用该接口.

``` 
GET /api/quest/list
```

参数：

| 参数名    | 必填   | 说明               | 
| ------ | ---- | ---------------- | 
| cateId | N    | 填写表示根据分类过虑结果     | 
| min    | N    | 任务的最低赏金(include) | 
| max    | N    | 任务的最高赏金(include) | 
| pn     | N    |                  | 
| ps     | N    |                  | 

> 只填写`min`不填`max`表示查询赏金`>= min`的任务。
> 
> 只填写`max`不填`min`表示查询赏金`<= max`的任务。
> 
> 同时填写表示查询赏金在`min`与`max`之间的任务。



## 根据id查询任务

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