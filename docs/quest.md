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



