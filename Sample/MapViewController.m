//
//  MapViewController.m
//  Sample
//
//  Created by vignesh on 8/23/16.
//  Copyright © 2016 vignesh. All rights reserved.
//

#import "MapViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate =  self;
    self.mapView.showsUserLocation = YES;
    [CLLocationManager locationServicesEnabled];
    {
        if (self.locationManager == nil )
        {
            self.locationManager = [[CLLocationManager alloc] init];
            self.locationManager.delegate = self;
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            
        }
        
        [self.locationManager startUpdatingLocation];
    }

    
        // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    NSString *annotationIdentifier = @"CustomViewAnnotation";
    MKAnnotationView* annotationView = [self.mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
    if(!annotationView)
    {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                      reuseIdentifier:annotationIdentifier];
    }
    annotationView.image = [UIImage imageNamed:@"user.jpg"];
    annotationView.canShowCallout= YES;
    
    return annotationView;
}
//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
//{
//    
//self.currentLocation = [locations lastObject];
//    // here we get the current location
//}
/*
  
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

*/

@end
