//
//  ViewController.m
//  CKPhotoDemo
//
//  Created by 钰龙徐 on 2016/12/22.
//  Copyright © 2016年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

#import "ViewController.h"

#import "CKPhotoView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    CKPhotoView *photoView = [[CKPhotoView alloc] initWithFrame:CGRectMake(0, 20, size.width, 0)
                                                    columnCount:5];
    [self.view addSubview:photoView];
}


@end
