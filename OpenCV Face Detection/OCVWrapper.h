//
//  ViewController.swift
//  OpenCV Face Detection
//
//  Created by Marcos Castaneda on 2/15/17.
//  Copyright © 2017 Marcos Castaneda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCVWrapper : NSObject;

// Get verison number
+(NSString *) versionNumber;

// Convert to grayscale
+(UIImage *) convertToGrayscale: (UIImage *) image;

+(UIImage *) classifyImage: (UIImage *) image;

@end
