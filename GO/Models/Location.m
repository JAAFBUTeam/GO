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
#import "UIImageView+AFNetworking.h"

@implementation Location

@dynamic title;
@dynamic synopsis;
@dynamic address;
@dynamic lat;
@dynamic lon;
@dynamic rating;
@dynamic tags;
@dynamic imageURLs;

+ (nonnull NSString *)parseClassName {
    return @"Location";
}

#pragma mark - Singleton

+ (NSMutableArray *)sharedLocations {
    static NSMutableArray *sharedLocation = nil;
    @synchronized(self) {
        if (sharedLocation == nil) {
            sharedLocation = [[NSMutableArray alloc] init];
            sharedLocation = [Location fetchLocations:sharedLocation];
        }
    }
    return sharedLocation;
}

#pragma mark - Networking

+ (void) postLocation: (PFBooleanResultBlock  _Nullable)completion { // posts all locations to heroku
    
    NSMutableArray <Location *> *locations = [[NSMutableArray alloc] init];
    Location *newLocation = [Location new];
    newLocation.title = @"MOMA";
    newLocation.synopsis = @"Some really cool art!";
    newLocation.address = @"151 3rd St, San Francisco, CA 94103";
    newLocation.lat = 37.7857;
    newLocation.lon = -122.4011;
    newLocation.rating = 4.9;
    newLocation.tags = [[NSMutableArray alloc] init];
    //[newLocation.tags addObject:[NSNumber numberWithInt: MUSEUM]];
    [newLocation.tags addObject:[NSNumber numberWithInt: ALL]];
    newLocation.imageURLs = [[NSMutableArray alloc] init];
    [newLocation.imageURLs addObject:@"https://s3-us-west-2.amazonaws.com/sfmomamedia/media/t/uploads/images/O1na7VIebCKV.jpg"];
    [newLocation.imageURLs addObject:@"https://cdn.funcheap.com/wp-content/uploads/2012/08/SFMOMAExteriorPhoto.jpg"];
    [newLocation.imageURLs addObject:@"https://s.hdnux.com/photos/24/65/77/5464024/7/920x920.jpg"];
    [newLocation.imageURLs addObject:@"https://www.arup.com/-/media/Arup/Images/Projects/S/SF-MOMA/SF_MOMA_image_3.jpg"];
    [newLocation.imageURLs addObject:@"https://s3-us-west-2.amazonaws.com/sfmomamedia/media/t/uploads/images/xVPY71fEXa-J.jpg"];
    [newLocation.imageURLs addObject:@"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSA88tJq1TCQcdvbOgrHW2FYPCgCUVa4E8w8f0N1-xveT2AqXGz"];
    
    [locations addObject:newLocation];
    
    Location *newLocation2 = [Location new];
    newLocation2.title = @"Sunnyside Conservatory";
    newLocation2.synopsis = @"A botanic jewel!";
    newLocation2.address = @"236 Monterey Blvd, San Francisco, CA 94131";
    newLocation2.lat = 37.731928;
    newLocation2.lon = -122.440789;
    newLocation2.rating = 4.0;
    newLocation2.tags = [[NSMutableArray alloc] init];
    //[newLocation2.tags addObject:[NSNumber numberWithInt: MUSEUM]];
    [newLocation2.tags addObject:[NSNumber numberWithInt: ALL]];
    newLocation2.imageURLs = [[NSMutableArray alloc] init];
    [newLocation2.imageURLs addObject:@"https://static1.squarespace.com/static/5115ccdae4b04c436ed83ed4/572810e737013ba5d459b4f3/572810efe32140b8013928a0/1462243575441/Sunnyside+Conservatory+Wedding-15.jpg"];
    [newLocation2.imageURLs addObject:@"https://twoirises.com/wp-content/uploads/2017/02/nae-web155.jpg"];
    [newLocation2.imageURLs addObject:@"https://twoirises.com/wp-content/uploads/2017/02/nae-web96.jpg"];
    [newLocation2.imageURLs addObject:@"https://untappedcities-wpengine.netdna-ssl.com/wp-content/uploads/2011/11/DSC_1309.jpg"];
    [newLocation2.imageURLs addObject:@"https://untappedcities-wpengine.netdna-ssl.com/wp-content/uploads/2011/11/DSC_1326.jpg"];
    [newLocation2.imageURLs addObject:@"https://sunnysideassociation.files.wordpress.com/2012/03/sunnyside-conservatory-org.jpg?w=500"];
    [newLocation2.imageURLs addObject:@"https://junebugweddings.com/wedding-blog/wp-content/uploads/2015/04/California-Hipster-Wedding-Sunnyside-Conservatory-Helena-Laurent-8-of-38-600x400.jpg"];
    
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
    
    Location *newLocation4 = [Location new];
    newLocation4.title = @"Golden Fire Hydrant";
    newLocation4.address = @"3899 20th St, San Francisco, CA 94114";
    newLocation4.lat = 37.7579793;
    newLocation4.lon = -122.4279487;
    newLocation4.synopsis = @"The golden fire hydrant that saved the Mission district in the aftermath of the 1906 earthquake!";
    newLocation4.rating = 3.9;
    newLocation4.tags = [[NSMutableArray alloc] init];
    [newLocation4.tags addObject:[NSNumber numberWithInt: SELFIESPOTS]];
    [newLocation4.tags addObject:[NSNumber numberWithInt: ALL]];
    newLocation4.imageURLs = [[NSMutableArray alloc] init];
    [newLocation4.imageURLs addObject:@"https://assets.rbl.ms/17570231/980x.jpg"];
    [newLocation4.imageURLs addObject:@"https://assets.atlasobscura.com/media/W1siZiIsInVwbG9hZHMvcGxhY2VfaW1hZ2VzL2Q4MTM2YjhjMjEwMjRmY2M5OF9wbGFxdWUuanBnIl0sWyJwIiwidGh1bWIiLCIxMjAweD4iXSxbInAiLCJjb252ZXJ0IiwiLXF1YWxpdHkgODEgLWF1dG8tb3JpZW50Il1d"];
    [newLocation4.imageURLs addObject:@"https://c1.staticflickr.com/5/4126/5186214251_1de97ea26e_b.jpg"];
    [newLocation4.imageURLs addObject:@"https://s3-media4.fl.yelpcdn.com/bphoto/2HeauOiFem9l7YvEsnoZ4A/o.jpg"];
    
    Location *newLocation5 = [Location new];
    newLocation5.title = @"Belden Place";
    newLocation5.address = @"Belden Place, San Francisco, CA 94104";
    newLocation5.lat = 37.791755;
    newLocation5.lon = -122.4061633;
    newLocation5.synopsis = @"The French Quarter of San Francisco!";
    newLocation5.rating = 4.0;
    newLocation5.tags = [[NSMutableArray alloc] init];
    [newLocation5.tags addObject:[NSNumber numberWithInt: FOOD]];
    [newLocation5.tags addObject:[NSNumber numberWithInt: ALL]];
    newLocation5.imageURLs = [[NSMutableArray alloc] init];
    [newLocation5.imageURLs addObject:@"https://c1.staticflickr.com/4/3184/2563000708_99f2a84a9c_b.jpg"];
    [newLocation5.imageURLs addObject:@"https://c1.staticflickr.com/5/4150/5072236420_75df3fbc00_b.jpg"];
    [newLocation5.imageURLs addObject:@"https://media-cdn.tripadvisor.com/media/photo-s/07/9b/22/63/cafe-bastille.jpg"];
    [newLocation5.imageURLs addObject:@"https://cdn1.gbot.me/photos/Ps/0E/1408123404/-_Belden_Place_in_My_Guide-20000000008282380-500x375.jpg"];
    [newLocation5.imageURLs addObject:@"https://cdn.vox-cdn.com/uploads/chorus_image/image/38910282/travelzoo-cafe-bastille-cbbp-1000061-regular.0.jpg"];
    
    Location *newLocation6 = [Location new];
    newLocation6.title = @"Home Cafe";
    newLocation6.address = @"1222 Noriega St, San Francisco, CA 94122";
    newLocation6.lat = 37.7544545;
    newLocation6.lon = -122.4770135;
    newLocation6.synopsis = @"Classic & unique latte drinks, plus creative toast options, served in a contemporary coffee shop!";
    newLocation6.rating = 4.2;
    newLocation6.tags = [[NSMutableArray alloc] init];
    [newLocation6.tags addObject:[NSNumber numberWithInt: FOOD]];
    [newLocation6.tags addObject:[NSNumber numberWithInt: SELFIESPOTS]];
    [newLocation6.tags addObject:[NSNumber numberWithInt: ALL]];
    newLocation6.imageURLs = [[NSMutableArray alloc] init];
    [newLocation6.imageURLs addObject:@"https://hoodwork-production.s3.amazonaws.com/uploads/story/image/9070/home3.jpg"];
    [newLocation6.imageURLs addObject:@"https://static1.squarespace.com/static/57689a02e4fcb58e1ae15194/57c7931446c3c48ab137934b/597b9186cd39c3708a0c9663/1515525222038/FullSizeRender+166.jpg?format=2500w"];
    [newLocation6.imageURLs addObject:@"https://s3.amazonaws.com/secretsaucefiles/photos/images/000/171/689/large/IMG_3562.JPG?1499805071"];
    [newLocation6.imageURLs addObject:@"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCtBngIfN_ClGYW0TmQeOEG7v-RpTqhJaFdX7LXnVzQfFpKSthvw"];
    [newLocation6.imageURLs addObject:@"https://s3-media2.fl.yelpcdn.com/bphoto/-XbIgKBLtfkAB79_q7NYIw/o.jpg"];
    [newLocation6.imageURLs addObject:@"https://s3-media2.fl.yelpcdn.com/bphoto/iADa_PtFSMA8BL3QurBszQ/o.jpg"];
    [newLocation6.imageURLs addObject:@"https://s3-media4.fl.yelpcdn.com/bphoto/PkzR2o1-rouCArfk6wqgYg/o.jpg"];
    [newLocation6.imageURLs addObject:@"https://s3-media4.fl.yelpcdn.com/bphoto/G2VaWiPGc8z0Zg14GsxAbQ/o.jpg"];
    [newLocation6.imageURLs addObject:@"https://s3-media2.fl.yelpcdn.com/bphoto/yJBWIspooiqKOP5EAjcABA/o.jpg"];
    [newLocation6.imageURLs addObject:@"https://s3-media2.fl.yelpcdn.com/bphoto/XYWxe0r2K6tjSHWMgjeUew/o.jpg"];
    
    Location *newLocation7 = [Location new];
    newLocation7.title = @"Winfield Street Slides";
    newLocation7.address = @"Winfield St & Esmeralda Ave, San Francisco, CA 94110";
    newLocation7.lat = 37.7434456;
    newLocation7.lon = -122.4180013;
    newLocation7.synopsis = @"A pair of slides and a tree-lined stair corridor!";
    newLocation7.rating = 4.7;
    newLocation7.tags = [[NSMutableArray alloc] init];
    [newLocation7.tags addObject:[NSNumber numberWithInt: SELFIESPOTS]];
    [newLocation7.tags addObject:[NSNumber numberWithInt: ALL]];
    newLocation7.imageURLs = [[NSMutableArray alloc] init];
    [newLocation7.imageURLs addObject:@"https://cdn2.gbot.me/photos/2W/gc/1472498041/Stair_slide-Esmerelda_Slide_Park-20000000009562117-500x375.jpg"];
    [newLocation7.imageURLs addObject:@"https://i1.wp.com/goldengatexpress.org/home/wp-content/uploads/2017/11/Esmeralda-Street-slides.-Winfield-St-Esmeralda-Ave-San-Francisco-CA-94110.jpg?resize=570%2C427"];
    [newLocation7.imageURLs addObject:@"https://s-media-cache-ak0.pinimg.com/originals/8d/2d/32/8d2d32e310c3f5c222e1cfe5ef71e865.jpg"];
    [newLocation7.imageURLs addObject:@"https://s3st3.openlistings.com/images/properties/v2/58c27807eed92819269ba382/768/475/58c30548b6f9f07ad67f9fc3.jpeg"];
    [newLocation7.imageURLs addObject:@"https://bloximages.newyork1.vip.townnews.com/thebaycitybeacon.com/content/tncms/assets/v3/editorial/3/22/322b9918-8965-11e7-977d-d3cfd381fb37/599fcf1a23ec8.image.jpg?resize=1200%2C800"];
    [newLocation7.imageURLs addObject:@"https://assets.atlasobscura.com/media/W1siZiIsInVwbG9hZHMvcGxhY2VfaW1hZ2VzL2M2YmNmNDZiMTQyNDZhNWY3OV9CZXJuYWwgMiAucG5nIl0sWyJwIiwidGh1bWIiLCJ4MzkwPiJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA4MSAtYXV0by1vcmllbnQiXV0/Bernal%202%20.png"];
    
    Location *newLocation8 = [Location new];
    newLocation8.title = @"Billy Goat Hill";
    newLocation8.address = @"2442 Castro St, San Francisco, CA 94131";
    newLocation8.lat = 37.741492;
    newLocation8.lon = -122.4329806;
    newLocation8.synopsis = @"A cute hilltop park complete with a swing that offers a view of San Francisco!";
    newLocation8.rating = 4.3;
    newLocation8.tags = [[NSMutableArray alloc] init];
    [newLocation8.tags addObject:[NSNumber numberWithInt: SELFIESPOTS]];
    [newLocation8.tags addObject:[NSNumber numberWithInt: ALL]];
    newLocation8.imageURLs = [[NSMutableArray alloc] init];
    [newLocation8.imageURLs addObject:@"https://hoodwork-production.s3.amazonaws.com/uploads/story/image/23315/Billy-Goat-Hill-Park_3.jpg"];
    [newLocation8.imageURLs addObject:@"https://www.opodo.fr/blog/wp-content/uploads/sites/16/2015/10/taylor-tippett.jpg"];
    [newLocation8.imageURLs addObject:@"https://cdn.funcheap.com/wp-content/uploads/2016/07/Melissa-Loesgen-Billy-Goat-Hill-600x4001.jpg"];
    [newLocation8.imageURLs addObject:@"https://cdn.herschelsupply.com/uploads/2015/06/HSC-SM15-CL-SanFrancisco_08.jpg"];
    [newLocation8.imageURLs addObject:@"https://s.hdnux.com/photos/50/40/21/10617951/5/940x940.jpg"];
    [newLocation8.imageURLs addObject:@"https://i2.wp.com/farm7.staticflickr.com/6237/6849796588_060e3e3e68_z.jpg"];
    [newLocation8.imageURLs addObject:@"https://theshannonigansoflife.files.wordpress.com/2015/05/img_1897.jpg"];
    
    Location *newLocation9 = [Location new];
    newLocation9.title = @"Hollow Cafe";
    newLocation9.address = @"1435 Irving St, San Francisco, CA 94122";
    newLocation9.lat = 37.7635512;
    newLocation9.lon = -122.4734028;
    newLocation9.synopsis = @"A pint-sized coffee shop with a handful of seats for snacking on espresso drinks, tea & baked goods!";
    newLocation9.rating = 4.1;
    newLocation9.tags = [[NSMutableArray alloc] init];
    [newLocation9.tags addObject:[NSNumber numberWithInt: SELFIESPOTS]];
    [newLocation9.tags addObject:[NSNumber numberWithInt: FOOD]];
    [newLocation9.tags addObject:[NSNumber numberWithInt: ALL]];
    newLocation9.imageURLs = [[NSMutableArray alloc] init];
    [newLocation9.imageURLs addObject:@"https://i.pinimg.com/originals/b8/b1/1c/b8b11c235ebb9a53855ad068c3ed17c6.jpg"];
    [newLocation9.imageURLs addObject:@"https://hoodwork-production.s3.amazonaws.com/uploads/story/image/3358/rsz_img_8462.jpg"];
    [newLocation9.imageURLs addObject:@"https://s3-media4.fl.yelpcdn.com/bphoto/J-BYUjVHl2bgZQ5iOWPagg/o.jpg"];
    [newLocation9.imageURLs addObject:@"https://s3-media2.fl.yelpcdn.com/bphoto/lcm5PKL1rAPiOuCtzaEHMA/o.jpg"];
    [newLocation9.imageURLs addObject:@"https://s3-media4.fl.yelpcdn.com/bphoto/IoHri3UFsppufDltzF4sCw/o.jpg"];
    [newLocation9.imageURLs addObject:@"https://s3-media3.fl.yelpcdn.com/bphoto/jKcGlvmCs9g-QihhunopAA/o.jpg"];
    [newLocation9.imageURLs addObject:@"https://s3-media3.fl.yelpcdn.com/bphoto/ANYCkCv9BsD6vQUa4QPsJA/o.jpg"];
    
    Location *newLocation10 = [Location new];
    newLocation10.title = @"Kirby Cove";
    newLocation10.address = @"Kirby Cove, San Francisco, CA";
    newLocation10.lat = 37.8260972;
    newLocation10.lon = -122.4985916;
    newLocation10.synopsis = @"A beach with a beautiful view of the Golden Gate Bridge!";
    newLocation10.rating = 4.3;
    newLocation10.tags = [[NSMutableArray alloc] init];
    [newLocation10.tags addObject:[NSNumber numberWithInt: SELFIESPOTS]];
    [newLocation10.tags addObject:[NSNumber numberWithInt: ALL]];
    newLocation10.imageURLs = [[NSMutableArray alloc] init];
    [newLocation10.imageURLs addObject:@"https://s3-media3.fl.yelpcdn.com/bphoto/C14rGoFS0IDo9I7kaVilMQ/o.jpg"];
    [newLocation10.imageURLs addObject:@"https://s3-media3.fl.yelpcdn.com/bphoto/_Ns8cbL0fxkEFV5sm_TB_w/o.jpg"];
    [newLocation10.imageURLs addObject:@"https://s3-media2.fl.yelpcdn.com/bphoto/E_DHnagYETT5jvqUXsyIcw/o.jpg"];
    [newLocation10.imageURLs addObject:@"https://s3-media2.fl.yelpcdn.com/bphoto/ufawKuzor5ifopRfVrSiJg/o.jpg"];
    [newLocation10.imageURLs addObject:@"https://s3-media2.fl.yelpcdn.com/bphoto/Ps7JfcFoxGUXtPOTJq6bkg/o.jpg"];
    [newLocation10.imageURLs addObject:@"https://s3-media2.fl.yelpcdn.com/bphoto/AB9PMkXxZrG6EMpQhTeSSw/o.jpg"];
    [newLocation10.imageURLs addObject:@"https://s3-media4.fl.yelpcdn.com/bphoto/8Yza10QBzzvziZ6ly6njig/o.jpg"];
    
    [newLocation saveInBackgroundWithBlock: completion];
    [newLocation2 saveInBackgroundWithBlock: completion];
    [newLocation3 saveInBackgroundWithBlock: completion];
    [newLocation4 saveInBackgroundWithBlock: completion];
    [newLocation5 saveInBackgroundWithBlock: completion];
    [newLocation6 saveInBackgroundWithBlock: completion];
    [newLocation7 saveInBackgroundWithBlock: completion];
    [newLocation8 saveInBackgroundWithBlock: completion];
    [newLocation9 saveInBackgroundWithBlock: completion];
    [newLocation10 saveInBackgroundWithBlock: completion];
    
}

#pragma mark - Networking

+ (NSMutableArray *) fetchLocations: (NSMutableArray *) locations { // grabs locations from heroku
    PFQuery *query = [PFQuery queryWithClassName:@"Location"];
    //[query whereKey:@"rating" greaterThan:@2.0];
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *places, NSError *error) {
        if (places != nil) {
            // do something with the array of object returned by the call
            for (Location *location in places){
                NSLog(@"oine");
                [locations addObject:location];
            }
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
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

@end
