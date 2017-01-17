//
//  CKPhotoCollectionController.m
//  CKPhotoDemo
//
//  Created by 毛毛可 on 2017/1/3.
//  Copyright © 2017年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

#import "CKPhotoCollectionController.h"
#import "CKPhotoPreviewController.h"

#import "CKCollectionBar.h"
#import "CKCollectionCell.h"

#import "CKAlbum.h"
#import "CKAsset.h"

#import "CKPhotoManager.h"

@interface CKPhotoCollectionController () <UICollectionViewDataSource, UICollectionViewDelegate, CKCollectionCellDelegate, CKCollectionBarDelegate>

@property (nonatomic, assign) BOOL isAutoScrollToBottom;

@property (nonatomic, strong) NSArray *dataList;

/**
 被选中的assets
 */
@property (nonatomic, strong) NSMutableArray *selectedDatas;


@property (nonatomic, strong) CKCollectionBar *barView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation CKPhotoCollectionController

static CGFloat itemMargin = 3;


- (instancetype)initWithAlbum:(CKAlbum *)album isAutoScrollToBottom:(BOOL)isAutoScrollToBottom {
    if (self = [super init]) {
        _album = album;
        self.isAutoScrollToBottom = isAutoScrollToBottom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.collectionView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 50);
    self.barView.frame = CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), self.view.frame.size.width, 50);
    
    CGFloat itemWH = ((self.collectionView.frame.size.width - self.collectionView.contentInset.left - self.collectionView.contentInset.right) -  itemMargin * 3) / 4 ;
    self.flowLayout.itemSize = CGSizeMake(itemWH, itemWH);
    
}

- (void)setupUI {
    self.navigationItem.title = self.album.name;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(didClickCancelButton:)];
    
    [self.view addSubview:self.collectionView];
    [CKCollectionCell registerCellWithColectionView:self.collectionView];
    [self.view addSubview:self.barView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupData {
    
    [[CKPhotoManager sharedMangaer] fetchAssetsFromResult:self.album.fetchResult completionHandler:^(NSArray<CKAsset *> *assets) {
        self.dataList = assets;
        [self.collectionView reloadData];
    }];
}

- (void)didClickCancelButton:(UIBarButtonItem *)sender {
    
}

#pragma mark <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CKCollectionCell *cell = [CKCollectionCell cellWithCollectionView:collectionView indexPath:indexPath];
    CKAsset *asset = self.dataList[indexPath.item];
    cell.asset = asset;
    cell.delegate = self;
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    CKPhotoPreviewController *vc = [[CKPhotoPreviewController alloc] initWithAssets:self.dataList selectedAssets:@[] currentIndex:indexPath.item];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - CKCollectionCellDelegate

- (BOOL)collectionCell:(CKCollectionCell *)cell shouldSelectAsset:(CKAsset *)asset {
    if (0) {
        return NO;
    }
    
    return YES;
}

- (void)collectionCell:(CKCollectionCell *)cell didSelected:(BOOL)didSelected asset:(CKAsset *)asset {
    
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    if (self.dataList.count <= indexPath.item) {
        return;
    }
    CKAsset *data = self.dataList[indexPath.item];
    
    if (didSelected && ![self.selectedDatas containsObject:data]) {
        [self.selectedDatas addObject:data];
    } else if ([self.selectedDatas containsObject:data]) {
        [self.selectedDatas removeObject:data];
    }
    NSLog(@"%@", self.selectedDatas);
    //被选中相册通知
    [[NSNotificationCenter defaultCenter] postNotificationName:CKSelectAssetDidChangeNotification object:nil userInfo:@{@"count": @(self.selectedDatas.count)}];
    
    //bar view 回调
    [self.barView updateBarWithAssets:self.selectedDatas.copy];
}


#pragma mark - bar view delegate

- (void)collectionBar:(CKCollectionBar *)barView didClickAcceptButton:(UIButton *)btn {
    
}


- (CKCollectionBar *)barView {
    if (!_barView) {
        _barView = [[CKCollectionBar alloc] init];
        _barView.delegate = self;
    }
    return _barView;
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.contentInset = UIEdgeInsetsMake(itemMargin, itemMargin, itemMargin, itemMargin);
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = itemMargin;
        _flowLayout.minimumInteritemSpacing = itemMargin;
    }
    return _flowLayout;
}

- (NSMutableArray *)selectedDatas {
    if (!_selectedDatas) {
        _selectedDatas = [NSMutableArray array];
    }
    return _selectedDatas;
}


#pragma mark - notification 

NSString * const CKSelectAssetDidChangeNotification = @"CKSelectAssetDidChangeNotification";

@end
