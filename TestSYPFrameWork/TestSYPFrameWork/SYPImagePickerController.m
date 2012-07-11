//
//  SYPCameraViewController.m
//  TestSYPFramework
//
//  Created by 玉平 孙 on 12-7-2.
//  Copyright (c) 2012年 RenRen.com. All rights reserved.
//

#import "SYPImagePickerController.h"

@interface SYPImagePickerController ()

@end

@implementation SYPImagePickerController
-(void)dealloc{
    [effects release];
    [stillCamera release];
    if (currentFilter ) {
        [currentFilter release];
        currentFilter = nil;
    }
    
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)loadView 
{
	CGRect mainScreenFrame = [[UIScreen mainScreen] bounds];
    
    // Yes, I know I'm a caveman for doing all this by hand
	GPUImageView *primaryView = [[GPUImageView alloc] initWithFrame:mainScreenFrame];
	primaryView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
   
    photoCaptureButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    photoCaptureButton.frame = CGRectMake(round(mainScreenFrame.size.width / 2.0 - 150.0 / 2.0), mainScreenFrame.size.height - 90.0, 150.0, 40.0);
    [photoCaptureButton setTitle:@"Capture Photo" forState:UIControlStateNormal];
	photoCaptureButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [photoCaptureButton addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [photoCaptureButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
    //[primaryView addSubview:photoCaptureButton];
    
	self.view = primaryView;	
    
    effects = [[UIScrollView alloc] init];
    [effects setFrame:CGRectMake(0, 460-50, 320, 50)];
    
    NSInteger count = 10;
    NSInteger x = 0;
    for (int i=0 ; i<count; i++) {
        x = i*50;
        UIButton *oneeffect = [UIButton buttonWithType:UIButtonTypeCustom];
        [oneeffect setFrame:CGRectMake(x, 0, 50, 50)];
        [oneeffect setBackgroundColor:[UIColor yellowColor]];
        [oneeffect setTitle:@"效果" forState:UIControlStateNormal];
        oneeffect.tag = i+1;
        [oneeffect addTarget:self action:@selector(selecteffect:) forControlEvents:UIControlEventTouchDragInside];
        [effects addSubview:oneeffect];
        
    }
    [effects setContentSize:CGSizeMake(50*count, 50)];
    [self.view addSubview:effects];
    

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    stillCamera = [[GPUImageStillCamera alloc] init];
    //    stillCamera = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack];
    stillCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    //    filter = [[GPUImageGammaFilter alloc] init];
    /*
    filter = [[GPUImageSketchFilter alloc] init];
    //    [(GPUImageSketchFilter *)filter setTexelHeight:(1.0 / 1024.0)];
    //    [(GPUImageSketchFilter *)filter setTexelWidth:(1.0 / 768.0)];
    //    filter = [[GPUImageSmoothToonFilter alloc] init];
    //    filter = [[GPUImageSepiaFilter alloc] init];
    
	[filter prepareForImageCapture];
    
    [stillCamera addTarget:filter];
    */
    GPUImageBulgeDistortionFilter *tmp1 = [[GPUImageBulgeDistortionFilter alloc] init];
    [tmp1 prepareForImageCapture];
    [stillCamera addTarget:tmp1];
    GPUImageView *filterView = (GPUImageView *)self.view;
    
    //[filter addTarget:filterView];
    [tmp1 addTarget:filterView];
    //    [stillCamera.inputCamera lockForConfiguration:nil];
    //    [stillCamera.inputCamera setFlashMode:AVCaptureFlashModeOn];
    //    [stillCamera.inputCamera unlockForConfiguration];
    
    [stillCamera startCameraCapture];
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
-(void)takePhoto:(id)btn{
    
}
@end
