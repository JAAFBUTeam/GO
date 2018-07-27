//
//  Location.m
//  GO
//
//  Created by Amy Liu on 7/16/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "Location.h"
#import "Parse/Parse.h"
#import "ParseUI/ParseUI.h"

@implementation Location

@dynamic title;
@dynamic synopsis;
@dynamic address;
@dynamic lat;
@dynamic lon;
@dynamic rating;
@dynamic images;
@dynamic tags;
@dynamic imageURLs;

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
    newLocation.tags = [[NSMutableArray alloc] init];
    // [newLocation.pinImage addObject: [UIImage imageNamed:@"MOMA"]];
    newLocation.imageURLs = [[NSMutableArray alloc] init];
    [newLocation.imageURLs addObject:@"https://s3-us-west-2.amazonaws.com/sfmomamedia/media/t/uploads/images/O1na7VIebCKV.jpg"];
    NSLog(@"%@", newLocation.imageURLs);
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
    newLocation.tags = [[NSMutableArray alloc] init];

    
    [newLocation saveInBackgroundWithBlock: completion];
}

- (void) fillArray: (NSMutableArray *) pictures {
    self.images = [[NSMutableArray alloc] init];
    for (NSString *picture in pictures) {
        NSURL *url = [[NSURL alloc] initWithString:picture];
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        [self.images addObject:[UIImage imageWithData:imageData]];
    }
}

+ (NSMutableArray *) createLocations {
    
    NSMutableArray <Location *> *locations = [[NSMutableArray alloc] init];
    Location *newLocation = [Location new];
    newLocation.title = @"MOMA";
    newLocation.synopsis = @"Some really cool art!";
    newLocation.address = @"151 3rd St, San Francisco, CA 94103";
    newLocation.lat = 37.7857;
    newLocation.lon = -122.4011;
    newLocation.rating = 4.9;
    newLocation.pinImage = [[NSMutableArray alloc] init];
    newLocation.tags = [[NSMutableArray alloc] init];
    newLocation.imageURLs = [[NSMutableArray alloc] init];
    [newLocation.imageURLs addObject:@"https://s3-us-west-2.amazonaws.com/sfmomamedia/media/t/uploads/images/O1na7VIebCKV.jpg"];
    [locations addObject:newLocation];
    
    Location *newLocation2 = [Location new];
    newLocation2.title = @"Sunnyside Conservatory";
    newLocation2.synopsis = @"A botanic jewel!";
    newLocation2.address = @"236 Monterey Blvd, San Francisco, CA 94131";
    newLocation2.lat = 37.731928;
    newLocation2.lon = -122.440789;
    newLocation2.rating = 4.0;
    newLocation2.pinImage = [[NSMutableArray alloc] init];
    newLocation2.tags = [[NSMutableArray alloc] init];
    newLocation2.imageURLs = [[NSMutableArray alloc] init];
    [newLocation2.imageURLs addObject:@"https://static1.squarespace.com/static/5115ccdae4b04c436ed83ed4/572810e737013ba5d459b4f3/572810efe32140b8013928a0/1462243575441/Sunnyside+Conservatory+Wedding-15.jpg"];
    [locations addObject:newLocation2];
 
    return locations;
    
}

/* #pragma mark - Networking

- (NSMutableArray *) fetchLocations: (NSMutableArray *) locations {
    PFQuery *query = [PFQuery queryWithClassName:@"Location"];
    [query whereKey:@"rating" greaterThan:@2.0];
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *places, NSError *error) {
        if (places != nil) {
            // do something with the array of object returned by the call
            for (Location *location in places){
                [locations addObject:location];
            }
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        return locations;
    }];
}
*/

@end
