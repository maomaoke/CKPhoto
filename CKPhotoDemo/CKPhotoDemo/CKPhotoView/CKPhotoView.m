//
//  CKPhotoView.m
//  CKPhotoDemo
//
//  Created by 钰龙徐 on 2016/12/22.
//  Copyright © 2016年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

#import "CKPhotoView.h"
#import "CKImageCollectionViewCell.h"

#import "CKPhoto.h"

@interface CKPhotoView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@property (nonatomic, assign) NSInteger columnCount;

@property (nonatomic, strong) NSMutableArray *photoArray;
@end

@implementation CKPhotoView

- (instancetype)initWithFrame:(CGRect)frame columnCount:(NSInteger)columnCount {
    if (self = [super initWithFrame:frame]) {
        [self setupInitial];
        self.columnCount = columnCount;
    }
    return self;
}

- (void)setupInitial {
    self.photoMargin = 8;
    [self addSubview:self.collectionView];
}

- (void)setColumnCount:(NSInteger)columnCount {
    _columnCount = columnCount;
    
    [self calculatePhotoViewHeight];
}

- (void)setPhotoMargin:(CGFloat)photoMargin {
    _photoMargin = photoMargin;
    
    self.layout.sectionInset = UIEdgeInsetsMake(self.photoMargin, self.photoMargin, self.photoMargin, self.photoMargin);
}


- (void)calculatePhotoViewHeight {
    
    NSInteger photoCount = self.photoArray.count;
    NSInteger row = photoCount / self.columnCount;
    if (photoCount % self.columnCount != 0) {
        row += 1;
    }
    
    CGFloat photoCellWH = (self.frame.size.width - self.layout.sectionInset.left - self.layout.sectionInset.right - (self.columnCount - 1) * self.photoMargin) / self.columnCount;
    CGFloat photoViewHeight = photoCellWH * row + (row - 1) * self.photoMargin + self.layout.sectionInset.top + self.layout.sectionInset.bottom;
    
    CGRect oldRect = self.frame;
    oldRect.size.height = photoViewHeight;
    self.frame = oldRect;
    [self.collectionView reloadData];
}

/**
 layout
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layout.minimumLineSpacing = self.photoMargin;
    self.layout.minimumInteritemSpacing = self.photoMargin;
    CGFloat photoCellWH =  (self.frame.size.width - self.layout.sectionInset.left - self.layout.sectionInset.right - (self.columnCount - 1) * self.photoMargin) / self.columnCount;
    self.layout.itemSize = CGSizeMake(photoCellWH, photoCellWH);
    self.collectionView.frame = self.bounds;
}

#pragma mark - collection view data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photoArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CKPhoto *model = self.photoArray[indexPath.row];
    CKImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CKImageCollectionViewCellID forIndexPath:indexPath];
    cell.image = model.image;
    return cell;
}


#pragma mark - collection view delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"....");
}

#pragma mark - lazy init

- (NSMutableArray *)photoArray {
    if (!_photoArray) {
        CKPhoto *photo = [[CKPhoto alloc] init];
        photo.image = [UIImage imageNamed:@"images.bundle/addimageshadow"];
        photo.photoType = CKPhotoTypeDefault;
        _photoArray = [NSMutableArray array];
        [_photoArray addObject:photo];
    }
    return _photoArray;
}

- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
    }
    return _layout;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[CKImageCollectionViewCell class] forCellWithReuseIdentifier:CKImageCollectionViewCellID];
    }
    return _collectionView;
}

@end
