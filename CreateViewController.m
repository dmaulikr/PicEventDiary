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

@interface CreateViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UITextField *eventEntered;
@property (weak, nonatomic) IBOutlet UIDatePicker *dateEntered;

@property (weak, nonatomic) IBOutlet UITextView *noteEntered;

@property (nonatomic) NSManagedObjectContext *managedObjectContext;

@property (nonatomic) CreateViewController *initialInstance;

@end

@implementation CreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    self.managedObjectContext = appDelegate.managedObjectContext;
    
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
    
    NSManagedObjectContext *context = self.managedObjectContext;
    
    Event *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:context];
    
    newManagedObject.eventName = self.eventEntered.text;
    newManagedObject.date = [[self.dateEntered date] timeIntervalSince1970];
    //   newManagedObject.
    //   newManagedObject.location = self.locationName;
    newManagedObject.locationName = self.locationName.name;
    newManagedObject.locationLatitude = self.locationName.placemark.coordinate.latitude;
    newManagedObject.locationLongitude = self.locationName.placemark.coordinate.longitude;
    //    newManagedObject.locationlongitude = self.locationName.placemark.coordinate.longitude
    
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
