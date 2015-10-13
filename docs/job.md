# 查询操作

## F1 查询单个分类信息

根据id查询分类信息。

``` 
GET /api/job/cate/{id}
```

> id: 分类的id

返回报文：

``` json
{
  "message": "success",
  "code": 0,
  "data": {
    "id": 1,
    "name": "家教", // 分类名
    "level": 1, // 暂时无用
    "themeColor": "#edbc5a", // 分类背景色
    "memo": "家教" // 备注
  },
  "ok": true
}
```



## F2 查询兼职分类列表

``` 
GET /api/job/cate/list
```

该接口不需要参数，返回所有兼职分类。

返回报文：

``` json

  "message": "success",
  "code": 0,
  "data": {
    "list": [
      {
        "id": 1,
        "name": "家教",
        "level": 1,
        "themeColor": "#edbc5a",
        "memo": "家教"
      },
      {
        "id": 2,
        "name": "派单员",
        "level": 2,
        "themeColor": "#b3a5c8",
        "memo": "派单员"
      },
      {
        "id": 3,
        "name": "代理",
        "level": 3,
        "themeColor": "#658a9b",
        "memo": "代理"
      }
      
    "resultCount": 3
  },
  "ok": true
}
```





## F3 搜索兼职

关键字搜索，根据帖子的标题。

``` 
GET /api/job/search
```

参数：

| 参数名        | 必填   | 说明                |
| ---------- | ---- | ----------------- |
| pageNumber | N    | 查询第几页，0(默认)表示第一页。 |
| pageSize   | N    | 一页的结果数，默认为8       |
| title      | N    | 关键字, 不填表示查询所有     |

对于请求

``` 
GET /api/job/search?title=代理&pageSize=2
```

一共有7条结果，当前返回了前2条：

``` json
{
  "message": "success",
  "code": 0,
  "data": {
    "list": [
      {
        "id": 241,
        "title": "京安驾校代理数名",
        "expiredTime": 1445184000000,
        "expired": false,
        "postTime": 1444642214000,
        "workPlace": "理工大学西校内",
        "wage": 0.0,
        "timeToPay": "完工结算",
        "deleted": false,
        "jobDescription": "。主要利用课余时间在本专业或本宿舍楼宣传招生！有意者编辑短信电话+姓名+年级系别",
        "contact": "短信报名即可",
        "contactPhone": "17865938895",
        "jobDetail": "，只要你想锻炼自己，都可以加入京安驾校代理团队，在这里不仅可以得到提升，而且也可获得不可估量的收入，每个系只限1名，只要你肯努力必定能获得丰厚的待遇",
        "likes": 0,
        "dislikes": 0,
        "jobPostCategoryId": 3,
        "memberId": 90,
        "complaint": 0,
        "workTime": "课余时间",
        "salaryUnit": "时",
        "pageView": 0,
        "applicantAmount": 0,
        "province": "山东省",
        "city": "淄博市",
        "region": "张店区",
        "member": { // 兼职发布者信息
          "id": 90,
          "userLevel": "LV0",
          "username": "tljzyl",
          "verified": "01",
          "createdTime": 1443369600000,
          "valid": true,
          "roleList": [
            
          ]
        },
        "category": { // 该兼职所属于的分类信息
          "id": 3,
          "name": "代理",
          "level": 3,
          "themeColor": "#658a9b",
          "memo": "代理"
        }
      },
      {
        "id": 152,
        "title": "国安驾校校园代理",
        "expiredTime": 1446220800000,
        "expired": false,
        "postTime": 1443183803000,
        "workPlace": "随意安排",
        "wage": 100.0,
        "timeToPay": "日结",
        "deleted": false,
        "jobDescription": "优厚，有意编辑短信... ...",
        "contact": "王先生",
        "contactPhone": "17865924072",
        "contactQq": "2635694948",
        "jobDetail": "一、招聘:  ... ...",
        "likes": 1,
        "dislikes": 0,
        "jobPostCategoryId": 3,
        "memberId": 1,
        "complaint": 0,
        "workTime": "随意安排",
        "salaryUnit": "天",
        "pageView": 0,
        "applicantAmount": 0,
        "province": "山东省",
        "city": "淄博市",
        "region": "张店区",
        "member": {
          "id": 1,
          "studentId": "156648895",
          "blockList": "1",
          "userLevel": "LV0",
          "username": "taolijie-admin",
          "email": "196645665@qq.com",
          "name": "黄棉",
          "gender": "女",
          "verified": "01",
          "profilePhotoPath": "http://jingyan.baidu.com/",
          "companyName": "京东商城",
          "createdTime": 1432051200000,
          "valid": true,
          "complaint": 0,
          "profilePhotoId": 380,
          "lastPostTime": 1432915200000,
          "schoolOrganization": "NONE",
          "credits": 0,
          "roleList": [
            
          ]
        },
        "category": {
          "id": 3,
          "name": "代理",
          "level": 3,
          "themeColor": "#658a9b",
          "memo": "代理"
        }
      }
    ],
    "resultCount": 7
  },
  "ok": true
}
```



## F4 多个id批量查询兼职信息

``` 
POST /api/job/list
```

参数：

| 参数名  | 必填   | 说明                |
| ---- | ---- | ----------------- |
| ids  | Y    | 以";"分隔的id号。如，1;2; |

返回报文同接口`F3`



## F5 根据分类查询兼职信息

查询指定分类下所有兼职信息。

``` 
GET /api/job/category/{cateId}
```

> `cateId`: 分类的id

参数：

| 参数名        | 必填   | 说明   |
| ---------- | ---- | ---- |
| pageNumber | N    |      |
| pageSize   |      |      |



## F6 查询指定用户发布的兼职信息

``` 
GET /api/job/user/{memId}
```

> `memId`: 用户的id

参数：

| 参数名        | 必填   | 说明   |
| ---------- | ---- | ---- |
| pageNumber | N    |      |
| pageSize   |      |      |



## F7 过虑查询

根据多个条件过虑兼职信息。

``` 
GET /api/job/filter
```

参数：

| 参数名               | 必填   | 说明                           |
| ----------------- | ---- | ---------------------------- |
| memberId          | N    | 填写表示必须为该用户发表的帖子              |
| province          | N    | 填写表示根据省份过虑                   |
| city              | N    | 根据城市过虑                       |
| region            | N    | 根据区域过虑. 如, region=张店区        |
| cateId            | N    | 根据分类过虑                       |
| filterExpiredPost | N    | 是否包括已经过期的帖子，true(默认) / false |
| title             | N    | 根据标题精确匹配                     |

返回报文同`F3`。



## F8 查询全部兼职信息

查询所有兼职信息，最新发布的在前。

``` 
GET /api/job/list
```

参数：

| 参数名        | 必填   | 说明   |
| ---------- | ---- | ---- |
| pageNumber | N    |      |
| pageSize   |      |      |

