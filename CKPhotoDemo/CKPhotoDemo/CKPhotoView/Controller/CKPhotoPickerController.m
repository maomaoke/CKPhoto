//
//  CKPhotoPickerController.m
//  CKPhotoDemo
//
//  Created by 钰龙徐 on 2016/12/28.
//  Copyright © 2016年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

#import "CKPhotoPickerController.h"

#import "CKAlbumCell.h"

#import "CKPhotoManager.h"

#define iOS(X) ([UIDevice currentDevice].systemVersion.floatValue >= X)

@interface CKPhotoPickerController ()

@end

@implementation CKPhotoPickerController

- (instancetype)initWithMaxCount:(NSInteger)maxCount delegate:(id)delegate {
    
    if (self = [super initWithRootViewController:[CKCollectionListController new]]) {
        _pickerDelegate = delegate;
        _maxCount = maxCount;
    }
    return self;
}


#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupAppearance];
}

- (void)setupAppearance {
    self.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationBar.translucent = YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationBar.barTintColor = [UIColor colorWithRed:(34/255.0) green:(34/255.0) blue:(34/255.0) alpha:1.0];
    self.navigationBar.tintColor = [UIColor whiteColor];
    
    UINavigationBar *navBar;
    UIBarButtonItem *barItem;
    if (iOS(9)) {
        navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[CKPhotoPickerController class]]];
        barItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[CKPhotoPickerController class]]];
    } else {
        barItem = [UIBarButtonItem appearanceWhenContainedIn:[CKPhotoPickerController class], nil];
        navBar = [UINavigationBar appearanceWhenContainedIn:[CKPhotoPickerController class], nil];
    }
    [barItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15], NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateNormal];
    [navBar setBarStyle:UIBarStyleBlackTranslucent];
}

@end


@implementation CKCollectionListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupData];
}

- (void)setupUI {
    self.navigationItem.title = @"照片";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(didClickCancelButton:)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.rowHeight = 70.0f;
    [CKAlbumCell registerCellForTableView:self.tableView];
}

- (void)setupData {
    if ([CKPhotoManager authorizationStatus] != PHAuthorizationStatusAuthorized) {
        return;
    }
    [[CKPhotoManager sharedMangaer] fetchAllAlbumsWithCompletionHandler:^(NSArray<CKAlbum *> *albums) {
        self.albums = albums;
        [self.tableView reloadData];
    }];
}


- (void)didClickCancelButton:(UIBarButtonItem *)sender {
    
}

#pragma mark - table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.albums.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CKAlbumCell *cell = [CKAlbumCell cellWithTableView:tableView indexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.album = self.albums[indexPath.row];
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

