//
//  CJSingleton.h
//  CJFramework
//
//  Created by liu ys on 11-11-15.
//  Copyright (c) 2011年 datou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJDefines.h"

@interface CJSingleton : NSObject {
    BOOL _canRelease;
    NSMutableDictionary* _singletonArray;
    BOOL _inCreate;
    BOOL _canUseRetainRelease;
}

@property (nonatomic,assign) BOOL inCreate ;
@property (nonatomic,assign) BOOL canUseRetainRelease ;

+(CJSingleton*)defaultSingleton;
-(void)releaseSingleton;

-(void)appendItem:(NSObject*)obj;
-(void)removeItem:(NSString*)className;
-(NSObject*)findItem:(NSString*)className;
@end

#define CJ_DECLARE_SINGLETON(_object_name_) \
@interface _object_name_(PrivateMethod) \
+(id)allocWithZone:(NSZone*)zone;\
-(id)copyWithZone:(NSZone*)zone;\
-(oneway void)release;\
-(id)autorelease;\
-(id)retain;\
-(unsigned)retainCount;\
@end

#define CJ_IMPLETEMENT_SINGLETON(_object_name_,_shared_obj_name_) \
+(_object_name_*)_shared_obj_name_ { \
    CJSingleton* singleton = [CJSingleton defaultSingleton];\
    NSString* className = [NSString stringWithCString:class_getName([_object_name_ class]) encoding:NSStringEncodingConversionAllowLossy];\
    _object_name_* result = (_object_name_*)[singleton findItem:className];\
    if (!result) { \
        singleton.inCreate =YES;\
        result = (_object_name_*)[[_object_name_ alloc] init];\
        [singleton appendItem:result];\
        singleton.inCreate =NO;\
    }\
    return result ;\
} \
\
+(id)allocWithZone:(NSZone*)zone { \
    CJSingleton* singleton = [CJSingleton defaultSingleton];\
    NSString* className = [NSString stringWithCString:class_getName([_object_name_ class]) encoding:NSStringEncodingConversionAllowLossy];\
    _object_name_* result = (_object_name_*)[singleton findItem:className];\
    if (!result) { \
        result = (_object_name_*)[super allocWithZone:zone];\
        if (singleton.inCreate==NO) {\
            [singleton appendItem:result];\
        }\
    }\
    return result;\
}\
\
-(id)copyWithZone:(NSZone*)zone {\
    return self;\
}\
\
-(oneway void)release {\
    if ([CJSingleton defaultSingleton].canUseRetainRelease==YES) {\
        return [super release];\
    }\
    return ;\
}\
\
-(id)autorelease {\
    return self;\
}\
\
-(id)retain {\
    if ([CJSingleton defaultSingleton].canUseRetainRelease==YES) {\
        return [super retain];\
    }\
    return self;\
}\
\
-(unsigned)retainCount {\
    return 1;\
}\

