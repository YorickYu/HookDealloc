//
//  NSObject+Swizzle.m
//  HookDealloc
//
//  Created by YY on 2018/11/2.
//  Copyright © 2018 YY. All rights reserved.
//

#import "NSObject+Swizzle.h"
#import <objc/runtime.h>

@implementation NSObject (Swizzle)

+ (void)swizzleSelector:(SEL)orignSelector with:(SEL)swizzleSelector {
    Class class = [self class];

    Method orignalMethod = class_getInstanceMethod(class, orignSelector);
    Method swizzleMethod = class_getInstanceMethod(class, swizzleSelector);

    BOOL didAddMethod = class_addMethod(class, orignSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    if (didAddMethod) {
        class_replaceMethod(class, swizzleSelector, method_getImplementation(orignalMethod), method_getTypeEncoding(orignalMethod));
    }else {
        method_exchangeImplementations(orignalMethod, swizzleMethod);
    }
}

- (void)willDealloc {
    __weak id weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong id strongSelf = weakSelf;
        NSLog(@"leak : %@", NSStringFromClass([strongSelf class]));
    });
}

@end
