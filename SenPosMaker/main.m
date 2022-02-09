//
//  main.m
//  SenPosMaker
//
//  Created by 田中郁也 on 2013/03/21.
//  Copyright (c) 2013年 田中郁也. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SenPosMakerAppDelegate.h"

int main(int argc, char *argv[])
{
    @autoreleasepool {
        @try {
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([SenPosMakerAppDelegate class]));
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception);
        }
//        return UIApplicationMain(argc, argv, nil, NSStringFromClass([SenPosMakerAppDelegate class]));
    }
}
