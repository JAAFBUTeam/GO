//
//  User.m
//  GO
//
//  Created by Amy Liu on 7/23/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "User.h"
#import "Parse/Parse.h"
#import "ParseUI/ParseUI.h"

@implementation User

@dynamic username;
@dynamic password;
@dynamic name;

@dynamic image;

@dynamic favorites;
@dynamic reviews;

-(void)setUserCurrentLocation {
    self.currentLocation.delegate = self;
    self.currentLocation = [[CLLocationManager alloc] init];
    self.currentLocation.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    self.currentLocation.distanceFilter = kCLHeadingFilterNone;
    [self.currentLocation startUpdatingLocation];
    self.currentLocation.pausesLocationUpdatesAutomatically = NO;
    self.currentLocation.activityType = CLActivityTypeFitness;
    
    NSNumber *myNumber = [NSNumber numberWithDouble:[self.currentLocation.location coordinate].latitude];
    NSLog(@"current latitude");
    NSLog(@"%@", [myNumber stringValue]);
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Location manager does not work");
}

@end
