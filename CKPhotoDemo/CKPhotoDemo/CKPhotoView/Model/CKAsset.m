//
//  CKAsset.m
//  CKPhotoDemo
//
//  Created by 钰龙徐 on 2016/12/29.
//  Copyright © 2016年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

#import "CKAsset.h"

#import "CKPhotoManager.h"

@implementation CKAsset

@synthesize originImage = _originImage;
@synthesize thumnailImage = _thumnailImage;
@synthesize previewImage = _previewImage;


- (instancetype)initWithAsset:(PHAsset *)asset {
    if (self = [super init]) {
        _asset = asset;
    }
    return self;
}

- (UIImage *)originImage {
    if (_originImage) {
        return _originImage;
    }
    [[CKPhotoManager sharedMangaer] fetchOriginImageWithAsset:self.asset completionHandler:^(UIImage *origin) {
        _originImage = origin;
    }];
    return _originImage;
}

- (UIImage *)thumnailImage {
    if (_thumnailImage) {
        return _thumnailImage;
    }
    [[CKPhotoManager sharedMangaer] fetchThumbnailImageWithAsset:self.asset thumbnailSize:CGSizeMake(70, 70) completionHandler:^(UIImage *thumbnail) {
        _thumnailImage = thumbnail;
    }];
    return _thumnailImage;
}

- (UIImage *)previewImage {
    if (_previewImage) {
        return _previewImage;
    }
    [[CKPhotoManager sharedMangaer] fetchPreviewImageWithAsset:self.asset completionHandler:^(UIImage *preview) {
        _previewImage = preview;
    }];
    return _previewImage;
}


@end
