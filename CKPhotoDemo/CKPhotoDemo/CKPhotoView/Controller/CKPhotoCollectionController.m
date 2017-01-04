//
//  CKPhotoCollectionController.m
//  CKPhotoDemo
//
//  Created by 毛毛可 on 2017/1/3.
//  Copyright © 2017年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

#import "CKPhotoCollectionController.h"

#import "CKAlbum.h"
#import "CKAsset.h"

#import "CKPhotoManager.h"

@interface CKPhotoCollectionController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, assign) BOOL isAutoScrollToBottom;

@property (nonatomic, strong) NSArray *dataList;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@end

@implementation CKPhotoCollectionController

static NSString * const reuseIdentifier = @"CKPhotoCollectionControllerCell";


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
    self.collectionView.frame = self.view.frame;
}

- (void)setupUI {
    self.navigationItem.title = self.album.name;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(didClickCancelButton:)];
    
    [self.view addSubview:self.collectionView];
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
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
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
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
    }
    return _flowLayout;
}

@end
