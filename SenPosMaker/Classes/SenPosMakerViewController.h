//
//  SenPosMakerViewController.h
//  SenPosMaker
//
//  Created by 田中郁也 on 2013/03/21.
//  Copyright (c) 2013年 田中郁也. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PosterViewController.h"
#import "AlertUtil.h"

@interface SenPosMakerViewController : UIViewController
<
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate,
    PosterViewControllerDelegate,
    UITextFieldDelegate
>
{
    IBOutlet UITextField *txtName_;
	UIAlertView     *indicatorAlert_;
}

// カメラボタン押下時
- (IBAction)btnCamClick:(id)sender;

// 画像選択ボタン押下時
- (IBAction)btnFileClick:(id)sender;

- (void)callImagePicker:(UIImagePickerControllerSourceType)sourceType;

@end
