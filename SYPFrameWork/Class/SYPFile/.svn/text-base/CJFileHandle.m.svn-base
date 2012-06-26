//
//  CJFileHandle.m
//  CJFramework
//
//  Created by liu ys on 11-11-15.
//  Copyright (c) 2011年 datou. All rights reserved.
//

#import "CJFileHandle.h"
#import "CJObejctCRuntime.h"
#import "CJFileManager.h"
#import "CJLog.h"

@interface CJFileHandle(PrivateMethod)
-(id)initWithCreateFile:(NSString*)path mode:(TCJFileMode)mode;
-(id)initWithOpenFile:(NSString*)path mode:(TCJFileMode)mode;
-(id)initWithReplaceFile:(NSString*)path mode:(TCJFileMode)mode;
-(id)internalCreateFile:(NSString*)path mode:(TCJFileMode)mode;
-(void)dealloc ;
@end


@implementation CJFileHandle

@synthesize fileHandle = _fileHandle;

+(CJFileHandle*) fileHandleCreateFile:(NSString*) path mode:(TCJFileMode) mode {
    CJFileHandle* fileHandle =[[CJFileHandle alloc] initWithCreateFile:path mode:mode];
    return [fileHandle autorelease];
}
+(CJFileHandle*) fileHandleOpenFile:(NSString*) path mode:(TCJFileMode) mode  {
    CJFileHandle* fileHandle =[[CJFileHandle alloc] initWithOpenFile:path mode:mode];
    return [fileHandle autorelease];
}
+(CJFileHandle*) fileHandleReplaceFile:(NSString*) path mode:(TCJFileMode) mode {
    CJFileHandle* fileHandle =[[CJFileHandle alloc] initWithReplaceFile:path mode:mode];
    return [fileHandle autorelease];
}
-(id)internalCreateFile:(NSString*)path mode:(TCJFileMode)mode {
    if (mode==CJFileReadMode) {
        return [NSFileHandle fileHandleForReadingAtPath:path];
    }
    else if (mode==CJFileWriteMode) {
        return [NSFileHandle fileHandleForWritingAtPath:path];
    }
    else if (mode==CJFileReadWriteMode) {
        return [NSFileHandle fileHandleForUpdatingAtPath:path];
    }
    
    _fileMode = mode;
    return nil;
}
-(id)initWithCreateFile:(NSString*)path mode:(TCJFileMode) mode {
    CJFileManager* fileManager = [CJFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path] == YES) {
        CJASSERT(0,"FILE EXISTS");
    }
    CJLOG_NULLPOINT([super init]);
    if([fileManager createEmptyFileAtPath:path]==NO){
        CJASSERT(0,"FILE CREATE FAILED");
    }
    _fileHandle = [self internalCreateFile:path mode:mode];
    CJLOG_NULLPOINT(_fileHandle);
    [_fileHandle retain];
    return self;
}

-(id)initWithOpenFile:(NSString*)path mode:(TCJFileMode) mode {
    if ([[CJFileManager defaultManager] fileExistsAtPath:path] == NO) {
        CJASSERT(0,"FILE NO EXISTS");
    }
    CJLOG_NULLPOINT([super init]);
    _fileHandle = [self internalCreateFile:path mode:mode];
    CJLOG_NULLPOINT(_fileHandle);
    [_fileHandle retain];
    return self;
        
}
-(id)initWithReplaceFile:(NSString*)path mode:(TCJFileMode) mode {
    if ([[CJFileManager defaultManager] fileExistsAtPath:path] == NO) {
        CJASSERT([[CJFileManager defaultManager] createEmptyFileAtPath:path],"");
    }
    CJLOG_NULLPOINT([super init]);
    _fileHandle = [self internalCreateFile:path mode:mode];
    CJLOG_NULLPOINT(_fileHandle);
    [_fileHandle retain];
    [_fileHandle truncateFileAtOffset:0];
    return self;
}
-(void)dealloc {
    [self closeFile];
    CJRelease(_fileHandle);
}
-(NSUInteger)fileSize {
    NSUInteger pos = [self offsetInFile];
    [self seekToFileOffset:0];
    NSUInteger size = [self seekToEndOfFile] ;
    [self seekToFileOffset:pos];
    return size;
}
-(NSData *)readDataOfLength:(NSUInteger)length {
    return [_fileHandle readDataOfLength:length];
}
-(void)writeData:(NSData *)data {
    CJLOG_NULLPOINT(data);
    [_fileHandle writeData:data];
}
-(void)writeData:(const void *)bytes length:(NSUInteger)length {
    CJLOG_NULLPOINT(bytes);
    [_fileHandle writeData:[NSData dataWithBytesNoCopy:(void *)bytes length:length]];
}
-(unsigned long long)offsetInFile {
    return [_fileHandle offsetInFile];
}
-(unsigned long long)seekToEndOfFile {
    return [_fileHandle seekToEndOfFile];
}
-(void)seekToFileOffset:(unsigned long long)offset {
    [_fileHandle seekToFileOffset:offset];
}
-(NSData *)availableData {
    return [_fileHandle availableData];
}
/*
 截断或者增加文件大小
 */
-(void)truncateFileAtOffset:(unsigned long long)offset {
    [_fileHandle truncateFileAtOffset:offset];
}
-(void)synchronizeFile {
    [_fileHandle synchronizeFile]; 
}
-(void)closeFile {
    [_fileHandle closeFile];
}
@end
