//
//  CKPhotoView.h
//  CKPhotoDemo
//
//  Created by 钰龙徐 on 2016/12/22.
//  Copyright © 2016年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CKPhotoView;

@protocol CKPhotoViewDelegate <NSObject>

//- (NSArray <> *)photoViewDidClickAddAction:(CKPhotoView *)view;

@end


@interface CKPhotoView : UIView

- (instancetype)initWithFrame:(CGRect)frame columnCount:(NSInteger)columnCount;

- (void)addPhotos:(NSArray <UIImage *> *)image;
/**
 默认为8
 */
@property (nonatomic, assign) CGFloat photoMargin;

@property (nonatomic, assign, readonly) CGFloat photoViewHeight;


@end
