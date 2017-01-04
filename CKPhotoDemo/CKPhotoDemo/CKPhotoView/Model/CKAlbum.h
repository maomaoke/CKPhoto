//
//  CKAlbum.h
//  CKPhotoDemo
//
//  Created by 钰龙徐 on 2017/1/3.
//  Copyright © 2017年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PHFetchResult;

@interface CKAlbum : NSObject

/**
 相册中的资源结果集
 */
@property (nonatomic, strong) PHFetchResult *fetchResult;

/**
 相册名称
 */
@property (nonatomic, copy) NSString *name;

/**
 相册中图片数量
 */
@property (nonatomic, assign, readonly) NSUInteger photoCounts;

- (instancetype)initWithFetchResult:(PHFetchResult *)result name:(NSString *)name;

@end
