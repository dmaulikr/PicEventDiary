//
//  CreateViewController.m
//  PicDiary
//
//  Created by Narendra Thapa on 2016-02-08.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

#import "CreateViewController.h"
#import "AppDelegate.h"
#import "Event.h"

@interface CreateViewController ()

@property (weak, nonatomic) IBOutlet UITextField *eventEntered;
@property (weak, nonatomic) IBOutlet UIDatePicker *dateEntered;
@property (weak, nonatomic) IBOutlet UITextView *noteEntered;

@property (nonatomic) NSManagedObjectContext *managedObjectContext;

@end

@implementation CreateViewController

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



- (IBAction)saveButtonPressed:(UIButton *)sender {
    NSLog(@"Save Button Pressed");
    
    NSManagedObjectContext *context = self.managedObjectContext;
    
    Event *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:context];
    
    newManagedObject.eventName = self.eventEntered.text;
    newManagedObject.date = [[self.dateEntered date] timeIntervalSince1970];
    newManagedObject.note = self.noteEntered.text;
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    int controllerIndex = 0;
    UITabBarController *tabBarController = self.tabBarController;
    UIView * fromView = tabBarController.selectedViewController.view;
    UIView * toView = [[tabBarController.viewControllers objectAtIndex:controllerIndex] view];
    
    // Transition using a page curl.
    [UIView transitionFromView:fromView
                        toView:toView
                      duration:0.5
                       options:(controllerIndex > tabBarController.selectedIndex ? UIViewAnimationOptionTransitionCurlUp : UIViewAnimationOptionTransitionCurlDown)
                    completion:^(BOOL finished) {
                        if (finished) {
                            tabBarController.selectedIndex = controllerIndex;
                        }
                    }];
    
    self.eventEntered.text = @"";
    self.noteEntered.text = @"";
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.eventEntered resignFirstResponder];
    [self.noteEntered resignFirstResponder];
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
