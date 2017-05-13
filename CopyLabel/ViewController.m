//
//  ViewController.m
//  CopyLabel
//
//  Created by Liu,Yang on 2017/5/12.
//  Copyright © 2017年 liuyang625. All rights reserved.
//

#import "ViewController.h"
#import "LYCopyLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    LYCopyLabel *label = [[LYCopyLabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 100, 200, 80)];
    label.backgroundColor = [UIColor redColor];
    label.text = @"enable on ; selectedBCColor  seted; created by code";
    label.selectedBackgroundColor = [UIColor yellowColor];
    label.numberOfLines = 0;
    [self.view addSubview:label];
    label.center = CGPointMake(self.view.center.x, label.center.y);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
