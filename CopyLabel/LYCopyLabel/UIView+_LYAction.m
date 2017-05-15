//
//  UIView+_LYAction.m
//  CopyLabel
//
//  Created by Liu,Yang on 2017/5/15.
//  Copyright © 2017年 liuyang625. All rights reserved.
//

#import "UIView+_LYAction.h"
#import <objc/runtime.h>

// check字符串
#define CHECK_STRING_VALID(targetString)				\
(targetString != nil && [targetString isKindOfClass:[NSString class]] && [targetString length] > 0)

#define CHECK_STRING_INVALID(targetString)              \
(targetString == nil || ![targetString isKindOfClass:[NSString class]] || [targetString length] == 0)

@implementation UIView (_LYAction)

- (NSMutableArray *)lyActions {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setLyActions:(NSMutableArray *)dic {
    objc_setAssociatedObject(self, @selector(lyActionsDictionary), dic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)addActionWithMenuTitle:(NSString *)title callback:(void(^)(UIView *view))block {
    NSMutableArray *actions = [self lyActions];
    if (actions == nil) {
        actions = [NSMutableArray array];
        [self setLyActions:actions];
    }
    
    if (CHECK_STRING_INVALID(title) || block == nil) {
        return;
    }
    
    
}

- (void)lySetActions {
    
}

@end
