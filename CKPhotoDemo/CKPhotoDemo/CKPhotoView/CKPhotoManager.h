//
//  CKPhotoManager.h
//  CKPhotoDemo
//
//  Created by 钰龙徐 on 2016/12/28.
//  Copyright © 2016年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

typedef void(^CKPhotoAllAssetBlock)(NSArray <PHAsset *> *assets);
typedef void(^CKPhotoAllThumbnailBlock)(NSArray <UIImage *> *images);

//typedef void(^CKPhotoAllAlbumBlock)(NSArray <>);

@interface CKPhotoManager : NSObject

+ (instancetype)sharedMangaer;
@property (nonatomic, weak, readonly) PHCachingImageManager *imageManager;

+ (PHAuthorizationStatus)authorizationStatus;

- (void)fetchAllThumbnailPhotoWithImageSize:(CGSize)size completionHandler:(CKPhotoAllThumbnailBlock)handler;

- (void)fetchAllPhotoWithCompletionHandler:(CKPhotoAllAssetBlock)handler;

//- (void)fetchAllAlbumsWithCompletionHandler:()

@end
