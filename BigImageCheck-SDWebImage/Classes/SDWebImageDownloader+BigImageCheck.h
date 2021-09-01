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

- (id<SDWebImageOperation>)bic_swizzle_sd_requestImageWithURL:(NSURL *)url options:(SDWebImageOptions)options context:(SDWebImageContext *)context progress:(SDImageLoaderProgressBlock)progressBlock completed:(SDImageLoaderCompletedBlock)completedBlock;

@end

NS_ASSUME_NONNULL_END

#endif
