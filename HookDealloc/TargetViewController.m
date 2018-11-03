//
//  TargetViewController.m
//  HookDealloc
//
//  Created by YY on 2018/11/2.
//  Copyright © 2018 YY. All rights reserved.
//

#import "TargetViewController.h"

@interface TargetViewController ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation TargetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(runloop) userInfo:nil repeats:YES];
}

- (void)runloop{
    NSLog(@"run");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
