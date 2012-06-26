//
//  CJUtility.h
//  CJFramework
//
//  Created by liu ys on 11-11-16.
//  Copyright (c) 2011年 datou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CJLog.h"
#import "CJSingleton.h"

@interface CJUtility : NSObject
+(CJUtility*) defaultUtility;

//屏幕相关
+ (NSInteger) getScreenWidth;
+ (NSInteger) getScreenHeight;
+ (NSInteger) getApplicationWidth;
+ (NSInteger) getApplicationHeight;

//硬件相关
+ (NSUInteger) getCPUFrequency;
+ (NSUInteger) getBUSFrequency;
+ (NSUInteger) getTotalMemory;
+ (NSUInteger) getUserMemory;
+ (NSUInteger) getMaxSocketBufferSize;

//网络相关
+ (NSString *) getlocalWiFiIPAddress;
+ (NSString *) hostname;
+ (NSString *) getIPAddressForHost:(NSString *)theHost;
+ (NSString *) localIPAddress;

//系统相关
+ (NSString*) getUniqueIdentifer;
+ (NSString*) getModel;
+ (NSString*) getSystemName;
+ (NSString*) getSystemVersion;
+ (CGFloat) getDiskFreeSize;
+ (CGFloat) getDiskTotalSize;
+ (CGFloat) getBatteryValue;
+ (NSInteger) getBatteryState;
+ (NSString *) getPlatform;
+ (NSString *) getPlatformString;
@end
