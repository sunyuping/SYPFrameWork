//
//  SYPLog.m
//  SYPFrameWork
//
//  Created by 玉平 孙 on 12-6-29.
//  Copyright (c) 2012年 RenRen.com. All rights reserved.
//

#import "SYPLog.h"
#import <execinfo.h>
#import "NSString+SYPFramework.h"


SYP_DECLARE_SINGLETON(SYPLog)


@implementation SYPLog

@synthesize logString = _logString;

SYP_IMPLETEMENT_SINGLETON(SYPLog,defaultLog)

-(id) init {
    [super init];
    //NSMutableString* logFile = [[SYPPathManager defaultPathManager] getLogPath];
    //[logFile appendString:@"log.log"];
    //_fileHandle = [SYPFileHandle fileHandleReplaceFile:logFile mode:SYPFileWriteMode];
    //[_fileHandle retain];

    _logString = [NSMutableString stringWithCapacity:1024];
    [_logString retain];

    _dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:MM:SS"];

    return self;
}
-(void)dealloc {
    SYPRelease(_dateFormatter);
    SYPRelease(_logString);
    [super dealloc];
//    SYPRelease(_fileHandle);                
}

-(void)write:(const char*)tag fileName:(const char*) filename functionName:(const char*) functionName lineNum:(int)lineNum format:(const char*)format arg:(va_list) arg{
    NSLog(@"wrie=====start=%s",tag);
    [_logString setString:@" "];
    NSLog(@"wrie=====_logString=%@",_logString);
    [NSString SYP_TEST];
    [_logString appendString:[NSString stringWithCString:tag encoding:NSUTF8StringEncoding]];//[NSString SYP_stringWithCString:tag]];
    [_logString appendString:@" "];
    NSLog(@"wrie=====11111");
    CFStringAppendFormatAndArguments((CFMutableStringRef)_logString,NULL,(CFStringRef)[NSString syp_stringWithCString:format],arg);
    NSLog(@"wrie=====22222");
    if (!(filename==NULL || functionName==NULL)) {
        [_logString appendString:@"\r\n"];
        [_logString appendFormat:@"filename =%s function =%s line =%d",filename,functionName,lineNum];
        [_logString appendString:@"\r\n"];
    }
    NSLog(@"%@",_logString);
    NSDate* currentDate = [NSDate dateWithTimeIntervalSinceNow:0];
    [_logString insertString:[_dateFormatter stringFromDate:currentDate] atIndex:0];
//    [_fileHandle writeData:[_logString UTF8String] length:[_logString length]];
}
-(void)writeStack:(char**) strs callstack:(unsigned int*)callstack count:(int)count {
    [_logString setString:@" "];
    [_logString appendString:@" ERROR STACK \r\n"];
    for(int i = 1;i<count;i++) {
        [_logString appendFormat:@"%s \r\n",strs[i]];
    }
    NSLog(@"%@",_logString);
    
    NSDate* currentDate = [NSDate dateWithTimeIntervalSinceNow:0];
    [_logString insertString:[_dateFormatter stringFromDate:currentDate] atIndex:0];
//    [_fileHandle writeData:[_logString UTF8String] length:[_logString length]];
}
-(void)writeNSError:(NSError*) aError{
    [_logString setString:@" "];
    [_logString appendString:[aError description]];
    [_logString appendString:@"\r\n"];
    
    NSLog(@"%@",_logString);
    NSDate* currentDate = [NSDate dateWithTimeIntervalSinceNow:0];
    [_logString insertString:[_dateFormatter stringFromDate:currentDate] atIndex:0];
//    [_fileHandle writeData:[_logString UTF8String] length:[_logString length]];
}
@end

void SYPLogWrite(const char* tag,const char* fileName,const char* functionName,int linenum,const char* format,...) {
    NSLock* lock = [[NSLock alloc] init];
    [lock lock];
    va_list argList;
    va_start(argList, format);
    [[SYPLog defaultLog] write:tag fileName:fileName functionName:functionName lineNum:linenum format:format arg:argList];
    va_end(argList);
    [lock unlock];
    SYPRelease(lock);
}
void SYPLogStack(void) {
    NSLock* lock = [[NSLock alloc] init];
    [lock lock];
    void* callstack[128];
    int frames = backtrace(callstack, 128);
    char** strs = backtrace_symbols(callstack, frames);
    [[SYPLog defaultLog] writeStack:strs callstack:(unsigned int*)callstack count:frames];
    free(strs);
    [lock unlock];
    SYPRelease(lock);
}
void SYPLogNSError(NSError* aError) {
    NSLock* lock = [[NSLock alloc] init];
    [lock lock];
    [[SYPLog defaultLog] writeNSError:aError];
    [lock unlock];
    SYPRelease(lock);
}