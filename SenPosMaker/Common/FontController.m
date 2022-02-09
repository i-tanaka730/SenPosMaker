//
//  FontController.m
//  SenPosMaker
//
//  Created by 田中郁也 on 2013/03/28.
//  Copyright (c) 2013年 田中郁也. All rights reserved.
//

#import "FontController.h"
#import "FunctionCommon.h"

@implementation FontController

/**
 * ラベルを配置する
 */
- (void)addLabel:(UIImageView *)iv :(NSString*)str :(float)h
{
    LOG_CURRENT_METHOD;

    // 配置モード
    // TODO:縦モード未実装の為、今固定
    tmpMpde_ = MODE_HORIZONTAL;
    
    // ラベル生成
    UILabel *label = [[UILabel alloc] init];

    // 位置
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = [self getRect:iv :h];

    // フォント背景色
    label.backgroundColor = [UIColor clearColor];

    // フォント色
    label.textColor = [self getColor];

    // フォントスタイル
    label.font = [self getFontStyle];

    // ラベルに文字設定
    label.text = str;
    
    //自動縮小
    label.adjustsFontSizeToFitWidth = YES;
    

    // viewに配置
    [iv addSubview:label];
}

/**
 * 指定範囲の乱数を取得する
 */
-(int)getRandInt:(int)min max:(int)max {
	LOG_CURRENT_METHOD;
	static int randInitFlag;
	if (randInitFlag == 0) {
		srand(time(NULL));
		randInitFlag = 1;
	}
	return min + (int)(rand()*(max-min+1.0)/(1.0+RAND_MAX));
}

/**
 * Rect取得する
 */
- (CGRect)getRect :(UIImageView *)iv :(float)h
{
	LOG_CURRENT_METHOD;
    CGRect rect = CGRectMake(0,                    // 横位置
                             h,                     // 縦位置
                             iv.frame.size.width,   // 横サイズ
                             100);                  // 縦サイズ

    return rect;
}

/**
 * ランダムに色を取得する
 */
- (UIColor *)getColor {
	LOG_CURRENT_METHOD;

    NSInteger i = [self getRandInt:0 max:4];
    UIColor *col = [UIColor blackColor];

    switch (i) {
        case 0:
            col = [UIColor redColor];
            break;
        case 1:
            col = [UIColor blueColor];
            break;
        case 2:
            col = [UIColor greenColor];
            break;
        case 3:
            col = [UIColor purpleColor];
            break;
        case 4:
            col = [UIColor brownColor];
            break;
    }
    
    return col;
}

/**
 * ランダムにフォントスタイルを取得する
 */
- (UIFont *)getFontStyle
{
	LOG_CURRENT_METHOD;
    NSInteger i = [self getRandInt:0 max:3];
    NSString *str = @"uzura_font";
    
    switch (i) {
        case 0:
            str = @"uzura_font";
            break;
        case 1:
            //動作確認用サンプル 文字数少ないので、本番時には考慮が必要
            str = @"NtMotoyaMaru";
            break;
        case 2:
            str = @"ArialHebrew-Bold";
            break;
        case 3:
            str = @"Baskerville-Bold";
            break;
    }
    
    UIFont *font = [UIFont fontWithName:str size:50];
    return font;
}

@end
