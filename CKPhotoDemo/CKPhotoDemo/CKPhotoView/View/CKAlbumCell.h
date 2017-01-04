//
//  CKAlbumCell.h
//  CKPhotoDemo
//
//  Created by 毛毛可 on 2017/1/2.
//  Copyright © 2017年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CKAlbum;

@interface CKAlbumCell : UITableViewCell

@property (nonatomic, strong) CKAlbum *album;

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

+ (void)registerCellForTableView:(UITableView *)tableView;

@end
