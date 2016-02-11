//
//  MapSearchViewController.h
//  PicDiary
//
//  Created by Narendra Thapa on 2016-02-10.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CreateViewController.h"

@interface MapSearchViewController : UITableViewController <CLLocationManagerDelegate, UISearchBarDelegate>

@property (nonatomic) CreateViewController *createViewController;

@property (nonatomic, strong) NSArray *places;

@end
