//
//  SignUpViewController.h
//  PicDiary
//
//  Created by Narendra Thapa on 2016-02-11.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@class SignUpViewController;

@protocol SignUpViewControllerDelegate <NSObject>

- (void)didSignedUp;

@end

@interface SignUpViewController : UIViewController

@property (nonatomic, weak) id <SignUpViewControllerDelegate> delegate;

@end
