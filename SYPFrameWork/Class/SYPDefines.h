//
//  SYPDefines.h
//  SYPFrameWork
//
//  Created by 玉平 孙 on 12-6-29.
//  Copyright (c) 2012年 RenRen.com. All rights reserved.
//

#ifndef SYPFrameWork_SYPDefines_h
#define SYPFrameWork_SYPDefines_h

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
