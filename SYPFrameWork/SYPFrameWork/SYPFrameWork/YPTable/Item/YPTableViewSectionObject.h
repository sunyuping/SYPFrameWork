//
//  YPSectionObject.h
//  SYPFrameWork
//
//  Created by sunyuping on 13-1-8.
//  Copyright (c) 2013年 sunyuping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPTableViewSectionObject : NSObject 

@property (nonatomic, copy) NSString *letter;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) id userInfo;
@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, copy) NSString *footerTitle;
@end
