//
//  NSObject+Swizzle.h
//  HookDealloc
//
//  Created by YY on 2018/11/2.
//  Copyright © 2018 YY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Swizzle)

+ (void)swizzleSelector:(SEL)orignSelector with:(SEL)swizzleSelector;
- (void)willDealloc;

@end

NS_ASSUME_NONNULL_END
