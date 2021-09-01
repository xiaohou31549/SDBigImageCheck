//
//  SDBigImageCheck.m
//  BigImageCheck-SDWebImage
//
//  Created by tough on 2021/9/1.
//

#import "SDBigImageCheck.h"
#import "SDWebImageDownloader+BigImageCheck.h"
#import <SDWebImage/SDWebImage.h>
#import "BigImageCheckSwizzle.h"

@implementation SDBigImageCheck

+ (instancetype)sharedInstance
{
    static SDBigImageCheck *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)start
{
    dispatch_main_async_safe(^{
        [self startSwizzle];
    })
}

- (void)startSwizzle
{
    SEL newSelector = @selector(bic_swizzle_sd_requestImageWithURL:options:context:progress:completed:);
    SEL originSelector = @selector(requestImageWithURL:options:context:progress:completed:);
    BigImageCheckSwizzleMethod(SDWebImageDownloader.class, originSelector, SDWebImageDownloader.class, newSelector);
}

@end
