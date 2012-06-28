//
//  SYPDefines.h
//  SYPFrameWork
//
//  Created by 玉平 孙 on 12-6-20.
//  Copyright (c) 2012年 RenRen.com. All rights reserved.
//

#ifndef SYPFrameWork_SYPDefines_h
#define SYPFrameWork_SYPDefines_h

#import <objc/runtime.h>
#import <execinfo.h>
#import <stdio.h>
#ifdef __OBJC__
    #import <UIKit/UIKit.h>
    #import <Foundation/Foundation.h>
    #import <Availability.h>
    #import <TargetConditionals.h>
#endif

#undef SYP_TARGET_SIMULATOR
#undef SYP_TARGET_IOS

#ifdef TARGET_IPHONE_SIMULATOR
#define SYP_TARGET_SIMULATOR
#endif


#ifdef TARGET_OS_IPHONE
#define SYP_TARGET_IOS
#endif

#ifdef __IPHONE_2_0
#define SYP_IPHONE_2_0         __IPHONE_2_0 //20000
#endif

#ifdef __IPHONE_2_1
#define SYP_IPHONE_2_1         __IPHONE_2_1 //20100
#endif

#ifdef __IPHONE_2_2
#define SYP_IPHONE_2_2         __IPHONE_2_2 //20200
#endif

#ifdef __IPHONE_3_0
#define SYP_IPHONE_3_0         __IPHONE_3_0 //30000
#endif

#ifdef __IPHONE_3_1
#define SYP_IPHONE_3_1         __IPHONE_3_1 //30100
#endif

#ifdef __IPHONE_3_2
#define SYP_IPHONE_3_2         __IPHONE_3_2 //30200
#endif

#ifdef __IPHONE_4_0
#define SYP_IPHONE_4_0         __IPHONE_4_0 //40000
#endif

#ifdef __IPHONE_4_1
#define SYP_IPHONE_4_1         __IPHONE_4_1 //40100
#endif

#ifdef __IPHONE_4_2
#define SYP_IPHONE_4_2         __IPHONE_4_2 //40200
#endif

#ifdef __IPHONE_4_3
#define SYP_IPHONE_4_3         __IPHONE_4_3 //40300
#endif

#ifdef __IPHONE_5_0
#define SYP_IPHONE_5_0         __IPHONE_5_0 //50000
#endif

#ifdef __IPHONE_NA
#define SYP_IPHONE_IPHONE_NA   __IPHONE_NA  //99999
#endif


#define SYP_ALWAYS_INLINE    __attribute__((always_inline))
#define SYP_UNUSED_RESULT    __attribute__((warn_unused_result))
#ifdef __cplusplus
#define SYPEXTERN		    extern "C" __attribute__((visibility ("default")))
#else
#define SYPEXTERN	        extern __attribute__((visibility ("default")))
#endif

#define SYPRelease(object)   do {if (object) {[object release];}object=nil;}while(0);

#define SYPCFRelease(object) do {if (object!=NULL) {CFRelease(object);}object=NULL;}while(0);


#ifndef NULL
#define NULL nil
#endif

#endif
