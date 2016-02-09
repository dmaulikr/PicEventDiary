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

@interface EventDetailViewController ()


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *collectionViewFlowLayout;

@end

@implementation EventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    EventDetailCommentViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CommentCell" forIndexPath:indexPath];
    cell.commentAuthorLabel.text = @"Narendra";
    cell.commentLabel.text = @"Comments are supposed to come here.\n Keep going";
    
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
    header.eventLocationHeaderLabel.text = @"Toronto";
    
    return header;
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
