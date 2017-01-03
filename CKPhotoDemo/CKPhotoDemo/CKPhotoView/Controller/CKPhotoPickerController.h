//
//  CKPhotoPickerController.h
//  CKPhotoDemo
//
//  Created by 钰龙徐 on 2016/12/28.
//  Copyright © 2016年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CKPhotoPickerController : UINavigationController

- (instancetype)initWithMaxCount:(NSInteger)maxCount delegate:(id)delegate;

@property (nonatomic, weak) id pickerDelegate;

@property (nonatomic, assign) NSInteger maxCount;

@end

@interface CKCollectionListController : UITableViewController

@property (nonatomic, strong) NSArray *albums;

@end
