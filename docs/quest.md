# 查询任务分类

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

