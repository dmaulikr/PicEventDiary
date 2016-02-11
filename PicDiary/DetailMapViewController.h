//
//  DetailMapViewController.h
//  PicDiary
//
//  Created by Narendra Thapa on 2016-02-10.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface DetailMapViewController : UIViewController

@property (nonatomic) MKMapItem *eventLocation;

@property (nonatomic) NSString *eventLocationName;
@property (nonatomic) float eventLocationLatitude;
@property (nonatomic) float eventLocationLongitude;

@property (nonatomic, assign) MKCoordinateRegion boundingRegion;

@end
