//
//  CKPhotoPreviewController.h
//  CKPhotoDemo
//
//  Created by 毛毛可 on 2017/1/7.
//  Copyright © 2017年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CKAsset;

@interface CKPhotoPreviewController : UICollectionViewController

- (instancetype)initWithAssets:(NSArray <CKAsset *> *)assets
                selectedAssets:(NSArray <CKAsset *> *)selectedAssets
                  currentIndex:(NSUInteger)currentIndex;


@property (nonatomic, copy, readonly) NSArray *assets;

@property (nonatomic, strong, readonly) NSArray *selectedAssets;

@property (nonatomic, assign) NSUInteger currentIndex;
@end
