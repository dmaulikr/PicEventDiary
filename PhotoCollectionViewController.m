//
//  PhotoCollectionViewController.m
//  PicDiary
//
//  Created by Narendra Thapa on 2016-02-08.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

#import "PhotoCollectionViewController.h"
#import "PhotoCollectionViewCell.h"
#import "AppDelegate.h"
#import "Photo.h"
#import "FullScreenViewController.h"
#import "PageViewController.h"
#import "User.h"

@interface PhotoCollectionViewController ()


@property (strong,nonatomic) UICollectionViewFlowLayout* photoLayout;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *collectionViewFlowLayout;

@property (nonatomic) NSManagedObjectContext *managedObjectContext;

@property (nonatomic) NSMutableArray *photo;
@property (nonatomic) NSMutableArray *tempPhoto;

@property (nonatomic) NSMutableArray *users;
@property (nonatomic) NSMutableSet *userSet;

@property (nonatomic) NSMutableArray *event;
@property (nonatomic) NSMutableArray *loggedInUserEvent;

@property (nonatomic) User *activeUser;

@end

@implementation PhotoCollectionViewController

//static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    self.event = [[NSMutableArray alloc] init];
    self.photo = [[NSMutableArray alloc] init];
    self.tempPhoto = [[NSMutableArray alloc] init];
    self.loggedInUserEvent = [[NSMutableArray alloc] init];
    
    /*********************************************/
    self.users = [[NSMutableArray alloc] init];
    self.userSet = [[NSMutableSet alloc] init];
    [self.users removeAllObjects];
    [self.userSet removeAllObjects];
    
    NSManagedObjectContext *context = self.managedObjectContext;
    
    self.activeUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    
    NSError *errU = nil;
    NSFetchRequest *fetchRequestU = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityU = [NSEntityDescription entityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    [fetchRequestU setEntity:entityU];
    
    NSArray *users = [self.managedObjectContext executeFetchRequest:fetchRequestU error:&errU];
    self.users = [users mutableCopy];
    
    for (User *user in self.users) {
        if (user.signedIn) {
            self.activeUser = user;
        }
    }
    
    [self.userSet addObject:self.activeUser];
    
    /*********************************************/
    
    self.photoLayout = [[UICollectionViewFlowLayout alloc] init];
    self.photoLayout.itemSize = CGSizeMake(105, 150);
    self.photoLayout.minimumInteritemSpacing = 1;
    self.photoLayout.minimumLineSpacing = 1;
    //self.photoLayout.headerReferenceSize = CGSizeMake(150, 30);
    
    self.collectionView.collectionViewLayout = self.photoLayout;
    
    [self UpdateArraysWithPhotos];
    
    [self.collectionView reloadData];
    
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)UpdateArraysWithPhotos {
    
    [self.loggedInUserEvent removeAllObjects];
    [self.event removeAllObjects];
    [self.photo removeAllObjects];
    
    NSLog(@"Number of users: %lu", (unsigned long)self.users.count);
    
    NSError *errR = nil;
    NSFetchRequest *fetchRequestR = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityR = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:self.managedObjectContext];
    [fetchRequestR setEntity:entityR];
    
    NSArray *events = [self.managedObjectContext executeFetchRequest:fetchRequestR error:&errR];
    self.event = [events mutableCopy];
    
    NSLog(@"Event Count %d", self.event.count);
    
    for (Event *event in self.event) {
        if ([event.user containsObject:self.activeUser]) {
            [self.loggedInUserEvent addObject:event];
        }
    }
    NSLog(@"Logged In User Event %d", self.loggedInUserEvent.count);
    
    for (Event *event in self.loggedInUserEvent) {
        self.tempPhoto = [[event.photos allObjects] mutableCopy];
        [self.photo addObjectsFromArray:self.tempPhoto];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self UpdateArraysWithPhotos];
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photo.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
    Photo *cellPhoto = [self.photo objectAtIndex:indexPath.row];
    cell.photoCell.image = cellPhoto.image;
    
    return cell;
}

#pragma mark - Segues

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"FullScreen"]) {
        return NO;
    }
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"FullScreen"]) {
        
        FullScreenViewController *FSViewController = (FullScreenViewController *)[segue destinationViewController];
        
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
        Photo *photoSelected = [self.photo objectAtIndex:indexPath.row];
        NSLog(@"Photo Selected");
        
        
        FSViewController.selectedPhoto = photoSelected;
        
        FSViewController.managedObjectContext = self.managedObjectContext;
    }
    
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PageViewController *pages = [[PageViewController alloc] init];
    
    pages.photo = self.photo;
    pages.itemIndex = indexPath.row;
    pages.managedObjectContext = self.managedObjectContext;
    NSLog(@"page View %lu", (unsigned long)pages.itemIndex);
    
    [self.navigationController pushViewController:pages animated:YES];
    
    return YES;
}


/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
