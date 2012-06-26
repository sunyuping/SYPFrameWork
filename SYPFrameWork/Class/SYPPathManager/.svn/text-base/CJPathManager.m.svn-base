//
//  CJPathManager.m
//  CJFramework
//
//  Created by liu ys on 11-11-14.
//  Copyright (c) 2011年 datou. All rights reserved.
//

#import "CJPathManager.h"
#import "CJFileManager.h"
#import "CJLog.h"

CJ_DECLARE_SINGLETON(CJPathManager)
                         
@implementation CJPathManager

CJ_IMPLETEMENT_SINGLETON(CJPathManager,defaultPathManager)
-(id) init {
    CJLOG_NULLPOINT([super init]);
    NSArray* array = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory,NSUserDomainMask,YES);
    _rootPath = [array objectAtIndex:0];
    CJLOG_NULLPOINT(_rootPath);
    [_rootPath retain];    
    _fileManager = [CJFileManager defaultManager];
    CJLOG_NULLPOINT(_fileManager);
    [_fileManager replaceDirectoryAtPath:_rootPath];
    return self;    
}

-(void)dealloc{
    [_rootPath release];
    _fileManager =nil ;
    [super dealloc];
}
-(NSMutableString*) getLogPath {
    NSMutableString* logPath = [NSMutableString stringWithString:_rootPath];
    CJLOG_NULLPOINT(logPath);
    [logPath appendString:@"/CJLog"];
    [_fileManager replaceDirectoryAtPath:logPath];
    [logPath appendString:@"/"];
    return logPath;
}
-(NSMutableString*) getDatabasePath {
   return nil;
}
-(NSMutableString*) getCachePath {
    return nil;
}
-(NSMutableString*) getDownloadPath {
    return nil;
}
-(NSMutableString*) getApplicationPath {
    return nil;
}
-(NSMutableString*) getSystemVideoPath {
    return nil;    
}
-(NSMutableString*) getSystemAudioPath {
    return nil;    
}
-(NSMutableString*) getSystemPhotoPath {
    return nil;    
}
@end
