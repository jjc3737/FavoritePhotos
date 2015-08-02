//
//  MapViewController.m
//  FavoritePhotos
//
//  Created by Andrew  Nguyen on 8/1/15.
//  Copyright (c) 2015 Jaehee Chung. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()
@property NSMutableArray *favorites;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;


@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self setUpAnnotations];

}

- (void)viewDidAppear:(BOOL)animated {
    [self.mapView removeAnnotations:[self.mapView annotations]];
    [self setUpAnnotations];
}

- (void)setUpAnnotations {
    Favorites *f = [Favorites new];
    self.favorites = [f loadImageObjects];
    for (Image *i in self.favorites) {
        NSArray *coordinate = i.latitudeAndLongitude;
        if ([coordinate[0]doubleValue] != 0.0) {
            MKPointAnnotation *annotation = [MKPointAnnotation new];
            annotation.coordinate = CLLocationCoordinate2DMake([coordinate[0]doubleValue], [coordinate[1]doubleValue]);
            annotation.title = @"Favorited Photo";
            [self.mapView addAnnotation:annotation];
        }
    }

    [self.mapView showAnnotations:[self.mapView annotations] animated:YES];
}

//-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
//    MKAnnotationView *pin = [MKAnnotationView new];
//    pin.canShowCallout = YES;
//
//    return pin;
//    
//}


@end
