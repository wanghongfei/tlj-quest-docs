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

> 接口调用后，服务器会自动计算总任务赏金，并从发布者的现金账户中扣除可用余额。
> 
> 扣除的金额 = [ (1 + 费率) * 单个任务赏金 ] * 任务数量



# 后台管理接口

以下所有接口需要以管理员身份登陆才能成功调用。

## 创建轻兼职分类

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



## 更新分类信息

``` 
PUT /api/quest/cate/{cateId}
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



## 删除分类

``` html
DELETE /api/quest/cate/{cateId}
```

> cateId: 要删除的分类的id号
> 
> 只有当该分类下没有帖子时才能成功删除，否则返回错误代码9.
