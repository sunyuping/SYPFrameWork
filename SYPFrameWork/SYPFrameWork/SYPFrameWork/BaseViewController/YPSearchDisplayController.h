//
//  YPSearchDisplayController.h
//  SYPFrameWork
//
//  Created by sunyuping on 13-1-8.
//  Copyright (c) 2013年 sunyuping. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YPTableViewController;

@protocol YPSearchDisplayControllerDelegate <NSObject>
@optional
- (void)willBeginSearch;
- (void)willEndSearch;
- (void)willHideSearchResult;
- (void)didShowResult;
@end

@interface YPSearchDisplayController : UISearchDisplayController <UISearchDisplayDelegate>

@property (nonatomic, retain) YPTableViewController* searchResultsViewController;

@end