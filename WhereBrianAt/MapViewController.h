//
//  MapViewController.h
//  WhereBrianAt
//
//  Created by Brian Donohue on 5/10/14.
//  Copyright (c) 2014 Brian Donohue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate> {
    NSTimer *timer;
}

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *lastLocation;
@property (nonatomic, strong) MKMapView *mapView;

@end
