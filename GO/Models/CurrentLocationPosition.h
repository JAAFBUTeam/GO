//
//  CurrentLocationPosition.h
//  GO
//
//  Created by Ajaita Saini on 7/29/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parse/Parse.h"
#import "Location.h"
#import <CoreLocation/CoreLocation.h>

@interface CurrentLocationPosition : NSObject

@property (nonatomic, strong) CLLocation *currentLocation;

+ (CurrentLocationPosition *)sharedInstance;
-(void)setUserCurrentLocation;
-(double)setDistance:(Location *)location;

@end
