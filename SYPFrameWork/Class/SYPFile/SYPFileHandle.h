//
//  SYPFileHandle.h
//  SYPFramework
//
//  Created by 玉平 孙 on 12-6-20.
//  Copyright (c) 2012年 RenRen.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYPDefines.h"

typedef enum {
    SYPFileReadMode     =1,
    SYPFileWriteMode    =2,
    SYPFileReadWriteMode=3
}TSYPFileMode;

@class SYPFileHandle;

@interface SYPFileHandle : NSObject {
    NSFileHandle* _fileHandle ;
    TSYPFileMode _fileMode;
}
@property (nonatomic,assign,readonly) NSFileHandle* fileHandle ;

+(SYPFileHandle*) fileHandleCreateFile:(NSString*) path mode:(TSYPFileMode) mode ;
+(SYPFileHandle*) fileHandleOpenFile:(NSString*) path mode:(TSYPFileMode) mode ;
+(SYPFileHandle*) fileHandleReplaceFile:(NSString*) path mode:(TSYPFileMode) mode ;

-(NSUInteger)fileSize;
-(NSData *)readDataOfLength:(NSUInteger)length;
-(void)writeData:(NSData *)data;
-(void)writeData:(const void *)bytes length:(NSUInteger)length; 
-(unsigned long long)offsetInFile;
-(unsigned long long)seekToEndOfFile;
-(void)seekToFileOffset:(unsigned long long)offset;
-(NSData *)availableData;
/*
 截断或者增加文件大小
 */
-(void)truncateFileAtOffset:(unsigned long long)offset;
-(void)synchronizeFile;
-(void)closeFile;

@end
