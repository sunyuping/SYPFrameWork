//
//  CJSingleton.m
//  CJFramework
//
//  Created by liu ys on 11-11-15.
//  Copyright (c) 2011年 datou. All rights reserved.
//

#import "CJSingleton.h"
#import "NSString+CJFramework.h"

@interface CJSingleton(PrivateMethod)
+(id)allocWithZone:(NSZone*)zone;
-(id)copyWithZone:(NSZone*)zone; 
-(id)init;
-(oneway void)release;
-(id)autorelease;
-(id)retain;
-(void)dealloc;
-(unsigned)retainCount;
@end

static CJSingleton* singleton = nil;

@implementation CJSingleton

@synthesize canUseRetainRelease =_canUseRetainRelease;
@synthesize inCreate =_inCreate;

+(CJSingleton*)defaultSingleton {
    @synchronized(self){
        if (nil == singleton) {
            singleton = [[self alloc] init];
        }
    }
    return singleton;
}

+(id)allocWithZone:(NSZone*)zone {
    @synchronized(self){
        if (singleton == nil) {
            singleton =  [super allocWithZone:zone];
        }
    }
    
    return singleton;
}
-(id)init {
    [super init];
    _canRelease = NO;
    _canUseRetainRelease =NO;
    _inCreate =NO;
    _singletonArray = [NSMutableDictionary dictionaryWithCapacity:10];
    [_singletonArray retain];
    return  self; 
}
-(void)releaseSingleton {
    _canRelease = YES;
    CFRelease((CFTypeRef)singleton);
    singleton = nil;
}
-(id)copyWithZone:(NSZone*)zone {
    return self;
}
-(oneway void)release {
    if (_canRelease ==YES) {
        return [super release];
    }
    return;
}
-(id)autorelease {
    return self;
}
-(id)retain {
    return self;
}
-(unsigned)retainCount {
    return 1;
}
-(void)dealloc{
    _canUseRetainRelease =YES;
    [_singletonArray release];
    [super dealloc];
}

-(void)appendItem:(NSObject*)obj {
    _canUseRetainRelease =YES;
    [_singletonArray setObject:obj forKey:NSStringFromClass([obj class])];
    _canUseRetainRelease =NO;
}
-(void)removeItem:(NSString*)className {
    _canUseRetainRelease =YES;
    [_singletonArray removeObjectForKey:className];
    _canUseRetainRelease =NO;
}
-(NSObject*)findItem:(NSString*)className {
    return [_singletonArray objectForKey:className];
}
@end
