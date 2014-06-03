//
//  MapViewController.m
//  WhereBrianAt
//
//  Created by Brian Donohue on 5/10/14.
//  Copyright (c) 2014 Brian Donohue. All rights reserved.
//

#import "MapViewController.h"
#import "UserAnnotationView.h"
#import "AFNetworking.h"

@implementation MapViewController

#define HOST @"https://wherebrianat.herokuapp.com"
#define ACCESS_TOKEN @"HIDING THIS"

@synthesize locationManager;
@synthesize lastLocation;

- (id)init {
    self = [super init];
    if (self) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
    }
    return self;
}

- (void)loadView {
    self.mapView = [[MKMapView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    self.view = self.mapView;
}

- (void)viewDidLoad {
    [self.locationManager startMonitoringSignificantLocationChanges];
}

-(void)centerMap:(CLLocation *)location {
    MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(.08, .08));
    [self.mapView setRegion:region animated:YES];
}

-(void)updateLocation:(CLLocation *)location {
    if (!lastLocation ||
        (location && [location distanceFromLocation:lastLocation] > 10)) {
        lastLocation = location;
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary * params = @{@"lat": @(location.coordinate.latitude),
                                  @"lng": @(location.coordinate.longitude),
                                  @"access_token": ACCESS_TOKEN};
        NSLog(@"latitude %+.6f, longitude %+.6f\n",
              location.coordinate.latitude,
              location.coordinate.longitude);
        [manager POST:HOST@"/submit" parameters:params success:^(AFHTTPRequestOperation *operation, id response) {
            NSLog(@"Success");
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKAnnotationView *view = nil;
    NSString *reuseIdentifier;
    reuseIdentifier = @"userAnnotation";
    view = [mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];
    if (view == nil) {
        view = [[UserAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
        [view setCanShowCallout:NO];
    }

    return view;
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    CLLocation *location = [[CLLocation alloc] initWithLatitude:userLocation.coordinate.latitude
                                                      longitude:userLocation.coordinate.longitude];
    CLLocation *equatorMeridian = [[CLLocation alloc] initWithLatitude:0 longitude:0];
    if ([equatorMeridian distanceFromLocation:location] > 0) { //Resolve observed inaccurate position fix
        NSLog(@"Did update user location");
        MKCoordinateRegion region = MKCoordinateRegionMake(userLocation.coordinate, MKCoordinateSpanMake(.08, .08));
        [mapView setRegion:region animated:YES];
        [self updateLocation:location];
    }
}

- (void)locationManager:(CLLocationManager *)m didUpdateLocations:(NSArray *)locations {
    NSLog(@"Did update location");
    CLLocation* location = [locations lastObject];
    [self centerMap:location];
    [self updateLocation:location];
}

@end
