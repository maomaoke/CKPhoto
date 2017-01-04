//
//  CKPhotoManager.m
//  CKPhotoDemo
//
//  Created by 钰龙徐 on 2016/12/28.
//  Copyright © 2016年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

#import "CKPhotoManager.h"

#import "CKAlbum.h"
#import "CKAsset.h"

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
    options.synchronous = YES;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize newSize = CGSizeMake(size.width * scale, size.height * scale);
    NSMutableArray *mArray = [NSMutableArray array];
    [self fetchAllAssetWithCompletionHandler:^(NSArray<PHAsset *> *assets) {
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

- (void)fetchAllAssetWithCompletionHandler:(CKPhotoAllAssetBlock)handler {
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

- (void)fetchAllAlbumsWithCompletionHandler:(CKPhotoAllAlbumBlock)handler {
    
    NSMutableArray *mArray = [NSMutableArray array];
    
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum
                                                                     subtype:PHAssetCollectionSubtypeAny
                                                                     options:nil];
    [smartAlbums enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PHFetchOptions *option = [[PHFetchOptions alloc] init];
        option.predicate = [NSPredicate predicateWithFormat:@"mediaType = %ld", PHAssetMediaTypeImage];
        //相册
        PHFetchResult *assetsResult = [PHAsset fetchAssetsInAssetCollection:obj options:option];
        if (assetsResult.count) {
            CKAlbum *album = [[CKAlbum alloc] initWithFetchResult:assetsResult.copy name:obj.localizedTitle];
            [mArray addObject:album];
        }
    }];
    [mArray sortUsingComparator:^NSComparisonResult(CKAlbum * _Nonnull obj1, CKAlbum * _Nonnull obj2) {
        return obj1.photoCounts > obj2.photoCounts ? NSOrderedAscending : NSOrderedDescending;
    }];
    if (handler) {
        handler(mArray.copy);
    }
}

- (void)fetchThumbnailImageWithAsset:(PHAsset *)asset thumbnailSize:(CGSize)thumbnailSize completionHandler:(CKPhotoThumbnailBlock)handler {
    PHImageRequestOptions *imageRequestOptions = [[PHImageRequestOptions alloc] init];
    imageRequestOptions.synchronous = YES;
    imageRequestOptions.resizeMode = PHImageRequestOptionsResizeModeFast;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize targetSize = CGSizeMake(thumbnailSize.width * scale, thumbnailSize.height * scale);
    
    [self.imageManager requestImageForAsset:asset targetSize:targetSize contentMode:PHImageContentModeAspectFit options:imageRequestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (handler) {
            handler(result);
        }
    }];
}

- (void)fetchOriginImageWithAsset:(PHAsset *)asset completionHandler:(CKPhotoOriginImageBlock)handler {
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES;
    options.resizeMode = PHImageRequestOptionsResizeModeExact;
    [self.imageManager requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (handler) {
            handler(result);
        }
    }];
}

- (void)fetchPreviewImageWithAsset:(PHAsset *)asset completionHandler:(CKPhotoPreViewBlock)handler {
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES;
    options.resizeMode = PHImageRequestOptionsResizeModeExact;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize targetSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * scale, [UIScreen mainScreen].bounds.size.height * scale);
    [self.imageManager requestImageForAsset:asset targetSize:targetSize contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (handler) {
            handler(result);
        }
    }];
}


- (void)fetchAssetsFromResult:(PHFetchResult *)result completionHandler:(CKPhotoAssetFromResultBlock)handler {
    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:result.count];
    [result enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CKAsset *asset = [[CKAsset alloc] initWithAsset:obj];
        [mArray addObject:asset];
    }];
    if (handler) {
        handler(mArray.copy);
    }
}


+ (PHAuthorizationStatus)authorizationStatus {
    return [PHPhotoLibrary authorizationStatus];
}

@end
