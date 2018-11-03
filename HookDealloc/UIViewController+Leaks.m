//
//  UIViewController+Leaks.m
//  HookDealloc
//
//  Created by YY on 2018/11/2.
//  Copyright © 2018 YY. All rights reserved.
//

#import "UIViewController+Leaks.h"
#import "NSObject+Swizzle.h"
#import <objc/runtime.h>

const void *const kHasBeenPoppedKey = &kHasBeenPoppedKey;

@implementation UIViewController (Leaks)

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSelector:@selector(viewWillAppear:) with:@selector(yy_viewWillAppear:)];
        [self swizzleSelector:@selector(viewDidDisappear:) with:@selector(yy_viewDidDisappear:)];
    });
}

- (void)yy_viewWillAppear:(BOOL)animated {
    [self yy_viewWillAppear:animated];
    objc_setAssociatedObject(self, kHasBeenPoppedKey, @(NO), OBJC_ASSOCIATION_RETAIN);
}


- (void)yy_viewDidDisappear:(BOOL)animated {
    [self yy_viewDidDisappear:animated];
    if ([objc_getAssociatedObject(self, kHasBeenPoppedKey) boolValue]) {
        [self willDealloc];
    }
}

@end
