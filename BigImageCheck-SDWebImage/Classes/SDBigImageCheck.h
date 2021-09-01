//
//  SDBigImageCheck.h
//  BigImageCheck-SDWebImage
//
//  Created by tough on 2021/9/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SDBigImageCheck : NSObject

@property (nonatomic, assign) CGFloat normalImageMaxSize;
@property (nonatomic, assign) CGFloat animateImageMaxSize;

+ (instancetype)sharedInstance;

- (void)start;

@end

NS_ASSUME_NONNULL_END
