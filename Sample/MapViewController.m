//
//  MapViewController.m
//  Sample
//
//  Created by vignesh on 8/24/16.
//  Copyright © 2016 vignesh. All rights reserved.
//

#import "MapViewController.h"

@implementation MapViewController
-(id)initWithTitle:(NSString *)title andCoordinate:
(CLLocationCoordinate2D)coordinate2d
{
    self.title = title;
    self.coordinate =coordinate2d;
    return self;
}
@end
