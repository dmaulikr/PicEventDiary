//
//  LibraryTableViewController.h
//  PicDiary
//
//  Created by Narendra Thapa on 2016-02-08.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LibraryTableViewController;

@protocol LibraryTableViewControllerDelegate <NSObject>

- (void)didPressLogOut;

@end

@interface LibraryTableViewController : UIViewController

@property (nonatomic, weak) id <LibraryTableViewControllerDelegate> delegate;

@end
