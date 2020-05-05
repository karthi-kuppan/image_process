//
//  OpenCVWrapper.mm
//  ImageSticting
//
//  Created by Karthikeyan Kuppan on 5/3/20.
//  Copyright © 2020 Karthi Kuppan. All rights reserved.
//

#if __has_include(<opencv2/opencv.hpp>)
#import <opencv2/opencv.hpp>
#endif

#import <opencv2/imgcodecs/ios.h>
#import "OpenCVWrapper.h"

@implementation OpenCVWrapper

+ (NSString *) openCVVersionString {
    return [NSString stringWithFormat:@"OpenCV version %s", CV_VERSION];
}

+ (UIImage *) makeGrayFromImage:(UIImage *)image {
    cv::Mat imageMat;
    UIImageToMat(image, imageMat);
    if (imageMat.channels() == 1) return image;
    
    cv::Mat grayMatt;
    cv::cvtColor(imageMat, grayMatt, cv::COLOR_BGR2GRAY);
    
    return MatToUIImage(grayMatt);
}

@end
