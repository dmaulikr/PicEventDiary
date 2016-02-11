//
//  MapViewController.m
//  PicDiary
//
//  Created by Narendra Thapa on 2016-02-10.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

#import "MapViewController.h"
#import "PlaceAnnotation.h"

@interface MapViewController () <MKMapViewDelegate>

@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) PlaceAnnotation *annotation;



@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Adjust the map to zoom/center to the annotations we want to show.
    [self.mapView setRegion:self.boundingRegion animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // We add the placemarks here to get the "drop" animation.
    if (self.mapItemList.count == 1) {
        
        MKMapItem *mapItem = [self.mapItemList objectAtIndex:0];
        
        self.title = mapItem.name;
        
        // Add the single annotation to our map.
        PlaceAnnotation *annotation = [[PlaceAnnotation alloc] init];
        annotation.coordinate = mapItem.placemark.location.coordinate;
        annotation.title = mapItem.name;
        self.location = mapItem;
        annotation.url = mapItem.url;
        [self.mapView addAnnotation:annotation];
        
        // We have only one annotation, select it's callout.
        [self.mapView selectAnnotation:[self.mapView.annotations objectAtIndex:0] animated:YES];
    }
//    else {
//        self.title = @"All Places";
//        
//        // Add all the found annotations to the map.
//        
//        for (MKMapItem *item in self.mapItemList) {
//            PlaceAnnotation *annotation = [[PlaceAnnotation alloc] init];
//            annotation.coordinate = item.placemark.location.coordinate;
//            annotation.title = item.name;
//            annotation.url = item.url;
//            [self.mapView addAnnotation:annotation];
//        }
//    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.mapView removeAnnotations:self.mapView.annotations];
}

//- (NSUInteger)supportedInterfaceOrientations {
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        return UIInterfaceOrientationMaskAll;
//    } else {
//        return UIInterfaceOrientationMaskAllButUpsideDown;
//    }
//}


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
- (IBAction)locationSelected:(UIBarButtonItem *)sender {
    
    self.createViewController.locationName = self.location;
    
    [self.navigationController popToViewController:(self.createViewController) animated:YES];
    
    
}

@end

/**
@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
**/
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end

*/
