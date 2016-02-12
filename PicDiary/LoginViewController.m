//
//  LoginViewController.m
//  PicDiary
//
//  Created by Narendra Thapa on 2016-02-11.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "User.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameLogin;
@property (weak, nonatomic) IBOutlet UITextField *passwordLogin;

@property (nonatomic) NSMutableArray *users;
@property (nonatomic) NSMutableSet *userSet;

@property (nonatomic) NSManagedObjectContext *managedObjectContext;

@property (nonatomic) BOOL found;

@property (nonatomic) User *activeUser;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.found = NO;
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    self.users = [[NSMutableArray alloc] init];
    
    self.activeUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    
    //self.activeUser = [[User alloc] init];
    
    NSError *errU = nil;
    NSFetchRequest *fetchRequestU = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityU = [NSEntityDescription entityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    [fetchRequestU setEntity:entityU];
    
    NSArray *users = [self.managedObjectContext executeFetchRequest:fetchRequestU error:&errU];
    self.users = [users mutableCopy];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.usernameLogin resignFirstResponder];
    [self.passwordLogin resignFirstResponder];
}

- (IBAction)didPressLogin:(id)sender {
    
    for (User *user in self.users) {
        if ([user.username isEqualToString:self.usernameLogin.text] && [user.password isEqualToString:self.passwordLogin.text]) {
            self.found = YES;
            self.activeUser = user;
            self.activeUser.signedIn = YES;
            
            NSError *error = nil;
            if (![self.managedObjectContext save:&error]) {
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }
        }
    }
    if (!self.found) {
        NSLog(@"Account does not exist");
    } else {
        NSLog(@"Account found");
        [self.delegate didPressLogin];
    }
}


- (IBAction)didPressSignUp:(UIButton *)sender {
    
    [self.delegate didPressSignUp];
    
}

@end
