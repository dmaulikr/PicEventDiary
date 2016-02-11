//
//  MapViewController.h
//  PicDiary
//
//  Created by Narendra Thapa on 2016-02-10.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CreateViewController.h"

@interface MapViewController : UIViewController

@property (nonatomic, strong) NSArray *mapItemList;
@property (nonatomic, assign) MKCoordinateRegion boundingRegion;

@property (nonatomic) CreateViewController *createViewController;

@property (nonatomic) MKMapItem *location;

@end
