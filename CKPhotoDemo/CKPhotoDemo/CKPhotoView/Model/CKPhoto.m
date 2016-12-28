//
//  CKPhoto.m
//  CKPhotoDemo
//
//  Created by 钰龙徐 on 2016/12/22.
//  Copyright © 2016年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

#import "CKPhoto.h"

@implementation CKPhoto

- (id)copyWithZone:(NSZone *)zone {
    CKPhoto *obj = [[CKPhoto alloc] init];
    obj.image = self.image;
    obj.photoType = self.photoType;
    return obj;
}


@end
