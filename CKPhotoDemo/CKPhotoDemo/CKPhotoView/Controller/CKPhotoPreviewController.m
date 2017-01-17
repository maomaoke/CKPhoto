//
//  CKPhotoPreviewController.m
//  CKPhotoDemo
//
//  Created by 毛毛可 on 2017/1/7.
//  Copyright © 2017年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

#import "CKPhotoPreviewController.h"

#import "CKCollectionBar.h"
#import "CKCollectionTopBar.h"
#import "CKPhotoPreviewCell.h"

@interface CKPhotoPreviewController () <CKCollectionBarDelegate, CKCollectionTopBarDelegate>


@property (nonatomic, strong) CKCollectionTopBar *topBar;
@property (nonatomic, strong) CKCollectionBar *bottomBar;
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;
@end

@implementation CKPhotoPreviewController

static NSString * const reuseIdentifier = @"CKPhotoPreviewControllerCellID";


- (instancetype)initWithAssets:(NSArray<CKAsset *> *)assets
                selectedAssets:(NSArray<CKAsset *> *)selectedAssets
                  currentIndex:(NSUInteger)currentIndex
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    if (self = [super initWithCollectionViewLayout:flowLayout]) {
        _flowLayout = flowLayout;
        _currentIndex = currentIndex;
        _assets = assets.copy;
        _selectedAssets = [NSMutableArray arrayWithArray:selectedAssets];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubviews];
}

- (void)setupSubviews {
    
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    [self.view addSubview:self.bottomBar];
    [self.view addSubview:self.topBar];
    
    [self.collectionView registerClass:[CKPhotoPreviewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.collectionView.frame = self.view.bounds;
    self.bottomBar.frame = CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50);
    self.topBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 64);
    
    self.flowLayout.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark - collection view data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.assets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CKPhotoPreviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.asset = self.assets[indexPath.item];
    return cell;
}


#pragma mark - top bar delegate

- (void)collectionTopBarDidClickBackButton:(CKCollectionTopBar *)topBar {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)collectionTopBarDidClickSelectButton:(CKCollectionTopBar *)topBar {
    
}

#pragma mark - bottom bar delegate

- (void)collectionBar:(CKCollectionBar *)barView didClickAcceptButton:(UIButton *)btn {
    
}


- (CKCollectionBar *)bottomBar {
    if (!_bottomBar) {
        _bottomBar = [[CKCollectionBar alloc] init];
        _bottomBar.delegate = self;
    }
    return _bottomBar;
}

- (CKCollectionTopBar *)topBar {
    if (!_topBar) {
        _topBar = [[CKCollectionTopBar alloc] init];
        _topBar.delegate = self;
    }
    return _topBar;
}

@end
