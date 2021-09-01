//
//  NSURL+BigImageCheck.m
//
//  Created by tough on 2021/8/31.
//  Copyright © 2021 developer. All rights reserved.
//

#import "NSURL+BigImageCheck.h"
#import <objc/runtime.h>

@implementation NSURL (BigImageCheck)

- (void)setIsCloseBigImageCheck:(BOOL)isCloseBigImageCheck
{
    objc_setAssociatedObject(self, @selector(isCloseBigImageCheck), @(isCloseBigImageCheck), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)isCloseBigImageCheck
{
    NSNumber *isCloseNum = objc_getAssociatedObject(self, _cmd);
    return isCloseNum && isCloseNum.boolValue;
}

- (void)setMaxImageSize:(CGFloat)maxImageSize
{
    objc_setAssociatedObject(self, @selector(maxImageSize), @(maxImageSize), OBJC_ASSOCIATION_RETAIN);
}

- (CGFloat)maxImageSize
{
    NSNumber *sizeNum = objc_getAssociatedObject(self, _cmd);
    CGFloat result = sizeNum ? sizeNum.floatValue : 0.0;
    return result;
}



@end
