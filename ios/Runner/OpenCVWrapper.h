//
// Created by Karthikeyan Kuppan on 5/3/20.
//

#ifndef IMAGE_PROCESS_OPENCVWRAPPER_H
#define IMAGE_PROCESS_OPENCVWRAPPER_H

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OpenCVWrapper : NSObject
+ (NSString *) openCVVersionString;
+ (UIImage *) makeGrayFromImage:(UIImage *)image;
@end

#endif //IMAGE_PROCESS_OPENCVWRAPPER_H
