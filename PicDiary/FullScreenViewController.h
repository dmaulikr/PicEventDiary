//
//  FullScreenViewController.h
//  PicDiary
//
//  Created by Narendra Thapa on 2016-02-09.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface FullScreenViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>


//@property (weak, nonatomic) IBOutlet UIImageView *fullScreenImage;

@property (nonatomic) NSUInteger itemIndex;

@property (nonatomic) NSArray *photo;

@property (nonatomic) Photo *selectedPhoto;

@property (nonatomic) NSManagedObjectContext *managedObjectContext;

@end
