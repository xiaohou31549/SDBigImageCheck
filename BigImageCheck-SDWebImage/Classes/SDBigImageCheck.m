//
//  SDBigImageCheck.m
//  BigImageCheck-SDWebImage
//
//  Created by tough on 2021/9/1.
//

#import "SDBigImageCheck.h"
#import "SDWebImageDownloader+BigImageCheck.h"
#import "SDWebImageCompat.h"

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
        [SDWebImageDownloader startSwizzle];
    })
}

@end
