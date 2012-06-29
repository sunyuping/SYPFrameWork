//
//  NSData+SYPFramework.m
//  SYPFramework
//
//  Created by 玉平 孙 on 12-6-29.
//  Copyright (c) 2012年 RenRen.com. All rights reserved.
//

#import "NSData+SYPFramework.h"
#import "zlib.h"
#import "SYPLog.h"

@implementation NSData (SYPFramework)
-(NSData*) SYP_compressFromZlib {
    NSUInteger len = [self length];
    Bytef* byteData = (Bytef*)[self bytes];
    SYPLOG_RETNULL(byteData != NULL, "self bytes return NULL = %u",len);
    uLongf destLen = (len+12)*1.01+1;
    NSMutableData* dest = [[[NSMutableData alloc]initWithLength:destLen]autorelease];
    SYPLOG_RETNULL(dest != NULL, "init error destLen = %d",destLen);
    int error = compress((Bytef*)[dest bytes], &destLen, byteData, len);
    SYPLOG_RETNULL(dest != NULL, "compress error error = %d",error);
    [dest setLength:destLen];
    return dest; 
}
-(NSData*) SYP_decompressFromZlib {
#define OUTSIZE 128
    z_stream inflateStream ;
    inflateStream.next_in = (Bytef*)[self bytes];
    inflateStream.avail_in= [self length];
    inflateStream.zalloc  = 0;
    inflateStream.zfree   = 0;
    inflateStream.opaque  = 0;    
    
    int ret = inflateInit(&inflateStream);
    SYPLOG_RETNULL(ret == Z_OK, "inflateInit error = %d",ret);
    
    NSMutableData* targetData = [[[NSMutableData alloc] initWithLength:OUTSIZE]autorelease];
    SYPLOG_RETNULL(targetData != NULL, "init error OUTSIZE = %d",OUTSIZE);
    int outlength = 0;
    while (1==1) {
        inflateStream.next_out  =[targetData mutableBytes]+outlength;
        inflateStream.avail_out = OUTSIZE;
        int err =inflate(&inflateStream,Z_NO_FLUSH);
        if ( (err == Z_STREAM_END) || (inflateStream.avail_in <= 0) ) {
            [targetData setLength:inflateStream.total_out];
            SYPLOGI("data Lengteh = %d",[targetData length]);
            break ;
        }
        else if(err != Z_OK){
            SYPLOGE("inflate error = %d", err);
            return nil;
        }
        outlength += OUTSIZE ;
        [targetData increaseLengthBy:OUTSIZE];
    }
    ret = inflateEnd(&inflateStream);
    SYPLOG_RETNULL(ret == Z_OK, "inflateEnd error = %d",ret);
    return targetData;
}
@end

