//
//  MapController.m
//  Sample
//
//  Created by vignesh on 8/24/16.
//  Copyright © 2016 vignesh. All rights reserved.
//

#import "MapController.h"
#import "MapViewController.h"

@interface MapController ()

@end

@implementation MapController

- (void)viewDidLoad
{
    [super viewDidLoad];
    mapView = [[MKMapView alloc]initWithFrame:
               CGRectMake(01, 01, 800, 800)];
    mapView.delegate = self;
    mapView.centerCoordinate = CLLocationCoordinate2DMake(13.0, 80.27);
    mapView.mapType = MKMapTypeHybrid;
    CLLocationCoordinate2D location;
    location.latitude = (double) 13.0827;
    location.longitude = (double) 80.2707;
    // Add the annotation to our map view
     MapViewController*newAnnotation = [[MapViewController alloc]initWithTitle:@"ChennaiCentral `I" andCoordinate:location];
    [mapView addAnnotation:newAnnotation];
    [self.view addSubview:mapView];
}
// When a map annotation point is added, zoom to it (1500 range)
- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views
{
    MKAnnotationView *annotationView = [views objectAtIndex:0];
    id <MKAnnotation> mp = [annotationView annotation];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance
    ([mp coordinate], 1500, 1500);
    [mv setRegion:region animated:YES];
    [mv selectAnnotation:mp animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
