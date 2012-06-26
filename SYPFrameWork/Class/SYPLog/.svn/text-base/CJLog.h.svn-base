//
//  CJLog.h
//  CJFrameWork
//
//  Created by liu ys on 11-11-9.
//  Copyright (c) 2011年 datou. All rights reserved.
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

#import "CJDefines.h"
#import "CJSingleton.h"
#import "CJFileHandle.h"
#import "CJFileManager.h"
#import "CJPathManager.h"

@interface CJLog : NSObject {
@private
    CJFileHandle* _fileHandle;
    NSDateFormatter* _dateFormatter;
    NSMutableString* _logString;
}
@property (nonatomic,assign,readonly) NSMutableString* logString;

+(CJLog*)defaultLog;
@end

CJEXTERN void CJLogWrite(const char* tag,const char* fileName,const char* functionName,int linenum,const char* format,...) ;
CJEXTERN void CJLogStack(void);
CJEXTERN void CJLogNSError(NSError* aError);

#define CJLOG_ON

#ifdef CJLOG_ON

#define CJLOGI(STRING,ARG...) do {CJLogWrite("INFO",__FILE__,__PRETTY_FUNCTION__,__LINE__,STRING,##ARG);}while(0);
#define CJLOGW(STRING,ARG...) do {CJLogWrite("WARRING",__FILE__,__PRETTY_FUNCTION__,__LINE__,STRING,##ARG);}while(0);
#define CJLOGE(STRING,ARG...) do {CJLogWrite("ERROR",__FILE__,__PRETTY_FUNCTION__,__LINE__,STRING,##ARG);CJLOG_STACK;}while(0);

#else

#define CJLOGI
#define CJLOGW
#define CJLOGE
#endif

#define CJLOG_STACK                       do{CJLogStack();}while(0);          

#define CJASSERT(condation,desc,...)      do{if((condation)==NO){CJLOGE(desc,##__VA_ARGS__);CJLOG_STACK;NSAssert(condation,[NSString stringWithUTF8String:desc],##__VA_ARGS__);}}while(0);

#define CJLOG_NSERROR(error)               do{if ((error)!=nil) {CJLogNSError(error);CJASSERT(0,"");}}while(0);
#define CJLOG_NULLPOINT(ptr)               do{if(ptr==nil){CJASSERT(0,"");}}while(0);
#define CJLOG_RETNULL(condition,desc,...)  do{if((condition)==NO){CJLOGE(desc,##__VA_ARGS__);return nil;}}while(0);
#define CJLOG_RETBOOL(condition,desc,...)  do{if((condition)==NO){CJLOGE(desc,##__VA_ARGS__);return NO ;}}while(0);
