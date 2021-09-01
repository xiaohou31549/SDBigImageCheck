//
//  BIViewController.m
//  BigImageCheck-SDWebImage
//
//  Created by lijun6 on 09/01/2021.
//  Copyright (c) 2021 lijun6. All rights reserved.
//

#import "BIViewController.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
#import "SDBigImageCheck.h"

@interface BIViewController ()

@end

@implementation BIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [SDBigImageCheck sharedInstance].normalImageMaxSize = 100.0;
    [[SDBigImageCheck sharedInstance] start];
    [self testBigImage];
    [self addRemoveCacheBtn];
}

- (void)testBigImage
{
    UIImageView *imageView = [UIImageView new];
    imageView.frame = CGRectMake(100, 300, 180, 100);
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"https://img-res.mejiaoyou.com/20200702181128229_bs2_format.jpg"]];
    
    [self.view addSubview:imageView];
}

- (void)addRemoveCacheBtn
{
    UIButton *btn = [UIButton new];
    btn.frame = CGRectMake(100, 450, 150, 44);
    [btn setTitle:@"清除SD磁盘缓存" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(removeCache:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = UIColor.grayColor;
    
    [self.view addSubview:btn];
}

- (void)removeCache:(UIButton *)sender
{
    [[SDImageCache sharedImageCache].diskCache removeAllData];
    [sender setTitle:@"缓存已清除" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
