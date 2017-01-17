//
//  CKCollectionTopBar.m
//  CKPhotoDemo
//
//  Created by 毛毛可 on 2017/1/7.
//  Copyright © 2017年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

#import "CKCollectionTopBar.h"

@interface CKCollectionTopBar ()

@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, strong) UIButton *selectButton;

@end

@implementation CKCollectionTopBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupInitial];
    }
    return self;
}


- (void)didClickBackButton:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionTopBarDidClickBackButton:)]) {
        [self.delegate collectionTopBarDidClickBackButton:self];
    }
}

- (void)didClickSelectButton:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionTopBarDidClickSelectButton:)]) {
        [self.delegate collectionTopBarDidClickSelectButton:self];
    }
}

- (void)setupInitial {
    self.backgroundColor = [UIColor colorWithRed:34/255.0f green:34/255.0f blue:34/255.0f alpha:.7f];
    [self addSubview:self.backButton];
    [self addSubview:self.selectButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat originY = 20;
    self.selectButton.frame = CGRectMake(self.frame.size.width - 12 - self.selectButton.frame.size.width, self.frame.size.height/2 - self.selectButton.frame.size.height/2 + originY/2, self.selectButton.frame.size.width, self.selectButton.frame.size.height);
    
    self.backButton.frame =  CGRectMake(12, self.frame.size.height/2 - self.backButton.frame.size.height/2 + originY/2, self.backButton.frame.size.width, self.backButton.frame.size.height);
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [[UIButton alloc] init];
        [_backButton setImage:[UIImage imageNamed:@"images.bundle/navigation_back"] forState:UIControlStateNormal];
        [_backButton setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
        [_backButton sizeToFit];
        [_backButton addTarget:self action:@selector(didClickBackButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [[UIButton alloc] init];
        [_selectButton setImage:[UIImage imageNamed:@"images.bundle/photopicker_state_normal"] forState:UIControlStateNormal];
        [_selectButton setImage:[UIImage imageNamed:@"images.bundle/photopicker_state_selected"] forState:UIControlStateSelected];
        [_selectButton setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
        [_selectButton sizeToFit];
        [_selectButton addTarget:self action:@selector(didClickSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectButton;
}

@end
