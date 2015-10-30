## H1 查询推荐列表

不需要登陆。

``` 
GET /api/re/list
```

参数：

| 参数名  | 必填   | 说明                           |
| ---- | ---- | ---------------------------- |
| type | Y    | `0`: 兼职帖子 `1`: 二手帖子  `3`: 任务 |
| pn   | N    |                              |
| ps   | N    |                              |

对于请求:

``` 
GET /api/re/list?type=0
```

返回报文：

``` json
{
  "message": "success",
  "code": 0,
  "data": {
    "list": [
      {
        "id": 1,
        "title": "我被修改了",
        "expiredTime": "2015-11-10 16:00:00",
        "expired": false,
        "postTime": "2015-10-15 05:09:25",
        "workPlace": "山东理工大学",
        "wage": 99,
        "timeToPay": "周结",
        "deleted": false,
        "jobDescription": "工作内容说明",
        "contact": "联系人",
        "contactPhone": "13287096323",
        "contactQq": "1252264267",
        "jobDetail": "工作要求说明",
        "likes": 1,
        "dislikes": 0,
        "jobPostCategoryId": 1,
        "memberId": 3,  // 发布者用户id
        "complaint": 0, // 投诉数量(暂不用)
        "workTime": "工作时间在周六周日",
        "pageView": 0, // 访问量(暂不用)
        "applicantAmount": 0, // 暂不用
        "province": "山东省",
        "city": "淄博市",
        "region": "张店区",
        "member": { // 发布者信息
          "id": 3,
          "username": "13287096323",
          "regType": 1,
          "roleList": []
        },
        "category": { // 帖子所在的分类信息
          "id": 1,
          "name": "家教",
          "level": 1,
          "themeColor": "#111111",
          "memo": "家教"
        }
      }
    ],
    "resultCount": 1
  },
  "ok": true
}
```



## H2 申请置顶推荐

需要登陆。

``` 
POST /api/user/re/top
```

参数：

| 参数名     | 必填   | 说明                             |
| ------- | ---- | ------------------------------ |
| type    | Y    | 帖子的类型. `0`:兼职, `1`:二手, `3`: 任务 |
| postId  | Y    | 帖子的id                          |
| days    | Y    | 推荐的天数                          |
| orderId | N    | 订单号. 填写表示通过订单支付, 不填表示钱包支付      |

## H3 审核加标签推荐

需要登陆。

``` 
POST /api/user/re/tag
```

参数：

| 参数名     | 必填   | 说明                        |
| ------- | ---- | ------------------------- |
| type    | Y    | 帖子的类型. 当前仅支持`3`:任务        |
| postId  | Y    | 帖子的id                     |
| days    | Y    | 推荐的天数                     |
| orderId | N    | 订单号. 填写表示通过订单支付, 不填表示钱包支付 |

## H4 查询我的置顶申请

需要登陆。

``` 
GET /api/user/re/list
```

参数：

| 参数名  | 必填   | 说明                 |
| ---- | ---- | ------------------ |
| type | N    | 是否根据帖子类型过虑。取值同`H2` |

返回报文：

``` json
{
  "message": "success",
  "code": 0,
  "data": {
    "list": [
      {
        "id": 9,
        "postId": 1, 							// 被推荐的帖子id
        "title": "我被修改了",					// 被推荐的帖子标题
        "type": 0, 								// 推荐类型. 取值同`H2`的`type`参数
        "memberId": 2, 							// 申请者用户id
        "createdTime": "2015-10-21 11:43:00",
        "auditTime": null,
        "expiredTime": "2016-10-21 13:43:00", 	// 推荐过期时间
        "orderIndex": 100, 						// 暂无用
        "valid": false 							// 暂无用
      }
    ],
    "resultCount": 1
  },
  "ok": true
}
```