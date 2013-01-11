//
//  NSObjectAddition.m
//  SYPFrameWork
//
//  Created by sunyuping on 13-1-8.
//  Copyright (c) 2013年 sunyuping. All rights reserved.
//

#import "NSObjectAddition.h"
#import "SBJsonWriter.h"
#if (TARGET_OS_IPHONE)

#import <objc/runtime.h>
@implementation NSObject(ClassName)
- (NSString *)className
{
	return [NSString stringWithUTF8String:class_getName([self class])];
}
+ (NSString *)className
{
	return [NSString stringWithUTF8String:class_getName(self)];
}

@end
#endif

@implementation NSObject (Description)

- (NSString *)rsDescription {
    NSMutableString *desc = [NSMutableString string];
    NSMutableArray *arrProps = [NSMutableArray array];
    
    Class cls = self.class;
    while (cls != [NSObject class]) {
        unsigned int propsCount;
        objc_property_t *propList = class_copyPropertyList(cls, &propsCount);
        for (int i = 0; i < propsCount; i++) {
            objc_property_t oneProp = propList[i];
            [arrProps addObject:[NSString stringWithUTF8String:property_getName(oneProp)]];
        }
        
        if (propList)
            free(propList);
        
        cls = cls.superclass;
    }
    
    [desc appendFormat:@"<%@ %p", self.className, (void *) self];
    for (NSString *propName in arrProps) {
        [desc appendFormat:@",%@=%@", propName, [self valueForKey:propName]];
    }
    
    [desc appendString:@">"];
    return desc;
}
- (NSString *)xpDescription{
    NSString *className = NSStringFromClass([self class]);
    
    const char *cClassName = [className UTF8String];
    
    id theClass = objc_getClass(cClassName);
    
    unsigned int outCount, i;
    
    objc_property_t *properties = class_copyPropertyList(theClass, &outCount);
    
    NSMutableArray *propertyNames = [[NSMutableArray alloc] initWithCapacity:1];
    
    for (i = 0; i < outCount; i++) {
        
        objc_property_t property = properties[i];
        
        NSString *propertyNameString = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        
        [propertyNames addObject:propertyNameString];
        
        [propertyNameString release];
        
        NSLog(@"%s %s\n", property_getName(property), property_getAttributes(property));
        
    }
    
    NSMutableDictionary *finalDict = [NSMutableDictionary dictionaryWithCapacity:10];
    
    for(NSString *key in propertyNames)
    {
        SEL selector = NSSelectorFromString(key);
        id value = [self performSelector:selector];
        
        if (value == nil)
        {
            value = [NSNull null];
        }
        
        [finalDict setObject:value forKey:key];
    }
    
    [propertyNames release];
    
    return [NSString stringWithFormat:@"%@",finalDict];
//    NSString *retString = [[CJSONSerializer serializer] serializeDictionary:finalDict];
//    
//    [finalDict release];
    
//    return retString;
    
}
@end
