//
//  LYLYCopyLabel.h
//  LYCopyLabel
//
//  Created by Liu,Yang on 2017/5/12.
//  Copyright © 2017年 liuyang625. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYCopyLabel : UILabel
@property (nonatomic, assign) IBInspectable BOOL copyingEnable; // defalut is YES
@property (nonatomic, strong) IBInspectable UIColor *selectedBackgroundColor; // default is grayColor
@property (nonatomic, assign, readonly ,getter=isSelecetd) BOOL selected;


@end
