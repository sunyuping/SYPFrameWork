//
//  SYPFileHandle.m
//  SYPFramework
//
//  Created by 玉平 孙 on 12-6-20.
//  Copyright (c) 2012年 RenRen.com. All rights reserved.
//

#import "SYPFileHandle.h"
#import "SYPObejctCRuntime.h"
#import "SYPFileManager.h"
#import "SYPLog.h"

@interface SYPFileHandle(PrivateMethod)
-(id)initWithCreateFile:(NSString*)path mode:(TSYPFileMode)mode;
-(id)initWithOpenFile:(NSString*)path mode:(TSYPFileMode)mode;
-(id)initWithReplaceFile:(NSString*)path mode:(TSYPFileMode)mode;
-(id)internalCreateFile:(NSString*)path mode:(TSYPFileMode)mode;
-(void)dealloc ;
@end


@implementation SYPFileHandle

@synthesize fileHandle = _fileHandle;

+(SYPFileHandle*) fileHandleCreateFile:(NSString*) path mode:(TSYPFileMode) mode {
    SYPFileHandle* fileHandle =[[SYPFileHandle alloc] initWithCreateFile:path mode:mode];
    return [fileHandle autorelease];
}
+(SYPFileHandle*) fileHandleOpenFile:(NSString*) path mode:(TSYPFileMode) mode  {
    SYPFileHandle* fileHandle =[[SYPFileHandle alloc] initWithOpenFile:path mode:mode];
    return [fileHandle autorelease];
}
+(SYPFileHandle*) fileHandleReplaceFile:(NSString*) path mode:(TSYPFileMode) mode {
    SYPFileHandle* fileHandle =[[SYPFileHandle alloc] initWithReplaceFile:path mode:mode];
    return [fileHandle autorelease];
}
-(id)internalCreateFile:(NSString*)path mode:(TSYPFileMode)mode {
    if (mode==SYPFileReadMode) {
        return [NSFileHandle fileHandleForReadingAtPath:path];
    }
    else if (mode==SYPFileWriteMode) {
        return [NSFileHandle fileHandleForWritingAtPath:path];
    }
    else if (mode==SYPFileReadWriteMode) {
        return [NSFileHandle fileHandleForUpdatingAtPath:path];
    }
    
    _fileMode = mode;
    return nil;
}
-(id)initWithCreateFile:(NSString*)path mode:(TSYPFileMode) mode {
    SYPFileManager* fileManager = [SYPFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path] == YES) {
        SYPASSERT(0,"FILE EXISTS");
    }
    SYPLOG_NULLPOINT([super init]);
    if([fileManager createEmptyFileAtPath:path]==NO){
        SYPASSERT(0,"FILE CREATE FAILED");
    }
    _fileHandle = [self internalCreateFile:path mode:mode];
    SYPLOG_NULLPOINT(_fileHandle);
    [_fileHandle retain];
    return self;
}

-(id)initWithOpenFile:(NSString*)path mode:(TSYPFileMode) mode {
    if ([[SYPFileManager defaultManager] fileExistsAtPath:path] == NO) {
        SYPASSERT(0,"FILE NO EXISTS");
    }
    SYPLOG_NULLPOINT([super init]);
    _fileHandle = [self internalCreateFile:path mode:mode];
    SYPLOG_NULLPOINT(_fileHandle);
    [_fileHandle retain];
    return self;
        
}
-(id)initWithReplaceFile:(NSString*)path mode:(TSYPFileMode) mode {
    if ([[SYPFileManager defaultManager] fileExistsAtPath:path] == NO) {
        SYPASSERT([[SYPFileManager defaultManager] createEmptyFileAtPath:path],"");
    }
    SYPLOG_NULLPOINT([super init]);
    _fileHandle = [self internalCreateFile:path mode:mode];
    SYPLOG_NULLPOINT(_fileHandle);
    [_fileHandle retain];
    [_fileHandle truncateFileAtOffset:0];
    return self;
}
-(void)dealloc {
    [self closeFile];
    SYPRelease(_fileHandle);
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
    SYPLOG_NULLPOINT(data);
    [_fileHandle writeData:data];
}
-(void)writeData:(const void *)bytes length:(NSUInteger)length {
    SYPLOG_NULLPOINT(bytes);
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
