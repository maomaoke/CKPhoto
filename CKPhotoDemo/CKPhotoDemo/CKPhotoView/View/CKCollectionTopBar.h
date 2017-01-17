//
//  CKCollectionTopBar.h
//  CKPhotoDemo
//
//  Created by 毛毛可 on 2017/1/7.
//  Copyright © 2017年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CKCollectionTopBar;

@protocol CKCollectionTopBarDelegate <NSObject>

- (void)collectionTopBarDidClickBackButton:(CKCollectionTopBar *)topBar;

- (void)collectionTopBarDidClickSelectButton:(CKCollectionTopBar *)topBar;
@end

@interface CKCollectionTopBar : UIView

@property (nonatomic, weak) id<CKCollectionTopBarDelegate> delegate;

@end
