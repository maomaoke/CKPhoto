//
//  ViewController.m
//  CKPhotoDemo
//
//  Created by 钰龙徐 on 2016/12/22.
//  Copyright © 2016年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

#import "ViewController.h"

#import "CKPhotoView.h"
#import "CKPhotoManager.h"
#import "CKPhotoPickerController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    CGSize size = [UIScreen mainScreen].bounds.size;
//    CKPhotoView *photoView = [[CKPhotoView alloc] initWithFrame:CGRectMake(0, 20, size.width, 0)
//                                                    columnCount:5];
//    [self.view addSubview:photoView];
//    CKPhotoManager *mgr = [CKPhotoManager sharedMangaer];
//    
//    __block NSArray *imageArray = nil;
//    
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_group_enter(group);
//    [mgr fetchAllThumbnailPhotoWithImageSize:CGSizeMake(70, 70) completionHandler:^(NSArray<UIImage *> *images) {
//        imageArray = images;
//        dispatch_group_leave(group);
//    }];
//    
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        [photoView addPhotos:imageArray];
//    });
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    CKPhotoPickerController *vc = [[CKPhotoPickerController alloc] initWithMaxCount:9 delegate:self];
    
    [self presentViewController:vc animated:YES completion:^{
    }];
}


@end
