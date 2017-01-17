//
//  CKCollectionCell.h
//  CKPhotoDemo
//
//  Created by 钰龙徐 on 2017/1/4.
//  Copyright © 2017年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CKAsset, CKCollectionCell;

@protocol CKCollectionCellDelegate <NSObject>

- (BOOL)collectionCell:(CKCollectionCell *)cell shouldSelectAsset:(CKAsset *)asset;

- (void)collectionCell:(CKCollectionCell *)cell didSelected:(BOOL)didSelected asset:(CKAsset *)asset;

@end

@interface CKCollectionCell : UICollectionViewCell

@property (nonatomic, strong) CKAsset *asset;

@property (nonatomic, weak) id<CKCollectionCellDelegate> delegate;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

+ (void)registerCellWithColectionView:(UICollectionView *)collectionView;

@end
