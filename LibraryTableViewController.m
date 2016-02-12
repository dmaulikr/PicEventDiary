//
//  LibraryTableViewController.m
//  PicDiary
//
//  Created by Narendra Thapa on 2016-02-08.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

#import "LibraryTableViewController.h"
#import "AppDelegate.h"
#import "LibraryTableViewCell.h"
#import "Event.h"
#import "EventDetailViewController.h"
#import "User.h"

@interface LibraryTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSMutableArray *event;

@property (nonatomic) NSMutableArray *loggedInUserEvent;

@property (nonatomic) NSMutableArray *users;

@property (nonatomic) User *activeUser;


@end

@implementation LibraryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.event = [[NSMutableArray alloc] init];
    self.users = [[NSMutableArray alloc] init];
    self.loggedInUserEvent = [[NSMutableArray alloc] init];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    self.delegate = appDelegate;
    
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    self.activeUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    
    [self UpdateArraysWithEvents];
    
    //[self.tableView reloadData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)UpdateArraysWithEvents {
    
    [self.loggedInUserEvent removeAllObjects];
    [self.event removeAllObjects];
    [self.users removeAllObjects];
    
    NSError *errU = nil;
    NSFetchRequest *fetchRequestU = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityU = [NSEntityDescription entityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    [fetchRequestU setEntity:entityU];
    
    NSArray *users = [self.managedObjectContext executeFetchRequest:fetchRequestU error:&errU];
    //NSLog(@"users array: %lu", (unsigned long)users.count);
    self.users = [users mutableCopy];
    
    for (User *user in self.users) {
        //NSLog(@"UserName: %@", user.username);
        if (user.signedIn) {
            NSLog(@"Active UserName: %@", user.username);
            self.activeUser = user;
        }
    }
    
    //NSLog(@"Number of users: %lu", (unsigned long)self.users.count);
        
    NSError *errR = nil;
    NSFetchRequest *fetchRequestR = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityR = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:self.managedObjectContext];
    [fetchRequestR setEntity:entityR];
    
    NSArray *events = [self.managedObjectContext executeFetchRequest:fetchRequestR error:&errR];
    self.event = [events mutableCopy];
    
    for (Event *event in self.event) {
        if ([event.user containsObject:self.activeUser]) {
            [self.loggedInUserEvent addObject:event];
        }
    }
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self UpdateArraysWithEvents];
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.loggedInUserEvent.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LibraryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LibraryCell" forIndexPath:indexPath];
    
    Event *oneEvent = [self.loggedInUserEvent objectAtIndex:indexPath.row];
    cell.eventNameLabel.text = oneEvent.eventName;
    cell.locationLabel.text = oneEvent.locationName;
    NSDate *eventDate = [[NSDate alloc] initWithTimeIntervalSince1970:oneEvent.date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    dateformatter.dateFormat = @"EEE MMM d, yyyy HH:mm a";
    cell.dateLabel.text = [dateformatter stringFromDate:eventDate];
    
    // Configure the cell...
    
    return cell;
}

- (IBAction)oksignedOut:(UIBarButtonItem *)sender {
    
    
    
}


- (IBAction)signedOut:(id)sender {
    
    self.activeUser.signedIn = NO;
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    NSLog(@"Logged Out");
    [self.delegate didPressLogOut];

}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"EventDetails"]) {
        
        EventDetailViewController *eventDetailViewController = (EventDetailViewController *)[segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Event *eventSelected = [self.loggedInUserEvent objectAtIndex:indexPath.row];
        NSLog(@"%@", eventSelected.eventName);
        
        eventDetailViewController.eventSelected = eventSelected;
        eventDetailViewController.managedObjectContext = self.managedObjectContext;
    }
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
