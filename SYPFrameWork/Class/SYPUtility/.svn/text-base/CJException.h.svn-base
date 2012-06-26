//
//  CJException.h
//  CJFramework
//
//  Created by liu ys on 11-11-18.
//  Copyright (c) 2011年 datou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJSingleton.h"

@protocol CJExceptionProtocol <NSObject>
@required
    -(BOOL)ExceptionHandle:(NSException*)e ; 
@end

@interface CJException : NSObject {
    id<CJExceptionProtocol> _delegate;
    NSUncaughtExceptionHandler* _oldHandle;
}
@property (nonatomic,assign) id<CJExceptionProtocol> delegate;
@property (nonatomic,assign,readonly) NSUncaughtExceptionHandler* oldHandle;
+(CJException*) defaultException;
@end
