//
//  CKPhotoPickerController.m
//  CKPhotoDemo
//
//  Created by 钰龙徐 on 2016/12/28.
//  Copyright © 2016年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

#import "CKPhotoPickerController.h"

#define iOS(X) ([UIDevice currentDevice].systemVersion.floatValue >= X)

@interface CKPhotoPickerController ()

@end

@implementation CKPhotoPickerController

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
