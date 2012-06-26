//
//  SYPLog.h
//  SYPFrameWork
//
//  Created by 玉平 孙 on 12-6-20.
//  Copyright (c) 2012年 RenRen.com. All rights reserved.
//

/*!
 For debugging:
 Go into the "Get Info" contextual menu of your (test) executable (inside the "Executables" group in the left panel of XCode). 
 Then go in the "Arguments" tab. You can add the following environment variables:
 
 Default:   Set to:
 ç                        NO       "YES"
 NSZombieEnabled                       NO       "YES"
 NSDeallocateZombies                   NO       "YES"
 NSHangOnUncaughtException             NO       "YES"
 
 NSEnableAutoreleasePool              YES       "NO"
 NSAutoreleaseFreedObjectCheckEnabled  NO       "YES"
 NSAutoreleaseHighWaterMark             0       non-negative integer
 NSAutoreleaseHighWaterResolution       0       non-negative integer
 
 For info on these varaiables see NSDebug.h; http://theshadow.uw.hu/iPhoneSDKdoc/Foundation.framework/NSDebug.h.html
 
 For malloc debugging see: http://developer.apple.com/mac/library/documentation/Performance/Conceptual/ManagingMemory/Articles/MallocDebug.html
 */

#import "SYPDefines.h"
#import "SYPSingleton.h"
#import "SYPFileHandle.h"
#import "SYPFileManager.h"
#import "SYPPathManager.h"

@interface SYPLog : NSObject {
@private
    SYPFileHandle* _fileHandle;
    NSDateFormatter* _dateFormatter;
    NSMutableString* _logString;
}
@property (nonatomic,assign,readonly) NSMutableString* logString;

+(SYPLog*)defaultLog;
@end

SYPEXTERN void SYPLogWrite(const char* tag,const char* fileName,const char* functionName,int linenum,const char* format,...) ;
SYPEXTERN void SYPLogStack(void);
SYPEXTERN void SYPLogNSError(NSError* aError);

#define SYPLOG_ON

#ifdef SYPLOG_ON

#define SYPLOGI(STRING,ARG...) do {SYPLogWrite("INFO",__FILE__,__PRETTY_FUNCTION__,__LINE__,STRING,##ARG);}while(0);
#define SYPLOGW(STRING,ARG...) do {SYPLogWrite("WARRING",__FILE__,__PRETTY_FUNCTION__,__LINE__,STRING,##ARG);}while(0);
#define SYPLOGE(STRING,ARG...) do {SYPLogWrite("ERROR",__FILE__,__PRETTY_FUNCTION__,__LINE__,STRING,##ARG);SYPLOG_STACK;}while(0);

#else

#define SYPLOGI
#define SYPLOGW
#define SYPLOGE
#endif

#define SYPLOG_STACK                       do{SYPLogStack();}while(0);          

#define SYPASSERT(condation,desc,...)      do{if((condation)==NO){SYPLOGE(desc,##__VA_ARGS__);SYPLOG_STACK;NSAssert(condation,[NSString stringWithUTF8String:desc],##__VA_ARGS__);}}while(0);

#define SYPLOG_NSERROR(error)               do{if ((error)!=nil) {SYPLogNSError(error);SYPASSERT(0,"");}}while(0);
#define SYPLOG_NULLPOINT(ptr)               do{if(ptr==nil){SYPASSERT(0,"");}}while(0);
#define SYPLOG_RETNULL(condition,desc,...)  do{if((condition)==NO){SYPLOGE(desc,##__VA_ARGS__);return nil;}}while(0);
#define SYPLOG_RETBOOL(condition,desc,...)  do{if((condition)==NO){SYPLOGE(desc,##__VA_ARGS__);return NO ;}}while(0);
