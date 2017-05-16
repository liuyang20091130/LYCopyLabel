//
//  LYCopyLabel.m
//  LYCopyLabel
//
//  Created by Liu,Yang on 2017/5/12.
//  Copyright © 2017年 liuyang625. All rights reserved.
//

#import "LYCopyLabel.h"

#define kDefalutBGColor  [UIColor lightGrayColor]

@interface LYCopyLabel ()

@property (nonatomic, strong) UIColor *normalBackgroundColor; // use to record backgroundClor
@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;
@property (nonatomic, assign ,getter=isSelecetd) BOOL selected;


@end

@implementation LYCopyLabel

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _copyingEnable = YES;
        _selectedBackgroundColor = kDefalutBGColor;
        [self addLongPressGestureRecognizer];
        

    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _copyingEnable = YES;
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
    return _copyingEnable;
}

// can response to copy method
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return (action == @selector(_lyCopy:) && _copyingEnable)||[super canPerformAction:action withSender:sender];
}

#pragma mark - Access Methods

- (void)setCopyingEnable:(BOOL)copyingEnable {
    _copyingEnable = copyingEnable;
    _longPress.enabled = copyingEnable;
}

#pragma mark - Private Methods

// copy text to pasteboard
-(void)_lyCopy:(id)sender {
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = self.text;
}

// add long press gesture reconizer
-(void)addLongPressGestureRecognizer {
    self.userInteractionEnabled = YES;  // enable user interaction
    UILongPressGestureRecognizer *touch = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [self addGestureRecognizer:touch];
    self.longPress = touch;
    self.longPress.enabled = self.copyingEnable;
    
    self.normalBackgroundColor = self.backgroundColor;
}



-(void)handleLongPress:(UIGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self becomeFirstResponder];
        [self addMenuNotification];
        UIMenuItem *copyLink = [[UIMenuItem alloc] initWithTitle:[self copyTitle] action:@selector(_lyCopy:)];
        [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:copyLink, nil]];
        [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
        [[UIMenuController sharedMenuController] setMenuVisible:YES animated: YES];
        [self menuWillAppear];
    }
    
}

- (NSString *)copyTitle {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"LYCopyLabel" ofType:@"bundle"];
    NSBundle *bundle1 = [NSBundle bundleWithPath:bundlePath];
    NSString *str = [bundle1 localizedStringForKey:@"Copy" value:@"Copy" table:nil];
    return str;
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
