//
//  MapController.h
//  Sample
//
//  Created by vignesh on 8/24/16.
//  Copyright © 2016 vignesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>
{
    MKMapView *mapView;
}
@end
