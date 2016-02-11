//
//  PageViewController.h
//  PicDiary
//
//  Created by Narendra Thapa on 2016-02-09.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageViewController : UIViewController

@property (nonatomic) NSArray *photo;

@property (nonatomic) NSUInteger itemIndex;

@property (nonatomic) NSManagedObjectContext *managedObjectContext;

@end
