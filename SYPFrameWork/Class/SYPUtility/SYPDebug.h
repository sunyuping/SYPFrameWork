//
//  SYPDebug.h
//  SYPFramework
//
//  Created by 玉平 孙 on 12-6-20.
//  Copyright (c) 2012年 RenRen.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYPDefines.h"


@interface SYPDebug : NSObject {
}
+(void)loadDebugSymbol;
+(NSString*)lookupFunction:(unsigned int) address backtrace:(const char*)backtrace ;
@end


