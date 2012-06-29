//
//  SYPFrameWork.m
//  SYPFrameWork
//
//  Created by 玉平 孙 on 12-6-20.
//  Copyright (c) 2012年 RenRen.com. All rights reserved.
//

#import "SYPFrameWork.h"
#import "SYPLog.h"
@implementation SYPFrameWork
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)TestShow
{
    NSLog(@"TestFramework");
    SYPLOGI("1111====%D", 12);
}
@end
