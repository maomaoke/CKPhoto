//
//  CKPhotoCollectionController.h
//  CKPhotoDemo
//
//  Created by 毛毛可 on 2017/1/3.
//  Copyright © 2017年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CKAlbum;

@interface CKPhotoCollectionController : UIViewController

- (instancetype)initWithAlbum:(CKAlbum *)album isAutoScrollToBottom:(BOOL)isAutoScrollToBottom;


@property (nonatomic, strong, readonly) CKAlbum *album;



@end
