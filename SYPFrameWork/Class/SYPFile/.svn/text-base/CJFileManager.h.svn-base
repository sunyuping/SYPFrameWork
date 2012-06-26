//
//  CJFileManager.h
//  CJFramework
//
//  Created by liu ys on 11-11-15.
//  Copyright (c) 2011年 datou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJDefines.h"
#import "CJSingleton.h"

@interface CJFileManager : NSObject {
    NSFileManager* _fileManager ;
}
@property (nonatomic,assign,readonly) NSFileManager* fileManager ;

+(CJFileManager*)defaultManager;

- (BOOL)createDirectoryAtPath:(NSString*)path;
/**
 如果路经存在 则不用创建
 */
- (BOOL)replaceDirectoryAtPath:(NSString*)path;
- (BOOL)setAttributes:(NSDictionary *)attributes ofItemAtPath:(NSString *)path ;
- (NSDictionary *)attributesOfItemAtPath:(NSString *)path;

- (BOOL)copyItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath;
- (BOOL)moveItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath;
- (BOOL)linkItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath;
- (BOOL)removeItemAtPath:(NSString *)path ;

- (BOOL)fileExistsAtPath:(NSString *)path;
- (BOOL)directoryExistsAtPath:(NSString *)path;
- (BOOL)isReadableFileAtPath:(NSString *)path;
- (BOOL)isWritableFileAtPath:(NSString *)path;
- (BOOL)isExecutableFileAtPath:(NSString *)path;
- (BOOL)isDeletableFileAtPath:(NSString *)path;

- (NSString *)displayNameAtPath:(NSString *)path;
- (NSData *)contentsAtPath:(NSString *)path;
- (NSUInteger)sizeAtPath:(NSString *)path;
- (BOOL)createEmptyFileAtPath:(NSString *)path;
- (BOOL)createFileAtPath:(NSString *)path contents:(NSData *)data;
@end
