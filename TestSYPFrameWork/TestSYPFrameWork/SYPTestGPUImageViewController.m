//
//  SYPTestGPUImageViewController.m
//  TestSYPFramework
//
//  Created by 玉平 孙 on 12-6-29.
//  Copyright (c) 2012年 RenRen.com. All rights reserved.
//

#import "SYPTestGPUImageViewController.h"
#import "GPUImage/GPUImage.h"
@interface SYPTestGPUImageViewController ()

@end

@implementation SYPTestGPUImageViewController

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

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
