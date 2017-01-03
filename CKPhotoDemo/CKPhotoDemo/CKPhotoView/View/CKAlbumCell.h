//
//  CKAlbumCell.h
//  CKPhotoDemo
//
//  Created by 毛毛可 on 2017/1/2.
//  Copyright © 2017年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CKAlbumCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

+ (void)registerCellForTableView:(UITableView *)tableView;

@end
