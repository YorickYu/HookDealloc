//
//  UINavigationController+Leaks.m
//  HookDealloc
//
//  Created by YY on 2018/11/3.
//  Copyright © 2018 YY. All rights reserved.
//

#import "UINavigationController+Leaks.h"
#import "NSObject+Swizzle.h"
#import <objc/runtime.h>

@implementation UINavigationController (Leaks)
+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSelector:@selector(popViewControllerAnimated:) with:@selector(yy_popViewControllerAnimated:)];
    });
}

- (UIViewController *)yy_popViewControllerAnimated:(BOOL)animated {
    UIViewController *targetViewController = [self yy_popViewControllerAnimated:animated];
    extern const void *const kHasBeenPoppedKey;
    objc_setAssociatedObject(targetViewController, kHasBeenPoppedKey, @(YES), OBJC_ASSOCIATION_RETAIN);
    return targetViewController;
}
@end
