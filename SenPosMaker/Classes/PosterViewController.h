//
//  PosterViewController.h
//  SenPosMaker
//
//  Created by 田中郁也 on 2013/03/21.
//  Copyright (c) 2013年 田中郁也. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AlertUtil.h"
#import "FontController.h"

@protocol PosterViewControllerDelegate;

@interface PosterViewController : UIViewController
{
	UIAlertView     *indicatorAlert_;
    FontController  *fontController_;
}

// 保存ボタン押下時
- (IBAction)btnSaveClick:(id)sender;

// 投稿ボタン押下時
- (IBAction)btnshareClick:(id)sender;

// 戻るボタン押下時
- (IBAction)btnBackClick:(id)sender;

@property (nonatomic, assign) NSString *name;
@property (nonatomic, retain) UIImage *recvImage;
@property (nonatomic, retain) IBOutlet UIImageView *canvas;
@property (nonatomic, assign) id <PosterViewControllerDelegate> delegate;

@end

@protocol PosterViewControllerDelegate <NSObject>
- (void)posterViewController:(id)posterViewController exit:(BOOL)result;
@end