//
//  NSString+SYPFramework.h
//  SYPFramework
//
//  Created by 玉平 孙 on 12-6-20.
//  Copyright (c) 2012年 RenRen.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SYPFrameWork)
+(NSString*) SYP_stringWithCString:(const char *)bytes;
+(NSString*) SYP_stringWithCString:(const char *)bytes length:(NSUInteger)length;
-(NSString*) SYP_stringFromMD5;
@end
