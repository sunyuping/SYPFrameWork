//
//  SYPException.h
//  SYPFramework
//
//  Created by 玉平 孙 on 12-6-20.
//  Copyright (c) 2012年 RenRen.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYPSingleton.h"

@protocol SYPExceptionProtocol <NSObject>
@required
    -(BOOL)ExceptionHandle:(NSException*)e ; 
@end

@interface SYPException : NSObject {
    id<SYPExceptionProtocol> _delegate;
    NSUncaughtExceptionHandler* _oldHandle;
}
@property (nonatomic,assign) id<SYPExceptionProtocol> delegate;
@property (nonatomic,assign,readonly) NSUncaughtExceptionHandler* oldHandle;
+(SYPException*) defaultException;
@end
