//
//  YPDefines.h
//  SYPFrameWork
//
//  Created by sunyuping on 12-12-27.
//  Copyright (c) 2012年 sunyuping. All rights reserved.
//

#import <Foundation/Foundation.h>
#ifndef YYPDefines_h
#define YPDefines_h

#import <objc/runtime.h>
#import <execinfo.h>
#import <stdio.h>
#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <Availability.h>
#import <TargetConditionals.h>
#endif

#undef YP_TARGET_SIMULATOR
#undef YP_TARGET_IOS

#ifdef TARGET_IPHONE_SIMULATOR
#define YP_TARGET_SIMULATOR
#endif


#ifdef TARGET_OS_IPHONE
#define YP_TARGET_IOS
#endif

#define YP_ALWAYS_INLINE    __attribute__((always_inline))
#define YP_UNUSED_RESULT    __attribute__((warn_unused_result))
#ifdef __cplusplus
#define YPEXTERN		    extern "C" __attribute__((visibility ("default")))
#else
#define YPEXTERN	        extern __attribute__((visibility ("default")))
#endif

#define YPRelease(_object)   do {if (_object) {[_object release];}_object=nil;}while(0);

#define YPCFRelease(_object) do {if (_object!=NULL) {CFRelease(_object);}_object=NULL;}while(0);


#ifndef NULL
#define NULL nil
#endif

#define RELEASE(__POINTER) { if (nil != (__POINTER)) { CFRelease(__POINTER); __POINTER = nil; } }

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f \
alpha:(a)]

//默认多语言表
#define RS_CURRENT_LANGUAGE_TABLE  [[NSUserDefaults standardUserDefaults] objectForKey:@"LanguageSwtich"]?[[NSUserDefaults standardUserDefaults] objectForKey:@"LanguageSwtich"]:@"zh-Hans"

//系统当前语言
#define SYSTEM_NOW_LANGUAGE [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0]

//程序语言设置
#define RS_LANGUAGE_TYPE_SET(value)     [[NSUserDefaults standardUserDefaults] setValue:value forKey:@"LanguageSwtich"]






#endif
