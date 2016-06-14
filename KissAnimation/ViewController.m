//
//  ViewController.m
//  KissAnimation
//
//  Created by wangshuo on 16/6/14.
//  Copyright © 2016年 wangshuo. All rights reserved.
//

#import "ViewController.h"
#import "WASKissAnimation.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    

    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [WASKissAnimation kissAnimationShowUpInCALayer:self.view.layer userIcon:[UIImage imageNamed:@"qqqq"] bannerText:@"土豪送了大礼" landscape:YES complete:^{
        NSLog(@" ----动画结束---- ");
    }];
}

@end
