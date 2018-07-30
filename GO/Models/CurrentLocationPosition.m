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
    self.currentLocation.delegate = self;
    self.currentLocation = [[CLLocationManager alloc] init];
    self.currentLocation.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    self.currentLocation.distanceFilter = kCLHeadingFilterNone;
    self.currentLocation.pausesLocationUpdatesAutomatically = NO;
    self.currentLocation.activityType = CLActivityTypeFitness;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
        [self.currentLocation requestWhenInUseAuthorization];
    }
    
    [self.currentLocation startUpdatingLocation];
    
    NSNumber *myNumber = [NSNumber numberWithDouble:[self.currentLocation.location coordinate].latitude];
    NSLog(@"current latitude");
    NSLog(@"%@", [myNumber stringValue]);
}

-(double)setDistance:(Location *)location {
    CLLocation *location2 = [[CLLocation alloc] initWithLatitude:location.lat longitude:location.lon];
    double distance = [self.currentLocation.location distanceFromLocation:location2] * 0.00062137;

    return distance;
}

@end
