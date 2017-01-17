//
//  CKAsset.h
//  CKPhotoDemo
//
//  Created by 钰龙徐 on 2016/12/29.
//  Copyright © 2016年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PHAsset;
/**
 对PHAsset的封装
 */
@interface CKAsset : NSObject

- (instancetype)initWithAsset:(PHAsset *)asset;

@property (nonatomic, strong, readonly) PHAsset *asset;

@property (nonatomic, strong, readonly) UIImage *originImage;

@property (nonatomic, strong, readonly) UIImage *thumnailImage;

@property (nonatomic, strong, readonly) UIImage *previewImage;

@property (nonatomic, assign) BOOL isSelected;
@end
