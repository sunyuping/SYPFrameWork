//
//  YPTableViewKit.h
//  SYPFrameWork
//
//  Created by sunyuping on 13-1-8.
//  Copyright (c) 2013年 sunyuping. All rights reserved.
//

//#import "UIWindow+RscExt.h"
#import "UIViewAdditions.h"
#import "SVPullToRefresh.h"

#import "YPSearchDisplayController.h"
#import "YPTableViewController.h"
#import "YPTableViewDataSource.h"
#import "YPTableViewItem.h"
#import "YPTableViewCell.h"
#import "YPTableViewLoadMoreItem.h"
#import "YPTableViewLoadMoreCell.h"

#import "YPBaseTableView.h"
#import "YPErrorView.h"

#import "YPTableViewSectionedDataSource.h"
#import "YPTableViewSectionObject.h"

static   UIInterfaceOrientation TTInterfaceOrientation() {
    return [UIApplication sharedApplication].statusBarOrientation;
}

//声音类型定义
typedef enum {
    SoundEffectType_None = 0,
    // 推送消息
    SoundEffectType_PushMessage,
    // 当前对话人消息
    SoundEffectType_CurrentMessage,
    // 发送消息
    SoundEffectType_SendMessage,
    // 刷新下拉消息
    SoundEffectType_RefreshPress,
    // 刷新松手消息
    SoundEffectType_RefreshRelease,
    // 刷新完毕消息
    SoundEffectType_RefreshFinish
} soundEffectType;



