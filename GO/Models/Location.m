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
#import "GlobalFilters.h"

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

+ (void) postLocation: (PFBooleanResultBlock  _Nullable)completion {
    
    NSMutableArray <Location *> *locations = [[NSMutableArray alloc] init];
    Location *newLocation = [Location new];
    newLocation.title = @"MOMA";
    newLocation.synopsis = @"Some really cool art!";
    newLocation.address = @"151 3rd St, San Francisco, CA 94103";
    newLocation.lat = 37.7857;
    newLocation.lon = -122.4011;
    newLocation.rating = 4.9;
    newLocation.tags = [[NSMutableArray alloc] init];
    [newLocation.tags addObject:[NSNumber numberWithInt: MUSEUM]];
    [newLocation.tags addObject:[NSNumber numberWithInt: ALL]];
    newLocation.imageURLs = [[NSMutableArray alloc] init];
    [newLocation.imageURLs addObject:@"https://s3-us-west-2.amazonaws.com/sfmomamedia/media/t/uploads/images/O1na7VIebCKV.jpg"];
    [newLocation.imageURLs addObject:@"https://cdn.funcheap.com/wp-content/uploads/2012/08/SFMOMAExteriorPhoto.jpg"];
    [newLocation.imageURLs addObject:@"https://s.hdnux.com/photos/24/65/77/5464024/7/920x920.jpg"];
    [newLocation.imageURLs addObject:@"https://www.arup.com/-/media/Arup/Images/Projects/S/SF-MOMA/SF_MOMA_image_3.jpg"];
    [newLocation.imageURLs addObject:@"https://s3-us-west-2.amazonaws.com/sfmomamedia/media/t/uploads/images/xVPY71fEXa-J.jpg"];
    [newLocation.imageURLs addObject:@"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSA88tJq1TCQcdvbOgrHW2FYPCgCUVa4E8w8f0N1-xveT2AqXGz"];

    //newLocation.images = [newLocation fillArray:newLocation.imageURLs];
    [locations addObject:newLocation];
    
    Location *newLocation2 = [Location new];
    newLocation2.title = @"Sunnyside Conservatory";
    newLocation2.synopsis = @"A botanic jewel!";
    newLocation2.address = @"236 Monterey Blvd, San Francisco, CA 94131";
    newLocation2.lat = 37.731928;
    newLocation2.lon = -122.440789;
    newLocation2.rating = 4.0;
    newLocation2.tags = [[NSMutableArray alloc] init];
    [newLocation2.tags addObject:[NSNumber numberWithInt: MUSEUM]];
    [newLocation2.tags addObject:[NSNumber numberWithInt: ALL]];
    newLocation2.imageURLs = [[NSMutableArray alloc] init];
    [newLocation2.imageURLs addObject:@"https://static1.squarespace.com/static/5115ccdae4b04c436ed83ed4/572810e737013ba5d459b4f3/572810efe32140b8013928a0/1462243575441/Sunnyside+Conservatory+Wedding-15.jpg"];
    [newLocation2.imageURLs addObject:@"https://twoirises.com/wp-content/uploads/2017/02/nae-web155.jpg"];
    [newLocation2.imageURLs addObject:@"https://twoirises.com/wp-content/uploads/2017/02/nae-web96.jpg"];
    [newLocation2.imageURLs addObject:@"https://untappedcities-wpengine.netdna-ssl.com/wp-content/uploads/2011/11/DSC_1309.jpg"];
    [newLocation2.imageURLs addObject:@"https://untappedcities-wpengine.netdna-ssl.com/wp-content/uploads/2011/11/DSC_1326.jpg"];
    [newLocation2.imageURLs addObject:@"https://sunnysideassociation.files.wordpress.com/2012/03/sunnyside-conservatory-org.jpg?w=500"];
    [newLocation2.imageURLs addObject:@"https://junebugweddings.com/wedding-blog/wp-content/uploads/2015/04/California-Hipster-Wedding-Sunnyside-Conservatory-Helena-Laurent-8-of-38-600x400.jpg"];

    //newLocation.images = [newLocation fillArray:newLocation.imageURLs];
    [locations addObject:newLocation2];
    
    Location *newLocation3 = [Location new];
    newLocation3.title = @"16th Avenue Tiled Steps";
    newLocation3.address = @"16th Ave, San Francisco, CA 94122";
    newLocation3.lat = 37.75663375854492;
    newLocation3.lon = -122.47356414794922;
    newLocation3.synopsis = @"Gorgeous tiled staircase!";
    newLocation3.rating = 4.3;
    newLocation3.tags = [[NSMutableArray alloc] init];
    [newLocation3.tags addObject:[NSNumber numberWithInt: SELFIESPOTS]];
    [newLocation3.tags addObject:[NSNumber numberWithInt: ALL]];
    newLocation3.imageURLs = [[NSMutableArray alloc] init];
    [newLocation3.imageURLs addObject:@"https://3.bp.blogspot.com/-UgBRK5ITezU/V1ZFDxTs9GI/AAAAAAAAB1I/y_W-RAJnibAbckLz5y2xjcG2hSWLnuOoACLcB/s1600/san%2Bfrancisco%2B16th%2Bave%2Btiled%2Bsteps%2B330x396x53kb.jpg"];
    [newLocation3.imageURLs addObject:@"https://assets.atlasobscura.com/media/W1siZiIsInVwbG9hZHMvcGxhY2VfaW1hZ2VzL2E2MGY2Y2MyNDVjNmEwM2U5MGEwMTJjYzYwMmQ1ODg4Yzc0ZWM4YmYuanBnIl0sWyJwIiwidGh1bWIiLCJ4MzkwPiJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA4MSAtYXV0by1vcmllbnQiXV0/a60f6cc245c6a03e90a012cc602d5888c74ec8bf.jpg"];
    [newLocation3.imageURLs addObject:@"https://s3-media4.fl.yelpcdn.com/bphoto/yNIqkR51EHtQTDiEAKmBNw/o.jpg"];
    [newLocation3.imageURLs addObject:@"https://i.pinimg.com/originals/93/c5/62/93c56288b2606f6c42b48937208b3d06.jpg"];
    [newLocation3.imageURLs addObject:@"https://i0.wp.com/inspiredimperfection.com/wp-content/uploads/2016/10/16th-ave-tiled-steps-ocean-san-francisco.jpg?ssl=1"];
    [newLocation3.imageURLs addObject:@"https://mymodernmet.com/wp/wp-content/uploads/archive/yYEoqhYiYYydURyAOzq-_1082098668.jpeg"];
    //newLocation.images = [newLocation fillArray:newLocation.imageURLs];
    
    [newLocation saveInBackgroundWithBlock: completion];
    [newLocation2 saveInBackgroundWithBlock: completion];
    [newLocation3 saveInBackgroundWithBlock: completion];
    
}

- (NSMutableArray *) fillArray: (NSMutableArray *) pictures {
    self.images = [[NSMutableArray alloc] init];
    for (NSString *picture in pictures) {
        NSURL *url = [[NSURL alloc] initWithString:picture];
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        /* PFImageView *image = [[PFImageView alloc] init];
        image.file = [self getPFFileFromImage:[UIImage imageWithData:imageData]]; */
        UIImage *image = [UIImage imageWithData:imageData];

        [self.images addObject:image];
    }
    return self.images;
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
    newLocation2.tags = [[NSMutableArray alloc] init];
    newLocation2.imageURLs = [[NSMutableArray alloc] init];
    [newLocation2.imageURLs addObject:@"https://static1.squarespace.com/static/5115ccdae4b04c436ed83ed4/572810e737013ba5d459b4f3/572810efe32140b8013928a0/1462243575441/Sunnyside+Conservatory+Wedding-15.jpg"];
    [locations addObject:newLocation2];
 
    Location *newLocation3 = [Location new];
    newLocation3.title = @"16th Avenue Tiled Steps";
    newLocation3.address = @"16th Ave, San Francisco, CA 94122";
    newLocation3.lat = 37.75663375854492;
    newLocation3.lon = -122.47356414794922;
    newLocation3.synopsis = @"Gorgeous tiled staircase!";
    newLocation3.rating = 4.3;
    newLocation.tags = [[NSMutableArray alloc] init];
    newLocation.imageURLs = [[NSMutableArray alloc] init];
    [newLocation.imageURLs addObject:@"https://3.bp.blogspot.com/-UgBRK5ITezU/V1ZFDxTs9GI/AAAAAAAAB1I/y_W-RAJnibAbckLz5y2xjcG2hSWLnuOoACLcB/s1600/san%2Bfrancisco%2B16th%2Bave%2Btiled%2Bsteps%2B330x396x53kb.jpg"];
    
    return locations;
    
}

#pragma mark - Conversion

- (PFFile *)getPFFileFromImage: (UIImage * _Nullable)image {
    
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFile fileWithName:@"image.png" data:imageData];
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
