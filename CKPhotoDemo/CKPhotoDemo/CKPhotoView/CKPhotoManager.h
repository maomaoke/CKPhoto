//
//  CKPhotoManager.h
//  CKPhotoDemo
//
//  Created by 钰龙徐 on 2016/12/28.
//  Copyright © 2016年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@class CKAlbum, CKAsset;

typedef void(^CKPhotoAllAssetBlock)(NSArray <PHAsset *> *assets);
typedef void(^CKPhotoAllThumbnailBlock)(NSArray <UIImage *> *images);

typedef void(^CKPhotoAllAlbumBlock)(NSArray <CKAlbum *> *albums);

typedef void(^CKPhotoThumbnailBlock)(UIImage *thumbnail);
typedef void(^CKPhotoOriginImageBlock)(UIImage *origin);
typedef void(^CKPhotoPreViewBlock)(UIImage *preview);

typedef void(^CKPhotoAssetFromResultBlock)(NSArray <CKAsset *> *assets);

@interface CKPhotoManager : NSObject

+ (instancetype)sharedMangaer;
@property (nonatomic, weak, readonly) PHCachingImageManager *imageManager;

+ (PHAuthorizationStatus)authorizationStatus;

+ (void)requestAuthorization:(void(^)(PHAuthorizationStatus status))handler;

- (void)fetchAllThumbnailPhotoWithImageSize:(CGSize)size completionHandler:(CKPhotoAllThumbnailBlock)handler;

- (void)fetchAllAssetWithCompletionHandler:(CKPhotoAllAssetBlock)handler;

- (void)fetchAllAlbumsWithCompletionHandler:(CKPhotoAllAlbumBlock)handler;

- (void)fetchThumbnailImageWithAsset:(PHAsset *)asset thumbnailSize:(CGSize)thumbnailSize completionHandler:(CKPhotoThumbnailBlock)handler;

- (void)fetchOriginImageWithAsset:(PHAsset *)asset completionHandler:(CKPhotoOriginImageBlock)handler;

- (void)fetchPreviewImageWithAsset:(PHAsset *)asset completionHandler:(CKPhotoPreViewBlock)handler;

- (void)fetchAssetsFromResult:(PHFetchResult *)result completionHandler:(CKPhotoAssetFromResultBlock)handler;

@end
