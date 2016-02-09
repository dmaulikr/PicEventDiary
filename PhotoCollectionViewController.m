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

@interface PhotoCollectionViewController ()


@property (strong,nonatomic) UICollectionViewFlowLayout* photoLayout;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *collectionViewFlowLayout;

@property (nonatomic) NSManagedObjectContext *managedObjectContext;

@property (nonatomic) NSArray *photo;

@end

@implementation PhotoCollectionViewController

//static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    self.photoLayout = [[UICollectionViewFlowLayout alloc] init];
    self.photoLayout.itemSize = CGSizeMake(105, 150);
    self.photoLayout.minimumInteritemSpacing = 1;
    self.photoLayout.minimumLineSpacing = 1;
    //self.photoLayout.headerReferenceSize = CGSizeMake(150, 30);
    
    self.collectionView.collectionViewLayout = self.photoLayout;
    
    NSError *errR = nil;
    NSFetchRequest *fetchRequestR = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityR = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:self.managedObjectContext];
    [fetchRequestR setEntity:entityR];
    
    self.photo = [self.managedObjectContext executeFetchRequest:fetchRequestR error:&errR];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
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

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

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
