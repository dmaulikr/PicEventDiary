//
//  EventDetailViewController.m
//  PicDiary
//
//  Created by Narendra Thapa on 2016-02-08.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

#import "EventDetailViewController.h"
#import "AppDelegate.h"
#import "EventDetailHeaderView.h"
#import "EventDetailCommentViewCell.h"
#import "EventAlbumViewController.h"
#import "DetailMapViewController.h"

@interface EventDetailViewController ()


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *collectionViewFlowLayout;

@property (nonatomic) NSMutableOrderedSet *eventComments;
@property (nonatomic) NSMutableArray *comments;

@property (nonatomic) NSMutableArray *users;
@property (nonatomic) NSMutableSet *userSet;

@end

@implementation EventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.comments = [[NSMutableArray alloc] init];
    
    self.eventComments = [self.eventSelected.commentEvent mutableCopy];
    
    /*********************************************/
    self.users = [[NSMutableArray alloc] init];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    [self.users removeAllObjects];
    
    NSManagedObjectContext *context = self.managedObjectContext;
    
    User *activeUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    
    NSError *errU = nil;
    NSFetchRequest *fetchRequestU = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityU = [NSEntityDescription entityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    [fetchRequestU setEntity:entityU];
    
    NSArray *users = [self.managedObjectContext executeFetchRequest:fetchRequestU error:&errU];
    self.users = [users mutableCopy];
    
    for (User *user in self.users) {
        if (user.signedIn) {
            activeUser = user;
        }
    }
    
    [self.userSet addObject:activeUser];
    
    /*********************************************/
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self UpdateCommentsArray];
    [self.collectionView reloadData];
}

- (void)UpdateCommentsArray {
    self.comments = [self.eventSelected.commentEvent.array  mutableCopy];;
  
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"Number of comments %lu", (unsigned long)self.comments.count);
    return self.comments.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    EventDetailCommentViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CommentCell" forIndexPath:indexPath];
    cell.commentAuthorLabel.text = @"Narendra";
    Comment *cellComment = [self.comments objectAtIndex:indexPath.row];
    cell.commentLabel.text = cellComment.comment;
    //cell.commentLabel.text = @"Comments are supposed to come here.\n Keep going";
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    EventDetailHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"EventHeader" forIndexPath:indexPath];
    //header.reviewHeaderImage.image = self.movieSelected.movieThumbnail;
    
    header.eventNameHeaderLabel.text = self.eventSelected.eventName;
    NSDate *eventDate = [[NSDate alloc] initWithTimeIntervalSince1970:self.eventSelected.date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    dateformatter.dateFormat = @"EEE MMM d, yyyy HH:mm a";
    header.eventDateHeaderLabel.text = [dateformatter stringFromDate:eventDate];
    header.eventLocationHeaderLabel.titleLabel.text = self.eventSelected.locationName;
    
    return header;
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"toEventPhotos"]) {
        
        EventAlbumViewController *eventAlbumViewController = (EventAlbumViewController *)[segue destinationViewController];
        NSLog(@"toEventPhotos");
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        Event *eventSelected = [self.event objectAtIndex:indexPath.row];
//        NSLog(@"%@", eventSelected.eventName);
        
        eventAlbumViewController.eventSelected = self.eventSelected;
        eventAlbumViewController.managedObjectContext = self.managedObjectContext;
    }
    else if ([[segue identifier] isEqualToString:@"locationDetail"]) {
        
        DetailMapViewController *detailMapViewController = (DetailMapViewController *)[segue destinationViewController];
        detailMapViewController.eventLocationName = self.eventSelected.locationName;
        detailMapViewController.eventLocationLatitude = self.eventSelected.locationLatitude;
        detailMapViewController.eventLocationLongitude = self.eventSelected.locationLongitude;
        
    }
    
}

- (IBAction)commentButtonPressed:(UIButton *)sender {
    UIAlertController *alert= [UIAlertController alertControllerWithTitle:@"Comment Window"
                                                                  message:@"Keep it short and sweet"
                                                           preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   //Do Some action here
            NSManagedObjectContext *context = self.managedObjectContext;
                                                   
        Comment *commentObject = [NSEntityDescription insertNewObjectForEntityForName:@"Comment" inManagedObjectContext:context];
          
                                                   UITextField *textField = alert.textFields[0];
                                                   NSLog(@"text was %@", textField.text);
                                                   
                                                   commentObject.comment = textField.text;
                                                   commentObject.user = self.userSet;
                                                   [self.eventComments addObject:commentObject];
                                                   self.eventSelected.commentEvent = self.eventComments;
                                                   NSError *error = nil;
                                                   if (![context save:&error]) {
                                                       NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                                                       abort();
                                                   }
                                                   [self UpdateCommentsArray];
                                                   [self.collectionView reloadData];
                                                   
                                               }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       NSLog(@"cancel btn");
                                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                                   }];
    [alert addAction:ok];
    [alert addAction:cancel];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Comments Please";
        textField.keyboardType = UIKeyboardTypeDefault;
    }];
    
    
    
    [self presentViewController:alert animated:YES completion:nil];
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
