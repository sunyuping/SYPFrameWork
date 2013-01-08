//
//  YPDataSourceDemo.m
//  SYPProjectFrameWork
//
//  Created by sunyuping on 13-1-8.
//  Copyright (c) 2013年 sunyuping. All rights reserved.
//

#import "YPDataSourceDemo.h"
#import "YPCellDemo.h"

@implementation YPDataSourceDemo

-(id)init{
    self = [super init];
    if (self) {
        NSMutableArray *source = [NSMutableArray arrayWithCapacity:50];
        for (int i=0; i<50; i++) {
            YPTableViewSectionObject *firstSectionObj = [[[YPTableViewSectionObject alloc] init] autorelease];
            YPTableViewItem *tmp = [[[YPTableViewItem alloc] init] autorelease];
            tmp.userInfo = [NSString stringWithFormat:@"第%d个cell测试",i];
            for (int j=0; j<i; j++) {
                [firstSectionObj.items addObject:tmp];
            }
            [source addObject:firstSectionObj];
        }
        self.sections = source;
    }
    return self;
}
- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)object {
    return [YPCellDemo class];
}

@end
