//
//  UIFont+PKFont.m
//  PKResManager
//
//  Created by zhongsheng on 12-11-27.
//
//

#import "UIFont+PKFont.h"

@implementation UIFont (PKFont)

+ (UIFont *)fontForKey:(id)key
{
    NSArray *keyArray = [key componentsSeparatedByString:@"-"];
    NSAssert1(keyArray.count == 2, @"module key name error!!! [font]==> %@", key);
    
    NSString *moduleKey = [keyArray objectAtIndex:0];
    NSString *memberKey = [keyArray objectAtIndex:1];
    
    NSDictionary *moduleDict = [[PKResManager getInstance].resOtherCache objectForKey:moduleKey];
    NSDictionary *memberDict = [moduleDict objectForKey:memberKey];
    
    NSString *fontName = [memberDict objectForKey:@"font"];
    NSNumber *fontSize = [memberDict objectForKey:@"size"];
    UIFont *font = [UIFont fontWithName:fontName
                                   size:fontSize.floatValue];
    
    return font;
}

@end
