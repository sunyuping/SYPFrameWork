//
//  SYPImagePickerController.h
//  TestSYPFramework
//
//  Created by 玉平 孙 on 12-7-2.
//  Copyright (c) 2012年 RenRen.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPUImage/GPUImage.h"
@interface SYPImagePickerController : UIViewController{
    GPUImageStillCamera *stillCamera;
    GPUImageOutput<GPUImageInput> *filter;
    GPUImageGammaFilter *currentFilter;
    //照片来源
	UIImagePickerControllerSourceType _sourceType;
    
    UIButton *photoCaptureButton;
    UIScrollView *effects;
}

@end

