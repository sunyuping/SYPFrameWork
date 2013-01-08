//
//  YPTableViewLoadMoreCell.h
//  SYPFrameWork
//
//  Created by sunyuping on 13-1-8.
//  Copyright (c) 2013年 sunyuping. All rights reserved.
//

#import "YPTableViewCell.h"

@interface YPTableViewLoadMoreCell : YPTableViewCell
{
	UIActivityIndicatorView *_loadingAnimationView;
	UILabel					*_titleLabel;
	BOOL					_animating;
}

@property (nonatomic, assign) BOOL animating;

- (void)resetLoadingAnimationView:(UIActivityIndicatorView*)loadingView;

@end
