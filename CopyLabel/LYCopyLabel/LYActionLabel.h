//
//  LYActionLabel.h
//  CopyLabel
//
//  Created by Liu,Yang on 2017/5/15.
//  Copyright © 2017年 liuyang625. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LYLabelActionBlock)(UILabel *label);

@interface LYLabelActionItem : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) LYLabelActionBlock block;

+ (instancetype)actionItemWithTitle:(NSString *)title block:(LYLabelActionBlock)block;

@end

@interface LYActionLabel : UILabel
@property (nonatomic, assign) IBInspectable BOOL actionEnable; // defalut is YES
@property (nonatomic, strong) IBInspectable UIColor *selectedBackgroundColor; // default is grayColor
@property (nonatomic, assign, readonly ,getter=isSelecetd) BOOL selected;
@property (nonatomic, strong) NSArray<LYLabelActionItem *> *actionItems;

@end
