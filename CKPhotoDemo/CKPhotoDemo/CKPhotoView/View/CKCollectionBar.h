//
//  CKCollectionBar.h
//  CKPhotoDemo
//
//  Created by 毛毛可 on 2017/1/6.
//  Copyright © 2017年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CKCollectionBar;

@protocol CKCollectionBarDelegate <NSObject>

- (void)collectionBar:(CKCollectionBar *)barView didClickAcceptButton:(UIButton *)btn;

@end

@interface CKCollectionBar : UIView

@property (nonatomic, weak) id<CKCollectionBarDelegate> delegate;

- (void)updateBarWithAssets:(NSArray *)assets;

@end
