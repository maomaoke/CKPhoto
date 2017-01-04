//
//  CKPhoto.h
//  CKPhotoDemo
//
//  Created by 钰龙徐 on 2016/12/22.
//  Copyright © 2016年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CKPhotoType) {
    CKPhotoTypeDefault,
    CKPhotoTypePhoto,
};

/**
 九宫格model
 */
@interface CKPhoto : NSObject <NSCopying>

/**
 image对象
 */
@property (nonatomic, strong) UIImage *image;

@property (nonatomic, assign) CKPhotoType photoType;
@end
