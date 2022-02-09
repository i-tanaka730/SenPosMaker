//
//  SenPosMakerAppDelegate.m
//  AlertUtil.m
//
//  Created by 田中郁也 on 2013/03/21.
//  Copyright (c) 2013年 田中郁也. All rights reserved.
//

#import "AlertUtil.h"


@implementation AlertUtil

+ (void)showAlert:(NSString *)title message:(NSString *)message
{
    LOG_CURRENT_METHOD;

	UIAlertView *alert = [[UIAlertView alloc] init];
	alert.delegate = nil;
	alert.title = title;
	alert.message = message;
	[alert addButtonWithTitle:NSLocalizedString(@"OK", @"")];
	[alert show];
}

+ (void)showOkCancel:(NSString*)title message:(NSString *)message delegate:(id)delegate
{
	LOG_CURRENT_METHOD;
	UIAlertView *alert = [[UIAlertView alloc] init];
	alert.delegate = delegate;
	alert.title = title;
	alert.message = message;
	[alert addButtonWithTitle:NSLocalizedString(@"OK", @"")];
	[alert addButtonWithTitle:NSLocalizedString(@"CANCEL", @"")];
	[alert show];
}

+ (UIAlertView *)showIndicator:(NSString *)title message:(NSString *)message
{
	LOG_CURRENT_METHOD;
	UIAlertView *alert = [[UIAlertView alloc] init];
	alert.delegate = nil;
	alert.title = title;
	alert.message = message;
	[alert show];
    
	UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] init];
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
	indicator.center = CGPointMake(alert.bounds.size.width / 2, alert.bounds.size.height - 50);
	[indicator startAnimating];
	[alert addSubview:indicator];

	return alert;
}

+ (void)dismissIndicator:(UIAlertView *)alert animated:(BOOL)animated
{
	LOG_CURRENT_METHOD;
	if (alert == nil) {
		return;
	}

	[alert dismissWithClickedButtonIndex:0 animated:animated];
}

@end
