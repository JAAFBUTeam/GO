//
//  CurrentLocationPosition.m
//  GO
//
//  Created by Ajaita Saini on 7/29/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "CurrentLocationPosition.h"
#import "Location.h"
#import <CoreLocation/CoreLocation.h>

@implementation CurrentLocationPosition


-(void)setUserCurrentLocation {
    if(CLLocationManager.locationServicesEnabled){
        _currentLocation = [[CLLocationManager alloc] init];
        self.currentLocation.delegate = self;
        self.currentLocation = [[CLLocationManager alloc] init];
        self.currentLocation.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        self.currentLocation.distanceFilter = kCLHeadingFilterNone;
        self.currentLocation.pausesLocationUpdatesAutomatically = NO;
        self.currentLocation.activityType = CLActivityTypeFitness;
        
//        switch(_currentLocation.authorizationStatus) {
//            case     kCLAuthorizationStatusNotDetermined = 0,
//                kCLAuthorizationStatusRestricted,
//                kCLAuthorizationStatusDenied,
//                kCLAuthorizationStatusAuthorizedAlways
//                kCLAuthorizationStatusAuthorizedWhenInUse
//                kCLAuthorizationStatusAuthorized
//        }
        
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways) {
            [_currentLocation startUpdatingLocation];
        } else {
            if ([_currentLocation respondsToSelector:@selector(requestWhenInUseAuthorization)])
            {
                [_currentLocation requestWhenInUseAuthorization];
            }
        }
    }
    //[self.currentLocation requestWhenInUseAuthorization];
//    [self.currentLocation requestAlwaysAuthorization];
//    if(CLLocationManager.locationServicesEnabled){
//        self.currentLocation.delegate = self;
//        self.currentLocation = [[CLLocationManager alloc] init];
//        self.currentLocation.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
//        self.currentLocation.distanceFilter = kCLHeadingFilterNone;
//        self.currentLocation.pausesLocationUpdatesAutomatically = NO;
//        self.currentLocation.activityType = CLActivityTypeFitness;
//        [self.currentLocation requestAlwaysAuthorization];
//        [self.currentLocation startUpdatingLocation];
//    }
    
    NSNumber *myNumber = [NSNumber numberWithDouble:[self.currentLocation.location coordinate].latitude];
    NSLog(@"current latitude");
    NSLog(@"%@", [myNumber stringValue]);
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied:
        {
            // do some error handling
        }
            break;
        default:{
            [_currentLocation startUpdatingLocation];
        }
            break;
    }
}

- (void)requestWhenInUseAuthorization
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
}

-(double)setDistance:(Location *)location {
    CLLocation *location2 = [[CLLocation alloc] initWithLatitude:location.lat longitude:location.lon];
    double distance = [self.currentLocation.location distanceFromLocation:location2] * 0.00062137;

    return distance;
}

@end
