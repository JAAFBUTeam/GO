//
//  Location.m
//  GO
//
//  Created by Amy Liu on 7/16/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "Location.h"

@implementation Location

@dynamic title;
@dynamic synopsis;
@dynamic address;
@dynamic lat;
@dynamic lon;
@dynamic rating;
@dynamic images;
@dynamic tags;

+ (nonnull NSString *)parseClassName {
    return @"Location";
}

+ (Location *)createLocation {
    Location *newLocation = [Location new];
    newLocation.title = @"MOMA";
    newLocation.synopsis = @"Some really cool art!";
    newLocation.address = @"151 3rd St, San Francisco, CA 94103";
    newLocation.lat = 37.7857;
    newLocation.lon = -122.4011;
    newLocation.rating = 4.9;
    newLocation.pinImage = [[NSMutableArray alloc] init];
    [newLocation.pinImage addObject: [UIImage imageNamed:@"MOMA"]];
    [newLocation.images addObject: [UIImage imageNamed:@"MOMA_1"]];
    return newLocation;
}

+ (void) postLocation: (PFBooleanResultBlock  _Nullable)completion {
    
    NSLog(@"uploading hopefully");
    Location *newLocation = [Location new];
    newLocation.title = @"Sunnyside Conservatory";
    newLocation.synopsis = @"A botanic jewel!";
    newLocation.address = @"236 Monterey Blvd, San Francisco, CA 94131";
    newLocation.lat = 37.731928;
    newLocation.lon = -122.440789;
    newLocation.rating = 4.0;
    
    [newLocation saveInBackgroundWithBlock: completion];
}


@end

/* + (NSArray <Location *>) createLocations {
 
 Location *newLocation = [Location new];
 newLocation.title = @"MOMA";
 newLocation.synopsis = @"Some really cool art!";
 newLocation.address = @"151 3rd St, San Francisco, CA 94103";
 newLocation.lat = 37.7857;
 newLocation.lon = -122.4011;
 newLocation.rating = 4.9;
    [newLocation saveInBackgroundWithBlock: completion];
}  */
