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

@interface EventAlbumViewController ()

@property (strong,nonatomic) UICollectionViewFlowLayout* photoLayout;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *collectionViewFlowLayout;

@property (nonatomic) NSMutableSet *eventPhotos;

@property (nonatomic) NSMutableArray *photos;

@property (nonatomic) Album *eventAlbum;

@property (nonatomic) Album *anotherEventAlbum;

@property (nonatomic) NSMutableArray *allPhotosInAlbum;

@end

@implementation EventAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    NSLog(@"%d", self.photos.count);
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
    
    
    NSManagedObjectContext *context = self.managedObjectContext;

    Photo *photoObject = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:context];
    photoObject.image = info[UIImagePickerControllerOriginalImage];
    
    [self.eventPhotos addObject:photoObject];
    self.eventSelected.photos = self.eventPhotos;
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
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
