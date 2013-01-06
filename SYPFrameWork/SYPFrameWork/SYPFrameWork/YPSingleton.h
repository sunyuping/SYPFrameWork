//
//  YPSingleton.h
//  SYPFrameWork
//
//  Created by sunyuping on 12-12-27.
//  Copyright (c) 2012年 sunyuping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPSingleton : NSObject{
    BOOL _canRelease;
    NSMutableDictionary* _singletonArray;
    BOOL _inCreate;
    BOOL _canUseRetainRelease;
}

@property (nonatomic,assign) BOOL inCreate ;
@property (nonatomic,assign) BOOL canUseRetainRelease ;

+(YPSingleton*)defaultSingleton;
-(void)releaseSingleton;

-(void)appendItem:(NSObject*)obj;
-(void)removeItem:(NSString*)className;
-(NSObject*)findItem:(NSString*)className;
@end

#define YP_DECLARE_SINGLETON(_object_name_) \
@interface _object_name_(PrivateMethod) \
+(id)allocWithZone:(NSZone*)zone;\
-(id)copyWithZone:(NSZone*)zone;\
-(oneway void)release;\
-(id)autorelease;\
-(id)retain;\
-(unsigned)retainCount;\
@end

#define YP_IMPLETEMENT_SINGLETON(_object_name_,_shared_obj_name_) \
+(_object_name_*)_shared_obj_name_ { \
YPSingleton* singleton = [YPSingleton defaultSingleton];\
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
YPSingleton* singleton = [YPSingleton defaultSingleton];\
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
if ([YPSingleton defaultSingleton].canUseRetainRelease==YES) {\
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
if ([YPSingleton defaultSingleton].canUseRetainRelease==YES) {\
return [super retain];\
}\
return self;\
}\
\
-(unsigned)retainCount {\
return 1;\
}\

