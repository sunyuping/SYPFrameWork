//
//  CJDefines.h
//  CJFrameWork
//
//  Created by liu ys on 11-11-8.
//  Copyright (c) 2011年 datou. All rights reserved.
//

#ifndef CJFrameWork_CJDefines_h
#define CJFrameWork_CJDefines_h

#import <objc/runtime.h>
#import <execinfo.h>
#import <stdio.h>
#ifdef __OBJC__
    #import <UIKit/UIKit.h>
    #import <Foundation/Foundation.h>
    #import <Availability.h>
    #import <TargetConditionals.h>
#endif

#undef CJ_TARGET_SIMULATOR
#undef CJ_TARGET_IOS

#ifdef TARGET_IPHONE_SIMULATOR
#define CJ_TARGET_SIMULATOR
#endif


#ifdef TARGET_OS_IPHONE
#define CJ_TARGET_IOS
#endif

#ifdef __IPHONE_2_0
#define CJ_IPHONE_2_0         __IPHONE_2_0 //20000
#endif

#ifdef __IPHONE_2_1
#define CJ_IPHONE_2_1         __IPHONE_2_1 //20100
#endif

#ifdef __IPHONE_2_2
#define CJ_IPHONE_2_2         __IPHONE_2_2 //20200
#endif

#ifdef __IPHONE_3_0
#define CJ_IPHONE_3_0         __IPHONE_3_0 //30000
#endif

#ifdef __IPHONE_3_1
#define CJ_IPHONE_3_1         __IPHONE_3_1 //30100
#endif

#ifdef __IPHONE_3_2
#define CJ_IPHONE_3_2         __IPHONE_3_2 //30200
#endif

#ifdef __IPHONE_4_0
#define CJ_IPHONE_4_0         __IPHONE_4_0 //40000
#endif

#ifdef __IPHONE_4_1
#define CJ_IPHONE_4_1         __IPHONE_4_1 //40100
#endif

#ifdef __IPHONE_4_2
#define CJ_IPHONE_4_2         __IPHONE_4_2 //40200
#endif

#ifdef __IPHONE_4_3
#define CJ_IPHONE_4_3         __IPHONE_4_3 //40300
#endif

#ifdef __IPHONE_5_0
#define CJ_IPHONE_5_0         __IPHONE_5_0 //50000
#endif

#ifdef __IPHONE_NA
#define CJ_IPHONE_IPHONE_NA   __IPHONE_NA  //99999
#endif


#define CJ_ALWAYS_INLINE    __attribute__((always_inline))
#define CJ_UNUSED_RESULT    __attribute__((warn_unused_result))
#ifdef __cplusplus
#define CJEXTERN		    extern "C" __attribute__((visibility ("default")))
#else
#define CJEXTERN	        extern __attribute__((visibility ("default")))
#endif

#define CJRelease(object)   do {if (object) {[object release];}object=nil;}while(0);

#define CJCFRelease(object) do {if (object!=NULL) {CFRelease(object);}object=NULL;}while(0);


#ifndef NULL
#define NULL nil
#endif

#endif
