//
//  PhotoAnnotation.m
//  GO
//
//  Created by Amy Liu on 7/16/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "PhotoAnnotation.h"
#import "MapKit/MapKit.h"

@interface PhotoAnnotation()

@property (nonatomic) CLLocationCoordinate2D coordinate;

@end

@implementation PhotoAnnotation

- (NSString *)title {
    return [NSString stringWithFormat:@"%f", self.coordinate.latitude];
}

@end
