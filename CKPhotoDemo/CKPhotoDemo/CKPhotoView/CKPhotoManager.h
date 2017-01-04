//
//  CKPhotoManager.h
//  CKPhotoDemo
//
//  Created by 钰龙徐 on 2016/12/28.
//  Copyright © 2016年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@class CKAlbum;

typedef void(^CKPhotoAllAssetBlock)(NSArray <PHAsset *> *assets);
typedef void(^CKPhotoAllThumbnailBlock)(NSArray <UIImage *> *images);

typedef void(^CKPhotoAllAlbumBlock)(NSArray <CKAlbum *> *albums);

typedef void(^CKPhotoThumbnailBlock)(UIImage *thumbnail);

@interface CKPhotoManager : NSObject

+ (instancetype)sharedMangaer;
@property (nonatomic, weak, readonly) PHCachingImageManager *imageManager;

+ (PHAuthorizationStatus)authorizationStatus;

- (void)fetchAllThumbnailPhotoWithImageSize:(CGSize)size completionHandler:(CKPhotoAllThumbnailBlock)handler;

- (void)fetchAllPhotoWithCompletionHandler:(CKPhotoAllAssetBlock)handler;

- (void)fetchAllAlbumsWithCompletionHandler:(CKPhotoAllAlbumBlock)handler;

- (void)fetchThumbnailPhotoWithAsset:(PHAsset *)asset thumbnailSize:(CGSize)thumbnailSize completionHandler:(CKPhotoThumbnailBlock)handler;

@end
