//
//  SignUpViewController.m
//  PicDiary
//
//  Created by Narendra Thapa on 2016-02-11.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()


@property (weak, nonatomic) IBOutlet UITextField *usernameSignUp;
@property (weak, nonatomic) IBOutlet UITextField *passwordSignUp1;
@property (weak, nonatomic) IBOutlet UITextField *passwordSignUp2;


@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
