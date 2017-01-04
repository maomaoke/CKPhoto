//
//  CKAlbum.m
//  CKPhotoDemo
//
//  Created by 钰龙徐 on 2017/1/3.
//  Copyright © 2017年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

#import "CKAlbum.h"
#import <Photos/Photos.h>

@implementation CKAlbum

- (instancetype)initWithFetchResult:(PHFetchResult *)result name:(NSString *)name {
    if (self = [super init]) {
        _fetchResult = result;
        _name = name;
        _photoCounts = result.count;
    }
    return self;
}

@end
