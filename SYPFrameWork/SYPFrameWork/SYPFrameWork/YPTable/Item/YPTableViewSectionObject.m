//
//  YPSectionObject.m
//  SYPFrameWork
//
//  Created by sunyuping on 13-1-8.
//  Copyright (c) 2013年 sunyuping. All rights reserved.
//

#import "YPTableViewSectionObject.h"

@implementation YPTableViewSectionObject
@synthesize letter = _letter;
@synthesize title = _title;
@synthesize userInfo = _userInfo;
@synthesize items = _items;
@synthesize footerTitle = _footerTitle;

- (void)dealloc{
    self.letter = nil;
    self.title = nil;
    self.userInfo = nil;
    self.items = nil;
    self.footerTitle = nil;
    [super dealloc];
}
// 初始化一发
- (NSMutableArray *)items
{
    if (!_items)
    {
        _items = [[NSMutableArray alloc] init];
    }
    return _items;
}
@end
