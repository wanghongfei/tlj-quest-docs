## I1查询学校列表

不需要登陆。

``` 
GET /api/dict/college
```

返回示例：

``` json
{
  "message": "success",
  "code": 0,
  "data": {
    "list": [
      {
        "id": 1,
        "fullName": "山东大学",
        "cityId": 1
      },
      {
        "id": 2,
        "fullName": "山东师范大学",
        "cityId": 1
      },
      {
        "id": 3,
        "fullName": "山东财经大学",
        "cityId": 1
      },
      {
        "id": 4,
        "fullName": "山东科技大学",
        "cityId": 1
      }
   ],
    "resultCount": 4
  },
  "ok": true
```



## I2 查询城市列表

``` 
GET /api/dict/city
```

返回示例：

``` json
{
  "message": "success",
  "code": 0,
  "data": {
    "list": [
      {
        "id": 1,
        "name": "济南市",
        "provinceId": 1
      },
      {
        "id": 2,
        "name": "青岛市",
        "provinceId": 1
      }
    ],
    "resultCount": 2
  },
  "ok": true
```



## I3 查询省列表

``` 
GET /api/dict/province
```

返回示例：

``` json
{
  "message": "success",
  "code": 0,
  "data": {
    "list": [
      {
        "id": 1,
        "name": "山东省"
      }
    ],
    "resultCount": 1
  },
  "ok": true
}
```



## I4 查询行业分类列表

``` 
GET /api/dict/industry
```

返回报文：

``` json
{
  "message": "success",
  "code": 0,
  "data": {
    "金融业": [
      {
        "id": 32,
        "name": "房地产",
        "parentId": 1
      },
      {
        "id": 33,
        "name": "建筑",
        "parentId": 1
      }
    ],
    "服务业": [
      {
        "id": 6,
        "name": "IT",
        "parentId": 3
      },
      {
        "id": 7,
        "name": "通信",
        "parentId": 3
      }
    ],
    "其它": []
  },
  "ok": true
}
```

