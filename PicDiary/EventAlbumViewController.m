//
//  EventAlbumViewController.m
//  PicDiary
//
//  Created by Narendra Thapa on 2016-02-08.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

#import "EventAlbumViewController.h"
#import "AlbumPhotoViewCell.h"
#import "Photo.h"
#import "Album.h"
#import "FullScreenViewController.h"
#import "PageViewController.h"

@interface EventAlbumViewController ()

@property (strong,nonatomic) UICollectionViewFlowLayout* photoLayout;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *collectionViewFlowLayout;

@property (nonatomic) NSMutableSet *eventPhotos;

@property (nonatomic) NSMutableArray *photos;

@property (nonatomic) Album *eventAlbum;

@property (nonatomic) Album *anotherEventAlbum;

@property (nonatomic) NSMutableArray *allPhotosInAlbum;

@property (nonatomic) NSMutableArray *users;
@property (nonatomic) NSMutableSet *userSet;

@end

@implementation EventAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /***********************************/
    self.users = [[NSMutableArray alloc] init];
    self.userSet = [[NSMutableSet alloc] init];
    
    [self.users removeAllObjects];
    [self.userSet removeAllObjects];
    
    User *activeUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    
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
    
    /************************************/
    
    self.photos = [[NSMutableArray alloc] init];
    self.allPhotosInAlbum = [[NSMutableArray alloc] init];
    
    self.eventPhotos = [self.eventSelected.photos mutableCopy];
    
    [self UpdatePhotoArray];
    
    self.photoLayout = [[UICollectionViewFlowLayout alloc] init];
    self.photoLayout.itemSize = CGSizeMake(105, 150);
    self.photoLayout.minimumInteritemSpacing = 1;
    self.photoLayout.minimumLineSpacing = 1;
    //self.photoLayout.headerReferenceSize = CGSizeMake(150, 30);
    
    self.collectionView.collectionViewLayout = self.photoLayout;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self UpdatePhotoArray];
    [self.collectionView reloadData];
}

- (void)UpdatePhotoArray {
    self.photos = [[self.eventSelected.photos allObjects] mutableCopy];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"%lu", (unsigned long)self.photos.count);
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AlbumPhotoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    Photo *cellPhoto = [self.photos objectAtIndex:indexPath.row];
    cell.imageView.image = cellPhoto.image;
    
    return cell;
}

- (IBAction)takePhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}


- (IBAction)selectPhoto:(UIButton *)sender {
    NSLog(@"Camera Roll Selected");
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSLog(@"Image Choosen");

    Photo *photoObject = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:self.managedObjectContext];
    photoObject.image = info[UIImagePickerControllerOriginalImage];
    photoObject.user = self.userSet;
    
    [self.eventPhotos addObject:photoObject];
    self.eventSelected.photos = self.eventPhotos;
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

#pragma mark - Segues

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"fullScreenFromAlbum"]) {
        return NO;
    }
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"fullScreenFromAlbum"]) {
        
        FullScreenViewController *FSViewController = (FullScreenViewController *)[segue destinationViewController];
        
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
        Photo *photoSelected = [self.photos objectAtIndex:indexPath.row];
        
        NSLog(@"Photo Selected");
        
        FSViewController.selectedPhoto = photoSelected;
        FSViewController.managedObjectContext = self.managedObjectContext;
    }
    
}


- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PageViewController *pages = [[PageViewController alloc] init];
    
    pages.photo = self.photos;
    pages.itemIndex = indexPath.row;
    pages.managedObjectContext = self.managedObjectContext;
    NSLog(@"Page View %lu", (unsigned long)pages.itemIndex);
    
    [self.navigationController pushViewController:pages animated:YES];
    
    return YES;
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
