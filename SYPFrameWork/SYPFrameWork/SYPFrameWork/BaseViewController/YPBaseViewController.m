//
//  YPBaseViewController.m
//  SYPFrameWork
//
//  Created by sunyuping on 13-1-8.
//  Copyright (c) 2013年 sunyuping. All rights reserved.
//

#import "YPBaseViewController.h"

@interface YPBaseViewController ()

@end

@implementation YPBaseViewController

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
}

- (void)didReceiveMemoryWarning{
    if (self.isViewLoaded && ![self.view window]) {
        [self unLoadViews];
        self.view = nil;
    }
    [super didReceiveMemoryWarning];
}
// 子类实现
- (void)unLoadViews{
    
}
// 子类实现
- (void)cancelRequest{
    
}
@end
