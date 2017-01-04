//
//  CKAlbumCell.m
//  CKPhotoDemo
//
//  Created by 毛毛可 on 2017/1/2.
//  Copyright © 2017年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

#import "CKAlbumCell.h"

#import "CKAlbum.h"

#import "CKPhotoManager.h"

@interface CKAlbumCell ()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CKAlbumCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupInitial];
    }
    return self;
}

- (void)setupInitial {
    
    self.iconView = ({
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.userInteractionEnabled = YES;
        imgView;
    });
    self.titleLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.userInteractionEnabled = YES;
        label;
    });
    
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.titleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat imgWH = self.frame.size.height;
    self.iconView.frame = CGRectMake(0, 0, imgWH, imgWH);
    
    CGFloat labelX = CGRectGetMaxX(self.iconView.frame) + 16;
    self.titleLabel.frame = CGRectMake(labelX, 0, self.contentView.frame.size.width - labelX - 16, imgWH);
}

- (void)setAlbum:(CKAlbum *)album {
    _album = album;
    
    NSMutableAttributedString *nameString = [[NSMutableAttributedString alloc] initWithString:album.name attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor blackColor]}];
    NSAttributedString *countString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"  (%zd)",album.photoCounts] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    [nameString appendAttributedString:countString];
    self.titleLabel.attributedText = nameString;
    
    [[CKPhotoManager sharedMangaer] fetchThumbnailPhotoWithAsset:[album.fetchResult lastObject] thumbnailSize:CGSizeMake(70, 70) completionHandler:^(UIImage *thumbnail) {
        NSLog(@"%@", [NSThread currentThread]);
        self.iconView.image = thumbnail;
    }];
}


+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    CKAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:CKAlbumCellID forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

+ (void)registerCellForTableView:(UITableView *)tableView {
    [tableView registerClass:[CKAlbumCell class] forCellReuseIdentifier:CKAlbumCellID];
}


NSString * const CKAlbumCellID = @"CKAlbumCell";

@end
