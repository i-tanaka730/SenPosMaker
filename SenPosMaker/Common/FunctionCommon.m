//
//  FunctionCommon.m
//  SenPosMaker
//
//  Created by 田中郁也 on 2013/04/03.
//  Copyright (c) 2013年 田中郁也. All rights reserved.
//

#import "FunctionCommon.h"

@implementation FunctionCommon

/**
 * iOSのバージョンを取得する
 */
+ (NSInteger)getIOSVersion
{
    LOG_CURRENT_METHOD;

    NSArray *aOsVersions = [[[UIDevice currentDevice]systemVersion] componentsSeparatedByString:@"."];
    int iOsVersionMajor = [[aOsVersions objectAtIndex:0] intValue];
    return iOsVersionMajor;
}

/**
 * iPhone5(4インチ)かどうか
 */
+ (bool)is4Inch
{
	LOG_CURRENT_METHOD;
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    bool is4Inch = (screenSize.width == 320.0 && screenSize.height == 568.0) ? YES : NO;
    return is4Inch;
}

@end
