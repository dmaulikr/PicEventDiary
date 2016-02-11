//
//  DetailMapViewController.m
//  PicDiary
//
//  Created by Narendra Thapa on 2016-02-10.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

#import "DetailMapViewController.h"
#import "PlaceAnnotation.h"

@interface DetailMapViewController ()

@property (nonatomic, weak) IBOutlet MKMapView *mapView;

@property (nonatomic, strong) PlaceAnnotation *annotation;

@property (nonatomic) NSString *locationName;


@end

@implementation DetailMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Adjust the map to zoom/center to the annotations we want to show.
    [self.mapView setRegion:self.boundingRegion animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // We add the placemarks here to get the "drop" animation.
        
 //       MKMapItem *mapItem = [self.mapItemList objectAtIndex:0];
        //MKMapItem *mapItem = self.eventLocation;
        
        //self.title = mapItem.name;
        self.title = self.eventLocationName;
    
    
        // Add the single annotation to our map.
        PlaceAnnotation *annotation = [[PlaceAnnotation alloc] init];
        //annotation.coordinate = mapItem.placemark.location.coordinate;
        annotation.coordinate = CLLocationCoordinate2DMake(self.eventLocationLatitude,self.eventLocationLongitude);
        //annotation.title = mapItem.name;
        annotation.title = self.eventLocationName;
        //self.locationName = mapItem.name;
        //annotation.url = mapItem.url;
    
        [self.mapView addAnnotation:annotation];
        
        // We have only one annotation, select it's callout.
        [self.mapView selectAnnotation:[self.mapView.annotations objectAtIndex:0] animated:YES];
    

}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.mapView removeAnnotations:self.mapView.annotations];
}


#pragma mark - MKMapViewDelegate

- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error {
    NSLog(@"Failed to load the map: %@", error);
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKPinAnnotationView *annotationView = nil;
    
    if ([annotation isKindOfClass:[PlaceAnnotation class]]) {
        annotationView = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
        
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"];
            annotationView.canShowCallout = YES;
            annotationView.animatesDrop = YES;
        }
    }
    return annotationView;
}


@end
