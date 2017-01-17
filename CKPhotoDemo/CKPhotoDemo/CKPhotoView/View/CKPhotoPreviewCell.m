//
//  CKPhotoPreviewCell.m
//  CKPhotoDemo
//
//  Created by 毛毛可 on 2017/1/7.
//  Copyright © 2017年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

#import "CKPhotoPreviewCell.h"

#import "CKAsset.h"

@interface CKPhotoPreviewCell () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation CKPhotoPreviewCell


- (void)setAsset:(CKAsset *)asset {
    _asset = asset;
    
    [self.scrollView setZoomScale:1.0];
    self.imageView.image = asset.originImage;
    [self setNeedsLayout];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupInitial];
    }
    return self;
}

- (void)setupInitial {
    self.backgroundColor = self.contentView.backgroundColor = [UIColor blackColor];
    
    [self.containerView addSubview:self.imageView];
    [self.scrollView addSubview:self.containerView];
    [self.contentView addSubview:self.scrollView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.scrollView.frame = self.contentView.frame;
    
    UIImage *image = self.imageView.image;
    if (!image) {
        return;
    }
    
    CGSize size = [self calculatePreviewSizeWithImageSize:image.size];
    CGFloat y = (self.scrollView.frame.size.height - size.height) / 2;
    CGFloat x = (self.scrollView.frame.size.width - size.width) / 2;
    self.containerView.frame = CGRectMake(x, y, size.width, size.height);
    self.imageView.frame = self.containerView.bounds;
}

- (CGSize)calculatePreviewSizeWithImageSize:(CGSize)imageSize {
    
    CGSize targetSize = self.bounds.size;
    
    CGFloat widthScale = imageSize.width / targetSize.width;
    CGFloat heightScale = imageSize.height / targetSize.height;
    if (widthScale <=1.0 && heightScale <= 1.0) {
        return imageSize;
    } else if (widthScale > 1.0 && heightScale <= 1.0) {
        return CGSizeMake(targetSize.width, imageSize.height/widthScale);
    } else if (widthScale <= 1.0 && heightScale > 1.0) {
        return CGSizeMake(imageSize.width/heightScale, targetSize.height);
    } else {
        if (widthScale < heightScale) {
            return CGSizeMake(imageSize.width / heightScale, targetSize.height);
        } else {
            return CGSizeMake(targetSize.width, imageSize.height/widthScale);
        }
    }
}

#pragma mark - scroll view delegate

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.containerView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    CGFloat offsetX = (scrollView.frame.size.width > scrollView.contentSize.width) ? (scrollView.frame.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.frame.size.height > scrollView.contentSize.height) ? (scrollView.frame.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    self.containerView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, scrollView.contentSize.height * 0.5 + offsetY);
}




- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
    }
    return _containerView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.bouncesZoom = YES;
        _scrollView.maximumZoomScale = 3.0f;
        _scrollView.minimumZoomScale = 1.0f;
        _scrollView.multipleTouchEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.scrollsToTop = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _scrollView.delaysContentTouches = NO;
        _scrollView.canCancelContentTouches = YES;
        _scrollView.alwaysBounceVertical = NO;
    }
    return _scrollView;
}

@end
