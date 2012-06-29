//
//  NSString+SYPFramework.h
//  SYPFrameWork
//
//  Created by 玉平 孙 on 12-6-29.
//  Copyright (c) 2012年 RenRen.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SYPFramework1)
+(NSString*) syp_stringWithCString:(const char *)bytes;
+(NSString*) SYP_stringWithCString:(const char *)bytes length:(NSUInteger)length;
-(NSString*) SYP_stringFromMD5;
+(NSString*) SYP_TEST;
@end
