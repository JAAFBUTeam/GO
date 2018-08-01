//
//  CurrentLocationPosition.m
//  GO
//
//  Created by Ajaita Saini on 7/29/18.
//  Copyright © 2018 Amy Liu. All rights reserved.

#import "CurrentLocationPosition.h"
#import "Location.h"
#import <CoreLocation/CoreLocation.h>

@interface CurrentLocationPosition() <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation CurrentLocationPosition

-(instancetype)init {
    self = [super init];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    self.locationManager.distanceFilter = kCLHeadingFilterNone;
    self.locationManager.pausesLocationUpdatesAutomatically = NO;
    self.locationManager.activityType = CLActivityTypeFitness;
    
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    
    return self;
}
+ (CurrentLocationPosition *)sharedInstance {
    static CurrentLocationPosition *sharedInstance = nil;
    static dispatch_once_t onceToken; // onceToken = 0
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CurrentLocationPosition alloc] init];
    });
    
    return sharedInstance;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    self.currentLocation = [locations lastObject];
}

-(void)setUserCurrentLocation {
//    _currentLocation = [[CLLocationManager alloc] init];
//    self.currentLocation.delegate = self;
//    self.currentLocation.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
//    self.currentLocation.distanceFilter = kCLHeadingFilterNone;
//    self.currentLocation.pausesLocationUpdatesAutomatically = NO;
//    self.currentLocation.activityType = CLActivityTypeFitness;
//
//    [_currentLocation startUpdatingLocation];
//
//    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways) {
//        [_currentLocation startUpdatingLocation];
//    } else {
//        [_currentLocation requestAlwaysAuthorization];
//        if ([_currentLocation respondsToSelector:@selector(requestWhenInUseAuthorization)])
//        {
//            //[_currentLocation requestWhenInUseAuthorization];
//            [_currentLocation startUpdatingLocation];
//        }
//    }
}

-(double)setDistance:(Location *)location {
    CLLocation *location2 = [[CLLocation alloc] initWithLatitude:location.lat longitude:location.lon];
    double distance = [self.locationManager.location distanceFromLocation:location2] * 0.00062137;

    return distance;
}

@end
