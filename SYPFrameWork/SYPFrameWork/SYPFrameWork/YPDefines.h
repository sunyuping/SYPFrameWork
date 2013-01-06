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

#define YPRelease(object)   do {if (object) {[object release];}object=nil;}while(0);

#define YPCFRelease(object) do {if (object!=NULL) {CFRelease(object);}object=NULL;}while(0);


#ifndef NULL
#define NULL nil
#endif

#endif
