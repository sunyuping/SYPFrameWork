//
//  YPTableItem.h
//  SYPFrameWork
//
//  Created by sunyuping on 13-1-8.
//  Copyright (c) 2013年 sunyuping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPTableViewItem : NSObject

@property (nonatomic, assign) float cellHeight;	// 缓存cell的高度,主要用于高度可变的cell

@property (nonatomic, retain) id userInfo;		// 用户数据

@end
