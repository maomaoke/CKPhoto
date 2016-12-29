//
//  CKPhotoManager.m
//  CKPhotoDemo
//
//  Created by 钰龙徐 on 2016/12/28.
//  Copyright © 2016年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

#import "CKPhotoManager.h"

@implementation CKPhotoManager

+ (instancetype)sharedMangaer {
    
    static id obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[CKPhotoManager alloc] init];
    });
    return obj;
}


- (instancetype)init {
    if (self = [super init]) {
        _imageManager = (PHCachingImageManager *)[PHCachingImageManager defaultManager];
    }
    return self;
}

- (void)fetchAllThumbnailPhotoWithImageSize:(CGSize)size completionHandler:(CKPhotoAllThumbnailBlock)handler {
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize newSize = CGSizeMake(size.width * scale, size.height * scale);
    NSMutableArray *mArray = [NSMutableArray array];
    [self fetchAllPhotoWithCompletionHandler:^(NSArray<PHAsset *> *assets) {
//        dispatch_group_t group = dispatch_group_create();
        [assets enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            dispatch_group_enter(group);
           [self.imageManager requestImageForAsset:obj targetSize:newSize contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
               if (result) {
                   [mArray addObject:result];
//                   dispatch_group_leave(group);
               }
           }];
        }];
//        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            if (handler) {
                handler(mArray.copy);
            }
//        });
    }];
}

- (void)fetchAllPhotoWithCompletionHandler:(CKPhotoAllAssetBlock)handler {
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    //只选择照片
    options.predicate = [NSPredicate predicateWithFormat:@"mediaType = %ld", PHAssetMediaTypeImage];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    PHFetchResult *result = [PHAsset fetchAssetsWithOptions:options];
    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:result.count];
    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [mArray addObject:obj];
    }];
    if (handler) {
        handler(mArray.copy);
    }
}

+ (PHAuthorizationStatus)authorizationStatus {
    return [PHPhotoLibrary authorizationStatus];
}

@end
