//
//  NSData+SYPFramework.h
//  SYPFramework
//
//  Created by 玉平 孙 on 12-6-29.
//  Copyright (c) 2012年 RenRen.com. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSData (SYPFramework)
-(NSData*) SYP_compressFromZlib;
-(NSData*) SYP_decompressFromZlib;
@end
