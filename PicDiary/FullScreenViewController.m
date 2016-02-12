//
//  FullScreenViewController.m
//  PicDiary
//
//  Created by Narendra Thapa on 2016-02-09.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

#import "FullScreenViewController.h"
#import "PhotoCommentViewCell.h"
#import "PhotoFullScreenImageHeader.h"
#import "User.h"

@interface FullScreenViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *collectionViewFlowLayout;

@property (nonatomic) NSMutableOrderedSet *photoComments;
@property (nonatomic) NSMutableArray *comments;

@property (nonatomic) NSMutableArray *users;
@property (nonatomic) NSMutableSet *userSet;

@property (nonatomic) User *activeUser;

@end

@implementation FullScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    /*******************************************/
    self.users = [[NSMutableArray alloc] init];
    self.userSet = [[NSMutableSet alloc] init];
    
    [self.users removeAllObjects];
    [self.userSet removeAllObjects];
    
    self.activeUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    
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
    
    self.selectedPhoto = [self.photo objectAtIndex:self.itemIndex];
    
    self.comments = [[NSMutableArray alloc] init];
    self.photoComments = [self.selectedPhoto.commentPhoto mutableCopy];
    
    //self.fullScreenImage.image = self.selectedPhoto.image;
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
    self.comments = [self.selectedPhoto.commentPhoto.array  mutableCopy];;
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"Number of comments %lu", (unsigned long)self.comments.count);
    return self.comments.count;
    //return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PhotoCommentViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCommentCell" forIndexPath:indexPath];
   
    Comment *cellComment = [self.comments objectAtIndex:indexPath.row];
    User *commentAuthor = [cellComment.user anyObject];

    cell.authorLabel.text = commentAuthor.username;
    cell.commentLabel.text = cellComment.comment;
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    PhotoFullScreenImageHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FullScreenImage" forIndexPath:indexPath];
    header.imageView.backgroundColor = [UIColor blackColor];
    header.imageView.contentMode = UIViewContentModeScaleAspectFit;
    header.imageView.image = self.selectedPhoto.image;
    
    return header;
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
                                                   
                                                   [self.photoComments addObject:commentObject];
                                                   self.selectedPhoto.commentPhoto = self.photoComments;
                                                   
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
