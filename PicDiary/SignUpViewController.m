//
//  SignUpViewController.m
//  PicDiary
//
//  Created by Narendra Thapa on 2016-02-11.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

#import "SignUpViewController.h"
#import "AppDelegate.h"
#import "User.h"

@interface SignUpViewController ()


@property (weak, nonatomic) IBOutlet UITextField *usernameSignUp;
@property (weak, nonatomic) IBOutlet UITextField *passwordSignUp1;
@property (weak, nonatomic) IBOutlet UITextField *passwordSignUp2;

@property (nonatomic) NSManagedObjectContext *managedObjectContext;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.usernameSignUp resignFirstResponder];
    [self.passwordSignUp1 resignFirstResponder];
    [self.passwordSignUp2 resignFirstResponder];
}

- (IBAction)didPressSignUp:(id)sender {
    
    if ([self.passwordSignUp1.text isEqualToString:self.passwordSignUp2.text]) {
    
    NSManagedObjectContext *context = self.managedObjectContext;
    
    User *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    
    newManagedObject.username = self.usernameSignUp.text;
    newManagedObject.password = self.passwordSignUp1.text;
    newManagedObject.signedIn = YES;
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
//    int controllerIndex = 0;
//    UITabBarController *tabBarController = self.tabBarController;
//    UIView * fromView = tabBarController.selectedViewController.view;
//    UIView * toView = [[tabBarController.viewControllers objectAtIndex:controllerIndex] view];
//    
//    // Transition using a page curl.
//    [UIView transitionFromView:fromView
//                        toView:toView
//                      duration:0.5
//                       options:(controllerIndex > tabBarController.selectedIndex ? UIViewAnimationOptionTransitionCurlUp : UIViewAnimationOptionTransitionCurlDown)
//                    completion:^(BOOL finished) {
//                        if (finished) {
//                            tabBarController.selectedIndex = controllerIndex;
//                        }
//                    }];
    
    self.usernameSignUp.text = @"";
    self.passwordSignUp1.text = @"";
    self.passwordSignUp2.text = @"";

        [self.delegate didSignedUp];
    }
    else {
        NSLog(@"Passwords do not match");
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
