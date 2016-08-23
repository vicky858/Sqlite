//
//  MapViewController.h
//  Sample
//
//  Created by vignesh on 8/23/16.
//  Copyright © 2016 vignesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>



@interface MapViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation* currentLocation;


@end
