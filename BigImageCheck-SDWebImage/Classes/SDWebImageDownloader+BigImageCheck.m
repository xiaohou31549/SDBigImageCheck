//
//  SDWebImageDownloader+BigImageCheck.m
//
//  Created by tough on 2021/8/25.
//  Copyright © 2021 developer. All rights reserved.
//

#ifdef DEBUG

#import "SDWebImageDownloader+BigImageCheck.h"
#import <SDWebImage/SDWebImage.h>
#import "NSURL+BigImageCheck.h"
#import "SDBigImageCheck.h"

static CGFloat const kNormalImageDefaultMaxSize = 30;
static CGFloat const kAnimateImageDefaultMaxSize = 50;


@implementation SDWebImageDownloader (BigImageCheck)

- (id<SDWebImageOperation>)bic_swizzle_sd_requestImageWithURL:(NSURL *)url options:(SDWebImageOptions)options context:(SDWebImageContext *)context progress:(SDImageLoaderProgressBlock)progressBlock completed:(SDImageLoaderCompletedBlock)completedBlock {
    return [self bic_swizzle_sd_requestImageWithURL:url options:options context:context progress:progressBlock completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        
        BOOL isCheckBigImage = !url.isCloseBigImageCheck;
        BOOL isBigImage = NO;
        CGFloat imageSize = data.length / 1024.0;
        if (isCheckBigImage && image && data) {
            BOOL isAminateImage = image.images != nil;
            if (isAminateImage) {
                CGFloat maxSize = [self bic_getMaxSizeWithURL:url isAnimate:YES];
                if (imageSize >= maxSize) {
                    isBigImage = YES;
                }
            } else {
                CGFloat maxSize = [self bic_getMaxSizeWithURL:url isAnimate:NO];
                if (imageSize >= maxSize) {
                    isBigImage = YES;
                }
            }
        }
        
        if (isBigImage) {
            [self bic_createNewImageWithOriginImage:image size:imageSize completion:^(UIImage *newImage, NSData *newData) {
                if (completedBlock) {
                    completedBlock(newImage, newData, error, finished);
                }
            }];
        } else {
            if (completedBlock) {
                completedBlock(image, data, error, finished);
            }
        }
    }];
}

- (CGFloat)bic_getMaxSizeWithURL:(NSURL *)url isAnimate:(BOOL)isAnimate
{
    CGFloat customMaxSize = url.maxImageSize;
    if (customMaxSize > 0) {
        return customMaxSize;
    } else {
        if (isAnimate) {
            CGFloat setupAnimateMaxSize = [SDBigImageCheck sharedInstance].animateImageMaxSize;
            return setupAnimateMaxSize > 0 ? setupAnimateMaxSize : kAnimateImageDefaultMaxSize;
        } else {
            CGFloat setupNormalMaxSize = [SDBigImageCheck sharedInstance].normalImageMaxSize;
            return setupNormalMaxSize > 0 ? setupNormalMaxSize : kNormalImageDefaultMaxSize;
        }
    }
}

- (void)bic_createNewImageWithOriginImage:(UIImage *)image size:(CGFloat)size completion:(void(^)(UIImage *newImage, NSData *newData))completion
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *imageResult = image;
        BOOL isAminateImage = image.images != nil;
        if (isAminateImage) {
            imageResult = [self bic_createAnimateRemindImageWithOriginImage:image imageSize:size];
        } else {
            imageResult = [self bic_createRemindImageWithOriginImage:image size:size];
        }
        
        //把有大图提醒的image赋值给data，data会写入到磁盘缓存，不然下次启动的时候没有大图提醒
        NSData *imageData = [self bic_createImageDataWithImage:imageResult];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(imageResult, imageData);
            }
        });
    });
}

- (UIImage *)bic_createRemindImageWithOriginImage:(UIImage *)image size:(CGFloat)size
{
    if (image) {
        CGFloat width = image.size.width;
        CGFloat height = image.size.height;
        CGFloat fontSize = (width + height) / 20;
        if (fontSize < 12.0) {
            fontSize = 12.0;
        }
        
        CGFloat scale = [UIScreen mainScreen].scale;
        NSDictionary *attrDict = @{NSForegroundColorAttributeName:[UIColor redColor],
                                   NSFontAttributeName:[UIFont systemFontOfSize:fontSize weight:UIFontWeightBold]};
        UIGraphicsBeginImageContextWithOptions(image.size, NO, scale);
        [image drawInRect:CGRectMake(0, 0, width, height)];
        NSString *remindStr = [NSString stringWithFormat:@"大图\n%@kb", @(@(size).integerValue)];
        CGSize strSize = [remindStr sizeWithAttributes:attrDict];
        CGPoint strOrigin = CGPointMake(width / 2 - strSize.width / 2, height / 2 - strSize.height / 2);
        [remindStr drawAtPoint:strOrigin withAttributes:attrDict];
        UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImg;
    }
    return image;
}

- (UIImage *)bic_createAnimateRemindImageWithOriginImage:(UIImage *)image imageSize:(CGFloat)size
{
    NSMutableArray<UIImage *> *tmpArray = [NSMutableArray new];
    for (UIImage *frameImage in image.images) {
        UIImage *newImage = [self bic_createRemindImageWithOriginImage:frameImage size:size];
        [tmpArray addObject:newImage];
    }
    UIImage *result = [UIImage animatedImageWithImages:[tmpArray copy] duration:image.duration];
    return result;
}

- (NSData *)bic_createImageDataWithImage:(UIImage *)image
{
    NSData *data = nil;
    if ([image conformsToProtocol:@protocol(SDAnimatedImage)]) {
        data = [((id<SDAnimatedImage>)image) animatedImageData];
    } else {
        SDImageFormat format = image.sd_imageFormat;
        if (format == SDImageFormatUndefined) {
            if (image.sd_isAnimated) {
                format = SDImageFormatGIF;
            } else {
                if ([SDImageCoderHelper CGImageContainsAlpha:image.CGImage]) {
                    format = SDImageFormatPNG;
                } else {
                    format = SDImageFormatJPEG;
                }
            }
        }
        data = [[SDImageCodersManager sharedManager] encodedDataWithImage:image format:format options:nil];
    }
    return data;
}

@end

#endif
