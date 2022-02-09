//
//  AlertUtil.h
//  RakugakiCamera
//
//  Created by USER on 11/09/28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertUtil : NSObject
{

}

+ (void)showAlert:(NSString *)title message:(NSString *)message;
+ (void)showOkCancel:(NSString *)title message:(NSString *)message delegate:(id)delegate;
+ (UIAlertView *)showIndicator:(NSString *)title message:(NSString *)message;
+ (void)dismissIndicator:(UIAlertView *)alert animated:(BOOL)animated;

@end
