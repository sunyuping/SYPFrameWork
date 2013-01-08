//
//  YPTableviewDemoViewController.m
//  SYPProjectFrameWork
//
//  Created by sunyuping on 13-1-8.
//  Copyright (c) 2013年 sunyuping. All rights reserved.
//

#import "YPTableviewDemoViewController.h"
#import "YPDataSourceDemo.h"


@interface YPTableviewDemoViewController ()

@end

@implementation YPTableviewDemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.dataSource = [[YPDataSourceDemo alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsPullToRefresh = YES;
    
    self.tableView.showsVerticalScrollIndicator = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel* l = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 10)] autorelease];
    l.backgroundColor = [UIColor redColor];
    return l;
}
@end
