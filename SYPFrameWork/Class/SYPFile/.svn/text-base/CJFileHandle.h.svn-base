//
//  CJFileHandle.h
//  CJFramework
//
//  Created by liu ys on 11-11-15.
//  Copyright (c) 2011年 datou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJDefines.h"

typedef enum {
    CJFileReadMode     =1,
    CJFileWriteMode    =2,
    CJFileReadWriteMode=3
}TCJFileMode;

@class CJFileHandle;

@interface CJFileHandle : NSObject {
    NSFileHandle* _fileHandle ;
    TCJFileMode _fileMode;
}
@property (nonatomic,assign,readonly) NSFileHandle* fileHandle ;

+(CJFileHandle*) fileHandleCreateFile:(NSString*) path mode:(TCJFileMode) mode ;
+(CJFileHandle*) fileHandleOpenFile:(NSString*) path mode:(TCJFileMode) mode ;
+(CJFileHandle*) fileHandleReplaceFile:(NSString*) path mode:(TCJFileMode) mode ;

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
