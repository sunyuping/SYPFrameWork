//
//  UIImageAdditions.h
//  SYPFrameWork
//
//  Created by sunyuping on 13-1-10.
//  Copyright (c) 2013年 sunyuping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage(UIImageAdditions)

+ (UIImage*)imageFromMainBundleFile:(NSString*)aFileName;

CGRect swapWidthAndHeight(CGRect rect);
-(UIImage*)rotate:(UIImageOrientation)orient;

//	旋转视图，陈毅 add
- (UIImage *)imageRotated:(UIImage*)img andByDegrees:(CGFloat)degrees;

// rotate and scale image from iphone camera
-(UIImage*)rotateAndScaleFromCameraWithMaxSize:(CGFloat)maxSize;

// scale this image to a given maximum width and height
-(UIImage*)scaleWithMaxSize:(CGFloat)maxSize;
-(UIImage*)scaleWithMaxSize:(CGFloat)maxSize
					quality:(CGInterpolationQuality)quality;


//截取部分图像
+ (UIImage*)getSubImage:(UIImage *)img rect:(CGRect)rect;
//缩放图片
+ (UIImage *)scaleImage:(UIImage *)img toSize:(CGSize)size;

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

@end
