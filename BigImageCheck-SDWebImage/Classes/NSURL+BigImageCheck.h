//
//  NSURL+BigImageCheck.h
//
//  Created by tough on 2021/8/31.
//  Copyright © 2021 developer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (BigImageCheck)

@property (nonatomic, assign) BOOL isCloseBigImageCheck;

//最大的图片大小，单位kb，超过该大小才会提醒
@property (nonatomic, assign) CGFloat maxImageSize;

@end

NS_ASSUME_NONNULL_END
