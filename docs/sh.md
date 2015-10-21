# 查询操作

## G1 查询单个二手分类信息

``` 
POST /api/sh/cate/{id}
```

> `id`: 分类的id

返回报文：

``` json
{
  "message": "success",
  "code": 0,
  "data": {
    "id": 1,
    "name": "自行车",
    "level": 2,
    "themeColor": "#C71585",
    "memo": "我是name1"
  },
  "ok": true
}
```



## G2 查询二手分列表

``` 
GET /api/sh/cate/list
```

该接口没有参数。

返回报文：

``` json
{
  "message": "success",
  "code": 0,
  "data": {
    "list": [
      {
        "id": 1,
        "name": "自行车",
        "level": 2,
        "themeColor": "#C71585",
        "memo": "我是name1"
      },
      {
        "id": 2,
        "name": "电动车",
        "level": 3,
        "themeColor": "#C71585",
        "memo": "我是name2"
      },
      {
        "id": 3,
        "name": "摩托车",
        "level": 11,
        "themeColor": "11",
        "memo": "摩托车"
      }
    "resultCount": 3
  },
  "ok": true
}
```



## G3 二手关键字搜索

``` 
GET /api/sh/search
```

参数：

| 参数名        | 必填   | 说明        |
| ---------- | ---- | --------- |
| title      | N    | 标题中包含该关键字 |
| pageNumber | N    |           |
| pageSize   | N    |           |

返回报文：

``` json
{
  "message": "success",
  "code": 0,
  "data": {
    "list": [
      {
        "id": 95,
        "picturePath": "2015/9/28/sh-376;2015/9/28/sh-375;2015/9/28/sh-373;2015/9/28/sh-370;2015/9/28/sh-371;2015/9/28/sh-374;2015/9/28/sh-372;2015/9/28/sh-369",
        "description": "270-----450元，全新自行车，绝对质量，售后有保障，校内实体店。",
        "title": "全新自行车低价出售270----450元",
        "deleted": false,
        "postTime": 1443183556000,
        "depreciationRate": "全新",
        "sellPrice": 270,
        "likes": 0,
        "dislikes": 0,
        "memberId": 1,
        "secondHandPostCategoryId": 1,
        "complaint": 0,
        "pageView": 0,
        "expired": false,
        "tradePlace": "面议",
        "contactName": "于先生",
        "contactQq": "",
        "contactPhone": "17865923820",
        "member": { // 发布者信息
          "id": 1,
          "studentId": "156648895",
          "blockList": "1",
          "userLevel": "LV0",
          "appliedJobIds": "1",
          "likedJobIds": "191;189;",
          "likedShIds": "49;48;45;",
          "username": "taolijie-admin",
          "email": "196645665@qq.com",
          "name": "黄棉",
          "gender": "女",
          "verified": "VERIFIDE",
          "profilePhotoPath": "http://jingyan.baidu.com/",
          "phone": "178456258789",
          "qq": "19",
          "age": 19,
          "companyName": "京东商城",
          "createdTime": 1432051200000,
          "valid": true,
          "complaint": 0,
          "profilePhotoId": 380,
          "lastPostTime": 1432915200000,
          "schoolOrganization": "NONE",
          "credits": 0,
          "roleList": []
        },
        "category": { // 分类信息
          "id": 1,
          "name": "自行车",
          "level": 2,
          "themeColor": "#C71585",
          "memo": "我是name1"
        },
        "rangeQuery": 0
      },
      {
        "id": 84,
        "picturePath": "2015/9/28/sh-279;2015/9/28/sh-278",
        "description": "转让全新死飞自行车，若干辆，校内试骑。",
        "title": "转让全新死飞自行车若干辆",
        "deleted": false,
        "postTime": 1442215020000,
        "depreciationRate": "全新",
        "sellPrice": 330,
        "likes": 1,
        "dislikes": 0,
        "memberId": 1,
        "secondHandPostCategoryId": 1,
        "complaint": 0,
        "pageView": 0,
        "expired": false,
        "tradePlace": "理工大学",
        "contactName": "高先生",
        "contactQq": "981833831",
        "contactPhone": "15169234965",
        "member": {
          "id": 1,
          "studentId": "156648895",
          "blockList": "1",
          "userLevel": "LV0",
          "appliedJobIds": "1",
          "likedJobIds": "191;189;",
          "likedShIds": "49;48;45;",
          "username": "taolijie-admin",
          "email": "196645665@qq.com",
          "name": "黄棉",
          "gender": "女",
          "verified": "VERIFIDE",
          "profilePhotoPath": "http://jingyan.baidu.com/",
          "phone": "178456258789",
          "qq": "19",
          "age": 19,
          "companyName": "京东商城",
          "createdTime": 1432051200000,
          "valid": true,
          "complaint": 0,
          "profilePhotoId": 380,
          "lastPostTime": 1432915200000,
          "schoolOrganization": "NONE",
          "credits": 0,
          "roleList": []
        },
        "category": {
          "id": 1,
          "name": "自行车",
          "level": 2,
          "themeColor": "#C71585",
          "memo": "我是name1"
        },
        "rangeQuery": 0
      }
    ],
    "resultCount": 12
  },
  "ok": true
}
```





## G4 查询用户发布的二手

``` 
GET /api/sh/user/{memId}
```

> memId: 用户id

参数：

| 参数名        | 必填   | 说明   |
| ---------- | ---- | ---- |
| pageNumber | N    |      |
| pageSize   |      |      |

## G5 根据分类查询二手

查询指定分类下的二手信息，最新发布的在前。

``` 
GET /api/sh/category/{cateId}
```

> cateId: 分类id

参数：

| 参数名        | 必填   | 说明   |
| ---------- | ---- | ---- |
| pageNumber | N    |      |
| pageSize   |      |      |

## G6 条件过虑查询

``` 
GET /api/sh/filter
```

参数：

| 参数名              | 必填   | 说明                                |
| ---------------- | ---- | --------------------------------- |
| title            | N    | 根据标题过虑                            |
| depreciationRate | N    | 根据新旧程度过虑。如：九成新、全新                 |
| minPrice         | N    | 价格下限（包括）                          |
| maxPrice         | N    | 价格上限（包括）                          |
| rangeQuery       | (Y)  | 当`minPrice`或`maxPrice`不为空时，该参数必填1 |
| pageNumber       | N    |                                   |
| pageSize         | N    |                                   |

返回报文同`G3`



## G7 查询单条二手

``` 
GET /api/sh/{id}
```

> id: 二手id号

返回报文：

``` json
{
  "message": "success",
  "code": 0,
  "data": {
    "id": 102,
    "picturePath": "2015/10/3/sh-1167",
    "description": "7成新  质量有保证！有问题随时解决！！！",
    "title": "二手电动车",
    "deleted": false,
    "postTime": 1443872413000,
    "depreciationRate": "七成新",
    "sellPrice": 550,
    "likes": 0,
    "dislikes": 0,
    "memberId": 100,
    "secondHandPostCategoryId": 2,
    "complaint": 0,
    "pageView": 0,
    "expired": false,
    "tradePlace": "东校",
    "contactName": "朱玉潇",
    "contactQq": "876573362",
    "contactPhone": "17865921129",
    "member": {
      "id": 100,
      "userLevel": "LV0",
      "username": "17865921129",
      "verified": "NONE",
      "createdTime": 1443801600000,
      "valid": true,
      "roleList": []
    },
    "category": {
      "id": 2,
      "name": "电动车",
      "level": 3,
      "themeColor": "#C71585",
      "memo": "我是name2"
    },
    "rangeQuery": 0
  },
  "ok": true
}
```



## G8 查询全部二手

``` 
GET /api/sh/list
```

参数：

| 参数名        | 必填   | 说明   |
| ---------- | ---- | ---- |
| pageNumber | N    |      |
| pageSize   |      |      |

返回报文同`G3`



## G9 查询用户收藏列表

需要登陆。

``` 
GET /api/u/sh/favlist
```

参数：

| 参数名        | 必填   | 说明   |
| ---------- | ---- | ---- |
| pageNumber | N    |      |
| pageSize   |      |      |

## G10 查询二手是否已赞

需要登陆。

``` 
GET /api/u/sh/like/{shId}
```

> shId: 二手id号





# 更新操作

## G11 发布二手

需要登陆。

``` 
POST /api/u/sh
```

参数：

| 参数名                      | 必填   | 说明                                       |
| ------------------------ | ---- | ---------------------------------------- |
| picIds                   | Y    | 二手相关的图片URL路径，以";"分隔。如， /2015/2/12/sh-102;/2013/2/12/sh-102 |
| title                    | Y    | 二手标题                                     |
| secondHandPostCategoryId | Y    | 二手分类的id                                  |
| depreciationRate         | Y    | 新旧程度。如: 八成新、全新                           |
| sellPrice                | Y    | 价格, 精确到小数点后2位，如：300.00                   |
| description              | Y    | 商品描述                                     |
| tradePlace               | Y    | 交易地点                                     |
| contactName              | Y    | 联系人姓名                                    |
| contactQq                | Y    | 联系人QQ                                    |
| contactPhone             | Y    | 联系人手机号                                   |

## G12 修改二手信息

发布者可以修改自己发布的二手信息。

``` 
PUT /api/u/sh/{shId}
```

> shId: 二手id

与`G11`参数相同，所有参数为选填。



## G13 删除二手

如果id对应的二手已经处于删除状态，则操作结果为取消删除。

``` 
DELETE /api/u/sh/{id}
```

> id: 二手id



## G14 收藏/取消二手

需要登陆。

如果已经收藏过了，则操作结果为取消收藏；如果未收藏，操作结果为添加收藏。

``` 
POST /api/u/sh/fav/{id}
```

> id: 要操作的二手id

参数：

| 参数名  | 必填   | 说明             |
| ---- | ---- | -------------- |
| ids  | Y    | 以";"分隔的二手id, 如 |

## G15 点赞

需要登陆。

``` 
POST /api/u/sh/like/{id}
```

> id: 要点赞的二手id