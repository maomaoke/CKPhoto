//
//  CKCollectionCell.m
//  CKPhotoDemo
//
//  Created by 钰龙徐 on 2017/1/4.
//  Copyright © 2017年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

#import "CKCollectionCell.h"

#import "CKAsset.h"

@interface CKCollectionCell ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UIButton *selectButton;
@end

@implementation CKCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupInitial];
    }
    return self;
}

- (void)setupInitial {
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.selectButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.iconView.frame = self.contentView.frame;
    
    [self.selectButton sizeToFit];
    CGFloat btnY = 0;
    CGFloat btnW = self.selectButton.frame.size.width;
    CGFloat btnH = self.selectButton.frame.size.height;
    CGFloat btnX = self.contentView.frame.size.width-btnW;
    self.selectButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
}

- (void)didClickSelectButton:(UIButton *)sender {
    if (sender.selected) {
        sender.selected = NO;
        if (self.delegate && [self.delegate respondsToSelector:@selector(collectionCell:didSelected:asset:)]) {
            [self.delegate collectionCell:self didSelected:NO asset:nil];
        }
        return;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionCell:shouldSelectAsset:)]) {
        sender.selected = [self.delegate collectionCell:self shouldSelectAsset:self.asset];
    }
    if (sender.selected) {
        [self animtationWithLayer:sender.layer];
        //回调
        if (self.delegate && [self.delegate respondsToSelector:@selector(collectionCell:didSelected:asset:)]) {
            [self.delegate collectionCell:self didSelected:sender.selected asset:self.asset];
        }
    }
}

- (void)animtationWithLayer:(CALayer *)layer {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 0.1;
    animation.fromValue = @1.0;
    animation.toValue = @0.75;
    animation.removedOnCompletion = YES;
    animation.autoreverses = YES;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [layer addAnimation:animation forKey:nil];
}

- (void)setAsset:(CKAsset *)asset {
    _asset = asset;
    
    self.iconView.image = asset.thumnailImage;
    self.selectButton.selected = asset.isSelected;
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.userInteractionEnabled = YES;
        _iconView.contentMode = UIViewContentModeScaleAspectFill;
        _iconView.clipsToBounds = YES;
    }
    return _iconView;
}

- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [[UIButton alloc] init];
        [_selectButton setImage:[UIImage imageNamed:@"images.bundle/photopicker_state_normal"] forState:UIControlStateNormal];
        [_selectButton setImage:[UIImage imageNamed:@"images.bundle/photopicker_state_selected"] forState:UIControlStateSelected];
        [_selectButton addTarget:self action:@selector(didClickSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectButton;
}


NSString * const CKCollectionCellID = @"CKCollectionCell";


+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath {
    CKCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CKCollectionCellID forIndexPath:indexPath];
    return cell;
}

+ (void)registerCellWithColectionView:(UICollectionView *)collectionView {
    [collectionView registerClass:[CKCollectionCell class] forCellWithReuseIdentifier:CKCollectionCellID];
}

@end
