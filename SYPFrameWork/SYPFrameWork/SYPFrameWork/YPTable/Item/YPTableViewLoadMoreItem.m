//
//  YPTableViewLoadMoreItem.m
//  SYPFrameWork
//
//  Created by sunyuping on 13-1-8.
//  Copyright (c) 2013年 sunyuping. All rights reserved.
//

#import "YPTableViewLoadMoreItem.h"

@implementation YPTableViewLoadMoreItem
@synthesize isLoading = _isLoading;
@synthesize title = _title;

+ (YPTableViewLoadMoreItem *)itemWithTitle:(NSString *)title
{
	YPTableViewLoadMoreItem *item = [[[YPTableViewLoadMoreItem alloc] init] autorelease];
	item.title = title;
	return item;
}

- (void)dealloc
{
    RELEASE(_title);
    [super dealloc];
}

@end
