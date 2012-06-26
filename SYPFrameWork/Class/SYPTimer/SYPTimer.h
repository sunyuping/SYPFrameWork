//
//  SYPTimer.h
//  SYPFramework
//
//  Created by 玉平 孙 on 12-6-20.
//  Copyright (c) 2012年 RenRen.com. All rights reserved.
//

#import "SYPDefines.h"


@class SYPTimer; //因为 下面的SYPTimerProtocol 用到SYPTimer类 所以前置声明一下

/**
   1. 默认Protocol的命名 为类名＋Protocol 例如 SYPTimerProtocol
   2. 如果此 Protocol 函数 需要继承类必须实现需要加上 @required 字段
*/
@protocol SYPTimerProtocol<NSObject>
@required
    -(void)TimerFire:(SYPTimer*)timer userInfo:(id)userInfo ;
@end

@interface SYPTimer : NSObject {
@protected 
    /*内部变量需要加上 _开头 例如 _timer*/
    NSTimer* _timer;
    id<SYPTimerProtocol> _timerProtocol;
    id   _userInfo;
    id   _target ;
    SEL  _selector;
    BOOL _repeats;
    NSTimeInterval _timeInterval;
}
@property (nonatomic,readonly) NSTimer* timer;
@property (nonatomic,readwrite) NSTimeInterval timeInterval;
@property (nonatomic,getter = isRepeats) BOOL repeats;
@property (nonatomic,assign,setter = mySetUserInfo:) id userInfo;
/**
    此函数 使用系统默认的调用方式 
    展示不需要 Protocol 的调用方式 target 参数 表示接受 time事件的 接受者 selector 表示这个接受者接受事件的函数 此函数可以为 这个接受者的任意函数
*/
+(SYPTimer*) timerWithTimeInterval:(NSTimeInterval)ti target:(id<NSObject>)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo;
/**
    此函数 使用系统默认的调用方式 
    展示需要 Protocol 的调用方式 Protocol 的  TimerFire 函数 表示接受 time事件的 接受函数
*/
+(SYPTimer*) timerWithTimeInterval:(NSTimeInterval)ti protocol:(id<SYPTimerProtocol>)protocol  userInfo:(id)userInfo repeats:(BOOL)yesOrNo;

-(SYPTimer*)initWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo ;

-(SYPTimer*)initWithTimeInterval:(NSTimeInterval)ti protocol:(id<SYPTimerProtocol>)protocol  userInfo:(id)userInfo repeats:(BOOL)yesOrNo ;

-(void)start;
-(void)stop;
@end
