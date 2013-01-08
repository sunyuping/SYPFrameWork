//
//  YPSectionedDataSource.h
//  SYPFrameWork
//
//  Created by sunyuping on 13-1-8.
//  Copyright (c) 2013年 sunyuping. All rights reserved.
//

#import "YPTableViewDataSource.h"
#import "YPTableViewSectionObject.h"

@interface YPTableViewSectionedDataSource : YPTableViewDataSource {
	NSMutableArray *_sections;
}

@property (nonatomic, retain) NSMutableArray *sections;			// YPSectionObject对象数组
@property (nonatomic, assign) NSMutableArray *firstSectionItems;	// 返回第一个section的items数组

@end