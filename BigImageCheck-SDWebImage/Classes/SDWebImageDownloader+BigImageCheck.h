//
//  SDWebImageDownloader+BigImageCheck.h
//
//  Created by tough on 2021/8/25.
//  Copyright © 2021 developer. All rights reserved.
//

#ifdef DEBUG

#import "SDWebImageDownloader.h"


NS_ASSUME_NONNULL_BEGIN

@interface SDWebImageDownloader (BigImageCheck)

+ (void)startSwizzle;

@end

NS_ASSUME_NONNULL_END

#endif
