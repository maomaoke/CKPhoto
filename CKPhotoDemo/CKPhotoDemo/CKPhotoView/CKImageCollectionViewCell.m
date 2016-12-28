//
//  CKImageCollectionViewCell.m
//  CKPhotoDemo
//
//  Created by 钰龙徐 on 2016/12/22.
//  Copyright © 2016年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

#import "CKImageCollectionViewCell.h"

@interface CKImageCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imgView;
@end

@implementation CKImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imgView];
    }
    return self;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    
    self.imgView.image = image;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.frame =self.bounds;
    self.imgView.frame = self.bounds;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.userInteractionEnabled = YES;
    }
    return _imgView;
}

NSString * const CKImageCollectionViewCellID = @"CKImageCollectionViewCellID";

@end
