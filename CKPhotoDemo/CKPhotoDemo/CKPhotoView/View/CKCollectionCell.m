//
//  CKCollectionCell.m
//  CKPhotoDemo
//
//  Created by 钰龙徐 on 2017/1/4.
//  Copyright © 2017年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

#import "CKCollectionCell.h"

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
    
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.userInteractionEnabled = YES;
    }
    return _iconView;
}

- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [[UIButton alloc] init];
        [_selectButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_selectButton setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        [_selectButton addTarget:self action:@selector(didClickSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectButton;
}


@end
