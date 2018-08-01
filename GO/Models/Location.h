//
//  Location.h
//  GO
//
//  Created by Amy Liu on 7/16/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImage+AFNetworking.h"
#import "Parse/Parse.h"
#import "ParseUI.h"

@interface Location : PFObject <PFSubclassing>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *synopsis;
@property (nonatomic, strong) NSString *address;

@property (nonatomic) float lat;
@property (nonatomic) float lon;
@property (nonatomic) double rating;
@property(nonatomic) double distanceAway;

+ (Location *)createLocation;
+ (void) postLocation: (PFBooleanResultBlock  _Nullable)completion;

@property(nonatomic, strong) NSMutableArray<UIImage *> *images;
@property(nonatomic, strong) NSMutableArray<NSString *> *imageURLs;
@property(nonatomic, strong) NSMutableArray *tags;


+ (NSMutableArray *) createLocations;
- (NSMutableArray *) fillArray: (NSMutableArray *) pictures;

@end
