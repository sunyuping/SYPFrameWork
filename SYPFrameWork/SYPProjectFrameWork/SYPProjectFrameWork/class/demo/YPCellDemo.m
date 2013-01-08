//
//  YPCellDemo.m
//  SYPProjectFrameWork
//
//  Created by sunyuping on 13-1-8.
//  Copyright (c) 2013年 sunyuping. All rights reserved.
//

#import "YPCellDemo.h"
#import "YPTableViewItem.h"


@implementation YPCellDemo
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {

    return 45.0f;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
         [self.detailTextLabel setTextAlignment:UITextAlignmentRight];
        [self.textLabel setTextColor:[UIColor blackColor]];
        [self.detailTextLabel setTextColor:RGBCOLOR(162, 162, 162)];
        [self.detailTextLabel setFont:[UIFont systemFontOfSize:15]];
    }
    return self;
}
- (void)setObject:(id)object {
	if (_object != object) {
        if (object == nil) return;
		[super setObject:object];
    }
    YPTableViewItem *item = (YPTableViewItem*)object;
    self.textLabel.text = item.userInfo;
    self.detailTextLabel.text = @"sadefdsfdfsdsd";
   
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
