//
//  SYPPathManager.m
//  SYPFramework
//
//  Created by 玉平 孙 on 12-6-20.
//  Copyright (c) 2012年 RenRen.com. All rights reserved.
//

#import "SYPPathManager.h"
#import "SYPFileManager.h"
#import "SYPLog.h"

SYP_DECLARE_SINGLETON(SYPPathManager)
                         
@implementation SYPPathManager

SYP_IMPLETEMENT_SINGLETON(SYPPathManager,defaultPathManager)
-(id) init {
    SYPLOG_NULLPOINT([super init]);
    NSArray* array = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory,NSUserDomainMask,YES);
    _rootPath = [array objectAtIndex:0];
    SYPLOG_NULLPOINT(_rootPath);
    [_rootPath retain];    
    _fileManager = [SYPFileManager defaultManager];
    SYPLOG_NULLPOINT(_fileManager);
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
    SYPLOG_NULLPOINT(logPath);
    [logPath appendString:@"/SYPLog"];
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
