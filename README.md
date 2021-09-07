# BigImageCheck-SDWebImage

[![CI Status](https://img.shields.io/travis/lijun6/BigImageCheck-SDWebImage.svg?style=flat)](https://travis-ci.org/lijun6/BigImageCheck-SDWebImage)
[![Version](https://img.shields.io/cocoapods/v/BigImageCheck-SDWebImage.svg?style=flat)](https://cocoapods.org/pods/BigImageCheck-SDWebImage)
[![License](https://img.shields.io/cocoapods/l/BigImageCheck-SDWebImage.svg?style=flat)](https://cocoapods.org/pods/BigImageCheck-SDWebImage)
[![Platform](https://img.shields.io/cocoapods/p/BigImageCheck-SDWebImage.svg?style=flat)](https://cocoapods.org/pods/BigImageCheck-SDWebImage)

### BigImageCheck-SDWebImage

检测SDWebImage下载的大图，图片大小超过预定义大小，会在图片上显示“大图 + 图片尺寸”提醒文字，只在Debug下生效，方便开发期间监控大图。


### 接入

podfile
```
pod 'BigImageCheck-SDWebImage', '~> 0.1.3'
```


### 使用
在Appq启动逻辑中开启大图检测

```
#ifdef DEBUG
    [[SDBigImageCheck sharedInstance] start];
    //定义默认的大图大小(kb)，超过该大小就有大图提醒
    [SDBigImageCheck sharedInstance].normalImageMaxSize = 30.0;
    //定义默认的动图大图大小(kb)，超过该大小就有大图提醒
    [SDBigImageCheck sharedInstance].animateImageMaxSize = 60.0
#endif
```

如需在某些场景下关闭大图提醒（比如浏览原图），引入NSURL+BigImageCheck.h头文件，设置如下：
```
NSURL *url = [NSURL URLWithString:@"xxxxx"]
url.isCloseBigImageCheck = YES;
[imageView sd_setImageWithURL:url];
```

如需定制化设置大图定义，引入NSURL+BigImageCheck.h头文件，设置如下：
```
NSURL *url = [NSURL URLWithString:@"xxxxx"]
url.maxImageSize = 100.0;
[imageView sd_setImageWithURL:url];
```

