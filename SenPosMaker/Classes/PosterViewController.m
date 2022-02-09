//
//  PosterViewController.m
//  SenPosMaker
//
//  Created by 田中郁也 on 2013/03/21.
//  Copyright (c) 2013年 田中郁也. All rights reserved.
//

#import "PosterViewController.h"

@implementation PosterViewController
@synthesize recvImage, canvas, delegate, name;

/**
 * インスタンス化時
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setCanvasImage];
    [self setName];
    [self setMsg];
}

/**
 * メモリ警告時zzzzs
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/**
 * 戻るボタン押下
 */
- (IBAction)btnBackClick:(id)sender
{
    [delegate posterViewController:self exit:YES];
}

/**
 * キャンバスの画像を設定する
 */
- (void)setCanvasImage
{
    [canvas setImage:recvImage];
}

/**
 * 名前を設定する
 */
- (void)setName
{
    // ラベル生成
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, 400, 400, 100);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blueColor];
    label.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:40];
    label.text = name;
    [canvas addSubview:label];
}

/**
 * メッセージを設定する
 */
- (void)setMsg
{
    // ラベル生成
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, 0, 400, 100);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor redColor];
    label.font = [UIFont fontWithName:@"uzura_font" size:40];
    label.text = @"だがそれがいい！";
    [canvas addSubview:label];
}
@end
