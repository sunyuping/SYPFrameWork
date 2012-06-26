//
//  SYPTimer.m
//  SYPFramework
//
//  Created by 玉平 孙 on 12-6-20.
//  Copyright (c) 2012年 RenRen.com. All rights reserved.
//

#import "SYPTimer.h"

//SYPTimer(PrivateMethod) 为 object－c 中 catagroy 语法
@interface SYPTimer(PrivateMethod)

// from NSTime fire method
-(void)internalTimeFireMethod:(NSTimer*) timer;
-(void)dealloc ;
@end


@implementation SYPTimer

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

+(SYPTimer*) timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo {
    SYPTimer* timer = [[SYPTimer alloc] initWithTimeInterval:ti target:aTarget selector:aSelector userInfo:userInfo repeats:yesOrNo];
    return [timer autorelease];
}

+(SYPTimer*) timerWithTimeInterval:(NSTimeInterval)ti protocol:(id<SYPTimerProtocol>)protocol  userInfo:(id)userInfo repeats:(BOOL)yesOrNo {
    SYPTimer* timer = [[SYPTimer alloc] initWithTimeInterval:ti protocol:protocol userInfo:userInfo repeats:yesOrNo];
    return [timer autorelease];
    
}
-(SYPTimer*)initWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo  {
    
    _timeInterval = ti ;
    _target       = aTarget ;
    _selector     = aSelector ;
    _userInfo     = userInfo ;
    _repeats      = yesOrNo ;
    return self;
}

-(SYPTimer*)initWithTimeInterval:(NSTimeInterval)ti protocol:(id<SYPTimerProtocol>)protocol  userInfo:(id)userInfo repeats:(BOOL)yesOrNo {
    
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
        SYPRelease(_timer);
    }
}

-(void)dealloc  {
    [self stop];
}
@end
