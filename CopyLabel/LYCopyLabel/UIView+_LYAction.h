//
//  UIView+_LYAction.h
//  CopyLabel
//
//  Created by Liu,Yang on 2017/5/15.
//  Copyright © 2017年 liuyang625. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (_LYAction)
- (void)addAction:(NSString *)identifer menuTitle:(NSString *)title callback:(void(^)(UIView *view))block;
@end
