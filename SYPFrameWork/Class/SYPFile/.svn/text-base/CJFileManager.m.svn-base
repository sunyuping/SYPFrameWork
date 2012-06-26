//
//  CJFileManager.m
//  CJFramework
//
//  Created by liu ys on 11-11-15.
//  Copyright (c) 2011年 datou. All rights reserved.
//

#import "CJFileManager.h"
#import "CJLog.h"

CJ_DECLARE_SINGLETON(CJFileManager)

@implementation CJFileManager

@synthesize fileManager = _fileManager;

CJ_IMPLETEMENT_SINGLETON(CJFileManager,defaultManager)

-(id) init {
    CJLOG_NULLPOINT([super init]);
    _fileManager = [NSFileManager defaultManager];
    CJLOG_NULLPOINT(_fileManager);
    return self;    
}
-(void)dealloc{
    _fileManager = nil ;
    [super dealloc];
}
- (BOOL)createDirectoryAtPath:(NSString*) path  {
    NSError* error =nil;
    BOOL result = [_fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
    CJLOG_NSERROR(error);
    return result ;
}
- (BOOL)replaceDirectoryAtPath:(NSString*)path {
    if (![self directoryExistsAtPath:path]) {
        return [self createDirectoryAtPath:path];
    }
    return YES;
}
- (BOOL)setAttributes:(NSDictionary *)attributes ofItemAtPath:(NSString *)path {
    NSError* error =nil;
    BOOL result = [_fileManager setAttributes:attributes ofItemAtPath:path error:&error];
    CJLOG_NSERROR(error);
    return result ;
}
- (NSDictionary *)attributesOfItemAtPath:(NSString *)path {
    NSError* error =nil;
    NSDictionary* result = [_fileManager attributesOfItemAtPath:path error:&error];
    CJLOG_NSERROR(error);
    return result;
}
- (BOOL)copyItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath {
    NSError* error =nil;
    BOOL result = [_fileManager copyItemAtPath:srcPath toPath:dstPath error:&error];
    CJLOG_NSERROR(error);
    return result ;
}
- (BOOL)moveItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath {
    NSError* error =nil;
    BOOL result = [_fileManager moveItemAtPath:srcPath toPath:dstPath error:&error];
    CJLOG_NSERROR(error);
    return result ;    
}
- (BOOL)linkItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath {
    NSError* error =nil;
    BOOL result = [_fileManager linkItemAtPath:srcPath toPath:dstPath error:&error];
    return result ;
}
- (BOOL)removeItemAtPath:(NSString *)path  {
    NSError* error =nil;
    BOOL result = [_fileManager removeItemAtPath:path error:&error];
    CJLOG_NSERROR(error);
    return result ;
}
- (BOOL)fileExistsAtPath:(NSString *)path {
    return [_fileManager fileExistsAtPath:path];
}
- (BOOL)directoryExistsAtPath:(NSString *)path {
    BOOL isDirectory =NO;
    BOOL result = [_fileManager fileExistsAtPath:path isDirectory:&isDirectory];
    return isDirectory && result ;
}
- (BOOL)isReadableFileAtPath:(NSString *)path {
    return [_fileManager isReadableFileAtPath:path];
}
- (BOOL)isWritableFileAtPath:(NSString *)path {
    return [_fileManager isWritableFileAtPath:path];
}
- (BOOL)isExecutableFileAtPath:(NSString *)path {
    return [_fileManager isExecutableFileAtPath:path];
}
- (BOOL)isDeletableFileAtPath:(NSString *)path {
    return [_fileManager isDeletableFileAtPath:path];
}
- (NSString *)displayNameAtPath:(NSString *)path{
     return [_fileManager displayNameAtPath:path];
}
- (NSData *)contentsAtPath:(NSString *)path {
    return [_fileManager contentsAtPath:path];
}
- (NSUInteger)sizeAtPath:(NSString *)path {
    return [[self attributesOfItemAtPath:path] fileSize];
}

- (BOOL)createEmptyFileAtPath:(NSString *)path {
    return [_fileManager createFileAtPath:path contents:nil attributes:nil];
}
- (BOOL)createFileAtPath:(NSString *)path contents:(NSData *)data {
    return [_fileManager createFileAtPath:path contents:data attributes:nil];
}

@end
