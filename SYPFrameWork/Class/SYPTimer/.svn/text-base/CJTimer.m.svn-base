//
//  CJTimer.m
//  CJFramework
//
//  Created by liu ys on 11-11-10.
//  Copyright (c) 2011年 datou. All rights reserved.
//

#import "CJTimer.h"

//CJTimer(PrivateMethod) 为 object－c 中 catagroy 语法
@interface CJTimer(PrivateMethod)

// from NSTime fire method
-(void)internalTimeFireMethod:(NSTimer*) timer;
-(void)dealloc ;
@end


@implementation CJTimer

@synthesize timer     = _timer;
@dynamic timeInterval;
@synthesize repeats   = _repeats;
@synthesize userInfo  =_userInfo;

-(void)setTimeInterval:(NSTimeInterval)timeInterval {
    [self stop];
    _timeInterval = timeInterval;
}
-(NSTimeInterval)getTimeInterval {
    return _timeInterval;
}
-(BOOL)isRepeats {
    return _repeats;
}
-(void)mySetUserInfo:(id)userInfo {
    [self stop];
    _userInfo = userInfo;
}

+(CJTimer*) timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo {
    CJTimer* timer = [[CJTimer alloc] initWithTimeInterval:ti target:aTarget selector:aSelector userInfo:userInfo repeats:yesOrNo];
    return [timer autorelease];
}

+(CJTimer*) timerWithTimeInterval:(NSTimeInterval)ti protocol:(id<CJTimerProtocol>)protocol  userInfo:(id)userInfo repeats:(BOOL)yesOrNo {
    CJTimer* timer = [[CJTimer alloc] initWithTimeInterval:ti protocol:protocol userInfo:userInfo repeats:yesOrNo];
    return [timer autorelease];
    
}
-(CJTimer*)initWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo  {
    
    _timeInterval = ti ;
    _target       = aTarget ;
    _selector     = aSelector ;
    _userInfo     = userInfo ;
    _repeats      = yesOrNo ;
    return self;
}

-(CJTimer*)initWithTimeInterval:(NSTimeInterval)ti protocol:(id<CJTimerProtocol>)protocol  userInfo:(id)userInfo repeats:(BOOL)yesOrNo {
    
    _timeInterval  =ti ;
    _timerProtocol =protocol;
    _userInfo     = userInfo ;
    _repeats      = yesOrNo ;
    return self;
}

-(void)internalTimeFireMethod:(NSTimer*) timer{
    if (_timerProtocol) {
        [_timerProtocol TimerFire:self userInfo:_userInfo];
    }
    else if (_target && [_target respondsToSelector:_selector]==YES) {
        [_target performSelector:_selector withObject:self withObject:_userInfo];
    }
    else{
        //assert(0);
    }
}
-(void)start {
    [self stop];
    _timer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval target:self selector:@selector(internalTimeFireMethod:) userInfo:_userInfo repeats:_repeats] ;
    [_timer retain];
}
-(void)stop {
    if (_timer) {
        [_timer invalidate];
        CJRelease(_timer);
    }
}

-(void)dealloc  {
    [self stop];
}
@end
