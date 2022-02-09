//
//  SenPosMakerViewController.m
//  SenPosMaker
//
//  Created by 田中郁也 on 2013/03/21.
//  Copyright (c) 2013年 田中郁也. All rights reserved.
//

#import "SenPosMakerViewController.h"


@implementation SenPosMakerViewController

/**
 * インスタンス化時
 */
- (void)viewDidLoad
{
	LOG_CURRENT_METHOD;
    [super viewDidLoad];

    // テキストフィールドのデリゲートを設定
    txtName_.delegate = self;
    
    
    //名前の設定
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    txtName_.text = [ud stringForKey:USER_NAME];
    
}

/**
 * メモリ警告時
 */
- (void)didReceiveMemoryWarning
{
	LOG_CURRENT_METHOD;
    [super didReceiveMemoryWarning];
}

/**
 * キーボードリターン時
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	LOG_CURRENT_METHOD;
    [textField resignFirstResponder];
    return YES;
}

/**
 * カメラボタン押下
 */
- (IBAction)btnCamClick:(id)sender
{
	LOG_CURRENT_METHOD;
    
    //入力チェック
    if (![self isValidInput]) {
        return;
    }
    
	// カメラアプリを呼び出せるかをチェック
	if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		[AlertUtil showAlert:@"error" message:@"カメラが使用できません。"];
		return;
	}
    
	// インジケータ表示
	indicatorAlert_ = [AlertUtil showIndicator:@"起動中..." message:@""];
    
	// 別スレッドにてカメラアプリを起動
	[self performSelectorInBackground:@selector(cameraThread) withObject:nil];
}

/**
 * 画像選択ボタン押下
 */
- (IBAction)btnFileClick:(id)sender
{
	LOG_CURRENT_METHOD;
    
    //入力チェック
    if (![self isValidInput]) {
        return;
    }
    
	// 画像選択アプリを呼び出せるかをチェック
	if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
		[AlertUtil showAlert:@"error" message:@"画像が選択できません。"];
		return;
	}
    
	// 別スレッドにて画像選択アプリを起動
	[self performSelectorInBackground:@selector(fileListThread) withObject:nil];
}

/**
 * 共通入力チェック
 */
- (BOOL)isValidInput
{
    //名前の入力内容をトリム
    txtName_.text = [txtName_.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    //未入力チェック
	if ([txtName_.text isEqualToString:@""]) {
		[AlertUtil showAlert:@"error" message:@"あなたの名前を入力してください。"];
		return NO;
	}
    
    //名前の更新
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    [ud setObject:txtName_.text forKey:USER_NAME];
        
    return YES;
}


/**
 * カメラスレッド
 */
- (void)cameraThread
{
	LOG_CURRENT_METHOD;
	// カメラアプリ呼び出し
	[self callImagePicker:UIImagePickerControllerSourceTypeCamera];
	
	// スレッド終了処理
	[self performSelectorOnMainThread:@selector(finalizeThread) withObject:nil waitUntilDone:YES];
}

/**
 * ファイルスレッド
 */
- (void)fileListThread
{
	LOG_CURRENT_METHOD;
	// 画像選択アプリ呼び出し
	[self callImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
	
	// スレッド終了処理
    indicatorAlert_ = nil;
	[self performSelectorOnMainThread:@selector(finalizeThread) withObject:nil waitUntilDone:YES];
}

/**
 * スレッドの共通終了処理
 */
- (void)finalizeThread
{
	LOG_CURRENT_METHOD;
	// インジケータを非表示にする
	if (indicatorAlert_ != nil) {
		[AlertUtil dismissIndicator:indicatorAlert_ animated:YES];
	}
}

/**
 * イメージピッカー呼び出しを行う
 */
- (void)callImagePicker:(UIImagePickerControllerSourceType)sourceType
{
	LOG_CURRENT_METHOD;
	UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
	imagePicker.sourceType = sourceType;
	imagePicker.delegate = self;
    [self presentViewController: imagePicker animated:YES completion: nil];
}

/**
 * カメラ撮影後
 */
- (void)imagePickerController:(UIImagePickerController*)picker	didFinishPickingImage:(UIImage*)image editingInfo:(NSDictionary*)info
{
	LOG_CURRENT_METHOD;
	PosterViewController *vc = [[PosterViewController alloc] initWithNibName:@"PosterViewController" bundle:nil];
    vc.name = txtName_.text;
	vc.delegate = self;
	vc.recvImage = image;
	[picker presentModalViewController:vc animated:YES];
}

/**
 * posterViewControllerデリゲート
 */
- (void)posterViewController:(PosterViewController *)posterViewController exit:(BOOL)result
{
	LOG_CURRENT_METHOD;
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
