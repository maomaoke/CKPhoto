//
//  CKCollectionBar.m
//  CKPhotoDemo
//
//  Created by 毛毛可 on 2017/1/6.
//  Copyright © 2017年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

#import "CKCollectionBar.h"

#import "CKAnimationObject.h"

@interface CKCollectionBar ()

/**
 确认按钮
 */
@property (nonatomic, strong) UIButton *acceptButton;
@property (nonatomic, strong) UIButton *numButton;

@property (nonatomic, strong) UIView *lineView;
@end

@implementation CKCollectionBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupInitial];
    }
    return self;
}

- (void)setupInitial {
    [self addSubview:self.acceptButton];
    [self addSubview:self.numButton];
    self.backgroundColor = [UIColor colorWithRed:34/255.0f green:34/255.0f blue:34/255.0f alpha:.7f];
}


- (void)didClickAcceptButton:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionBar:didClickAcceptButton:)]) {
        [self.delegate collectionBar:self didClickAcceptButton:sender];
    }
}


- (void)updateBarWithAssets:(NSArray *)assets {
    
    BOOL isAvilabel = assets && assets.count;
    
    self.numButton.hidden = !isAvilabel;
    self.acceptButton.enabled = isAvilabel;
    
    [self.numButton setTitle:[NSString stringWithFormat:@"%zd", assets.count] forState:UIControlStateNormal];
    [CKAnimationObject animtationWithLayer:self.numButton.layer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.acceptButton sizeToFit];
    
    CGFloat btnW = self.acceptButton.frame.size.width;
    CGFloat btnH = self.acceptButton.frame.size.height;
    CGFloat rightMargin = 16;
    self.acceptButton.frame = CGRectMake(self.frame.size.width - btnW - rightMargin, (self.frame.size.height - btnH) / 2, btnW, btnH);
    
    CGFloat numWH = 30;
    self.numButton.frame = CGRectMake(CGRectGetMinX(self.acceptButton.frame) - 8 - numWH, (self.frame.size.height - numWH) / 2, numWH, numWH);
    
    self.lineView.frame = CGRectMake(0, 0, self.frame.size.width, 1);
}


- (UIButton *)acceptButton {
    if (!_acceptButton) {
        _acceptButton = [[UIButton alloc] init];
        [_acceptButton setTitle:@"确认" forState:UIControlStateNormal];
        [_acceptButton setTitleColor:[UIColor colorWithRed:(83/255.0) green:(179/255.0) blue:(17/255.0) alpha:1.0f] forState:UIControlStateNormal];
        [_acceptButton setTitleColor:[UIColor colorWithRed:(83/255.0) green:(179/255.0) blue:(17/255.0) alpha:.5f] forState:UIControlStateDisabled];
        [_acceptButton addTarget:self action:@selector(didClickAcceptButton:) forControlEvents:UIControlEventTouchUpInside];
        _acceptButton.enabled = NO;
    }
    return _acceptButton;
}

- (UIButton *)numButton {
    if (!_numButton) {
        _numButton = [[UIButton alloc] init];
        _numButton.userInteractionEnabled = NO;
        [_numButton setBackgroundImage:[UIImage imageNamed:@"images.bundle/bottom_bar_origin_selected"] forState:UIControlStateNormal];
        _numButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _numButton.hidden = YES;
    }
    return _numButton;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1];
    }
    return _lineView;
}

@end
