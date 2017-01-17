//
//  CKAnimationObject.m
//  CKPhotoDemo
//
//  Created by 毛毛可 on 2017/1/7.
//  Copyright © 2017年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

#import "CKAnimationObject.h"

@implementation CKAnimationObject

+ (void)animtationWithLayer:(CALayer *)layer {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 0.1;
    animation.fromValue = @1.0;
    animation.toValue = @0.75;
    animation.removedOnCompletion = YES;
    animation.autoreverses = YES;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [layer addAnimation:animation forKey:nil];
}

@end
