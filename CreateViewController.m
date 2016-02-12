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
#import "LocationTableViewCell.h"
#import "MapSearchViewController.h"
#import "User.h"

@interface CreateViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UITextField *eventEntered;
@property (weak, nonatomic) IBOutlet UIDatePicker *dateEntered;

@property (weak, nonatomic) IBOutlet UITextView *noteEntered;

@property (nonatomic) NSManagedObjectContext *managedObjectContext;

@property (nonatomic) CreateViewController *initialInstance;

@property (nonatomic) NSMutableArray *users;
@property (nonatomic) NSMutableSet *userSet;

@property (nonatomic) User *activeUser;



@end

@implementation CreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.users = [[NSMutableArray alloc] init];
    self.userSet = [[NSMutableSet alloc] init];
    
    [self.users removeAllObjects];
    [self.userSet removeAllObjects];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    self.activeUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    
    NSError *errU = nil;
    NSFetchRequest *fetchRequestU = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityU = [NSEntityDescription entityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    [fetchRequestU setEntity:entityU];
    
    NSArray *users = [self.managedObjectContext executeFetchRequest:fetchRequestU error:&errU];
    NSLog(@"users array: %lu", (unsigned long)users.count);
    self.users = [users mutableCopy];
    

    for (User *user in self.users) {
        NSLog(@"CVC UserName: %@", user.username);
        if (user.signedIn) {
            NSLog(@"CVC Active UserName: %@", user.username);
            self.activeUser = user;
        }
    }
    NSLog(@"Number of users: %lu", (unsigned long)self.users.count);
    
    [self.userSet addObject:self.activeUser];
    
    self.initialInstance = self;

    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)SaveButtonPressed:(UIButton *)sender {
    NSLog(@"Save Button Pressed");
    
    Event *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:self.managedObjectContext];
    
    newManagedObject.eventName = self.eventEntered.text;
    newManagedObject.date = [[self.dateEntered date] timeIntervalSince1970];

    newManagedObject.locationName = self.locationName.name;
    newManagedObject.locationLatitude = self.locationName.placemark.coordinate.latitude;
    newManagedObject.locationLongitude = self.locationName.placemark.coordinate.longitude;
    
    newManagedObject.user = self.userSet;
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
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

- (IBAction)kjSaveButtonPressed:(UIBarButtonItem *)sender {
    // Bar button removed

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.eventEntered resignFirstResponder];
    [self.noteEntered resignFirstResponder];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LocationCell" forIndexPath:indexPath];
    
//    Tag *oneTag = self.allTags[indexPath.row];
    
    cell.eventLocationLabel.text = self.locationName.name;
    
    return cell;
}

- (IBAction)signedOut:(UIBarButtonItem *)sender {
    
    self.activeUser.signedIn = NO;
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    NSLog(@"Logged Out");
    
    
}
#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"SearchMap"]) {
        
        MapSearchViewController *eventDetailViewController = (MapSearchViewController *)[segue destinationViewController];
//        
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        eventDetailViewController.createViewController = self.initialInstance;
        
//        Event *eventSelected = [self.event objectAtIndex:indexPath.row];
//        NSLog(@"%@", eventSelected.eventName);
//        
//        eventDetailViewController.eventSelected = eventSelected;
//        eventDetailViewController.managedObjectContext = self.managedObjectContext;
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
