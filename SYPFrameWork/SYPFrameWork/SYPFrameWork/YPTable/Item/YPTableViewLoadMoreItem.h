//
//  YPTableViewLoadMoreItem.h
//  SYPFrameWork
//
//  Created by sunyuping on 13-1-8.
//  Copyright (c) 2013年 sunyuping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YPTableViewItem.h"
@interface YPTableViewLoadMoreItem : YPTableViewItem


@property (nonatomic, assign)         BOOL	isLoading;
@property (nonatomic, retain) NSString		*title;

+ (YPTableViewLoadMoreItem *)itemWithTitle:(NSString *)title;

@end
