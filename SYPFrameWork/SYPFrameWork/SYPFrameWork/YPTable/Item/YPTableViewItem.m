//
//  YPTableItem.m
//  SYPFrameWork
//
//  Created by sunyuping on 13-1-8.
//  Copyright (c) 2013年 sunyuping. All rights reserved.
//

#import "YPTableViewItem.h"

@implementation YPTableViewItem
@synthesize cellHeight = _cellHeight;
@synthesize userInfo = _userInfo;

- (void)dealloc
{
    [_userInfo release];
    [super dealloc];
}

@end
