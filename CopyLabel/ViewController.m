//
//  ViewController.m
//  CopyLabel
//
//  Created by Liu,Yang on 2017/5/12.
//  Copyright © 2017年 liuyang625. All rights reserved.
//

#import "ViewController.h"
#import "LYCopyLabel.h"
#import "LYActionLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    {
        LYActionLabel *label = [[LYActionLabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 100, 200, 80)];
        label.text = @"LYActionLabel";
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];
        label.center = CGPointMake(self.view.center.x, label.center.y);
        __weak typeof(self)weakSelf = self;
        LYLabelActionItem *copy = [LYLabelActionItem actionItemWithTitle:NSLocalizedString(@"Copy", nil)
                                                                   block:^(UILabel *label) {
                                                                       NSLog(@"%@ click",NSLocalizedString(@"Copy", nil));
                                                                       UIPasteboard *pboard = [UIPasteboard generalPasteboard];
                                                                       pboard.string = label.text;
                                                                   }];
        LYLabelActionItem *report = [LYLabelActionItem actionItemWithTitle:NSLocalizedString(@"Report", nil)
                                                                   block:^(UILabel *label) {
                                                                       NSLog(@"%@ click",NSLocalizedString(@"Report", nil));
                                                                       [weakSelf showAlert:@"Report selected"];
                                                                   }];
        
        NSArray *menuItems = @[copy, report];
        label.actionItems = menuItems;
        
        
    }
    
    {
        LYCopyLabel *label = [[LYCopyLabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 200, 200, 80)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"enable on ; selectedBCColor  seted; created by code";
        label.numberOfLines = 0;
        [self.view addSubview:label];
        label.center = CGPointMake(self.view.center.x, label.center.y);
    }
}

- (void)showAlert:(NSString *)massage {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                             message:massage
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"cancle" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
