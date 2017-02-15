//
//  ViewController.swift
//  OpenCV Face Detection
//
//  Created by Marcos Castaneda on 2/15/17.
//  Copyright © 2017 Marcos Castaneda. All rights reserved.
//

#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>
#import "OCVWrapper.h"

@implementation OCVWrapper

// Get version number
+(NSString *) versionNumber
{
    return [NSString stringWithFormat:@"OpenCV %s", CV_VERSION];
}

#pragma mark - Convert to grayscale
+(UIImage *) convertToGrayscale: (UIImage *) image {
    cv::Mat imageMat;
    UIImageToMat(image, imageMat);

    if (imageMat.channels() == 1) return image;

    // Transform
    cv::Mat grayMat;
    cv::cvtColor(imageMat, grayMat, CV_BGR2GRAY);

    // Convert to UImage
    return MatToUIImage(grayMat);
}

#pragma mark - Classify Image
+(UIImage *) classifyImage: (UIImage *) image {
    // Convert UIImage to CV Mat
    cv::Mat colorMat;
    UIImageToMat(image, colorMat);

    // Convert to grayscale
    cv::Mat grayMat;
    cv::cvtColor(colorMat, grayMat, CV_BGR2GRAY);

    // Load classifier from file
    cv::CascadeClassifier classifier;
    const NSString* cascadePath = [[NSBundle mainBundle]
                             pathForResource:@"haarcascade_frontalface_default"
                             ofType:@"xml"];
    classifier.load([cascadePath UTF8String]);

    // Initialize vars for classifier
    std::vector<cv::Rect> detections;

    const double scalingFactor = 1.1;
    const int minNeighbors = 2;
    const int flags = 0;
    const cv::Size minimumSize(300, 300);

    // Classify function
    classifier.detectMultiScale(
                                grayMat,
                                detections,
                                scalingFactor,
                                minNeighbors,
                                flags,
                                minimumSize
                                );

    // If no detections found, return nil
    if (detections.size() <= 0) {
        return nil;
    }

    // Range loop through detections
    for (auto &face : detections) {
        const cv::Point tl(face.x,face.y);
        const cv::Point br = tl + cv::Point(face.width, face.height);
        const cv::Scalar magenta = cv::Scalar(255, 0, 255);

        cv::rectangle(colorMat, tl, br, magenta, 4, 8, 0);
    }

    return MatToUIImage(colorMat);
}

@end
