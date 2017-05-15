//
//  LYActionLabel.m
//  CopyLabel
//
//  Created by Liu,Yang on 2017/5/15.
//  Copyright © 2017年 liuyang625. All rights reserved.
//

#import "LYActionLabel.h"
#import <objc/runtime.h>

#define kDefalutBGColor  [UIColor lightGrayColor]

static NSString * const kActionItemUniquePrefix = @"lyActionItem";

@interface LYLabelActionItem ()

@property (nonatomic, weak) LYActionLabel *actionLabel;

@end

@implementation LYLabelActionItem

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (instancetype)actionItemWithTitle:(NSString *)title block:(LYLabelActionBlock)block {
    if (!title || !block) {
        return nil;
    }
    LYLabelActionItem *item = [[LYLabelActionItem alloc] init];
    item.title = title;
    item.block = block;
    return item;
}

@end



@interface LYActionLabel ()

@property (nonatomic, strong) UIColor *normalBackgroundColor; // use to record backgroundClor
@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;
@property (nonatomic, assign ,getter=isSelecetd) BOOL selected;


@end


@interface LYActionLabelActionAdapter : NSObject
@property (nonatomic, weak) LYActionLabel *actionLabel;

@end


@implementation LYActionLabel

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _actionEnable = YES;
        _selectedBackgroundColor = kDefalutBGColor;
        [self addLongPressGestureRecognizer];
        
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _actionEnable = YES;
        _selectedBackgroundColor = kDefalutBGColor;
        [self addLongPressGestureRecognizer];
    }
    return self;
}

- (void)dealloc {
    [self removeMenuNotification];
}

#pragma mark - Overid

// overid  record backgroundColor to normalBackgroundColor
- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    if (!self.selected) {
        self.normalBackgroundColor = self.backgroundColor;
    }
}

// must be YES
- (BOOL)canBecomeFirstResponder {
    return _actionEnable ;//&& _actionItems.count;
}

// can response to copy method
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    NSLog(@"%s %@",__func__, NSStringFromSelector(action));
    return ([NSStringFromSelector(action) hasPrefix:kActionItemUniquePrefix] && _actionEnable);// || [super canPerformAction:action withSender:sender];
}

- (id)forwardingTargetForSelector:(SEL)sel {
    NSLog(@"%s %@",__func__, NSStringFromSelector(sel));
    return [super forwardingTargetForSelector:sel];
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@"%s %@",__func__, NSStringFromSelector(sel));
    NSString *str = NSStringFromSelector(sel);
    if ([str hasPrefix:kActionItemUniquePrefix]) {
        class_addMethod([self class], sel, (IMP)lyActionHandler, "v:@");
    }
    return [super resolveInstanceMethod:sel];
}

#pragma mark - Access Methods

- (void)setActionEnable:(BOOL)actionEnable {
    _actionEnable = actionEnable;
    _longPress.enabled = actionEnable;
}


void lyActionHandler(id self, SEL _cmd) {
    NSLog(@"%s %@",__func__, NSStringFromSelector(_cmd));
    NSString *cmd = NSStringFromSelector(_cmd);
    if (![cmd hasPrefix:kActionItemUniquePrefix] || cmd.length <= kActionItemUniquePrefix.length) {
        return;
    }
    NSString *indexStr = [cmd substringFromIndex:kActionItemUniquePrefix.length];
    NSInteger index = [indexStr integerValue];
    NSArray<LYLabelActionItem *>*actionItems = [self actionItems];
    if (index >= actionItems.count) {
        return;
    }
    LYLabelActionItem *item = actionItems[index];
    if (item.block) {
        item.block(self);
    }
}

#pragma mark - Private Methods

// copy text to pasteboard
-(void)_lyCopy:(id)sender {
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = self.text;
}

- (void)_lyActionHandler:(id)sender {
    NSLog(@"%s %@",__func__, NSStringFromSelector(_cmd));
}

// add long press gesture reconizer
-(void)addLongPressGestureRecognizer {
    self.userInteractionEnabled = YES;  // enable user interaction
    UILongPressGestureRecognizer *touch = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [self addGestureRecognizer:touch];
    self.longPress = touch;
    self.longPress.enabled = self.actionEnable;
    
    self.normalBackgroundColor = self.backgroundColor;
}



-(void)handleLongPress:(UIGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        NSLog(@"%s \n",__func__);
        
        if (!_actionItems.count) {
            return;
        }
        
        [self becomeFirstResponder];
        [self addMenuNotification];
        NSMutableArray *menuItems = [NSMutableArray array];
        for (int i = 0; i < _actionItems.count; i++) {
            LYLabelActionItem *actionItem = _actionItems[i];
            UIMenuItem *item = [[UIMenuItem alloc] initWithTitle:actionItem.title action:NSSelectorFromString([NSString stringWithFormat:@"%@%d", kActionItemUniquePrefix,i])];
            [menuItems addObject:item];
            
        }
        [[UIMenuController sharedMenuController] setMenuItems:menuItems];
        [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
        [[UIMenuController sharedMenuController] setMenuVisible:YES animated: YES];
        [self menuWillAppear];
    }
    
}

#pragma mark - menu show & hide handle

- (void)menuWillAppear {
    self.selected = YES;
    if (self.selectedBackgroundColor) {
        self.backgroundColor = self.selectedBackgroundColor;
    }
}

- (void)menuWillDisappear {
    self.backgroundColor = self.normalBackgroundColor;
    [self removeMenuNotification];
    self.selected = NO;
}

- (void)addMenuNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuWillDisappear) name:UIMenuControllerWillHideMenuNotification object:nil];
}

- (void)removeMenuNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIMenuControllerWillHideMenuNotification object:nil];
}

@end
