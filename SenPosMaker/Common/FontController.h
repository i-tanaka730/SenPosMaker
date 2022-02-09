//
//  FontController.h
//  SenPosMaker
//
//  Created by 田中郁也 on 2013/03/28.
//  Copyright (c) 2013年 田中郁也. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MODE_HORIZONTAL 0;
#define MODE_VERTICAL 1;

@interface FontController : NSObject
{
    NSInteger   tmpMpde_;
}

- (void)addLabel:(UIImageView *)iv :(NSString*)str :(float)h;
- (CGRect)getRect :(UIImageView *)iv  :(float)h;
- (UIColor *)getColor;
- (UIFont *)getFontStyle;

@end
