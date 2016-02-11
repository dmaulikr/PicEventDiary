//
//  LoginViewController.h
//  PicDiary
//
//  Created by Narendra Thapa on 2016-02-11.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginViewController;

@protocol LoginViewControllerDelegate <NSObject>

- (void)didPressLogin;
- (void)didPressSignUp;

@end

@interface LoginViewController : UIViewController

@property (nonatomic, weak) id <LoginViewControllerDelegate> delegate;

@end
