//
//  SYPObejctCRuntime.h
//  SYPFramework
//
//  Created by 玉平 孙 on 12-6-20.
//  Copyright (c) 2012年 RenRen.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYPDefines.h"

@interface SYPObejctCRuntime : NSObject
+(void)displayIvarList:(id)obj;
+(void)displayPropertyList:(id)obj;
+(void)displayMethodList:(id)obj;
+(void)displayProtocolList:(id)obj;
+(id)objectgetIvar:(id)obj name:(const char *)name;
@end
