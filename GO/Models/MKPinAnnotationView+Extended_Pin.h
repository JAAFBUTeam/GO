//
//  MKPinAnnotationView+Extended_Pin.h
//  GO
//
//  Created by Amy Liu on 7/17/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "Location.h"
#import "UIImage+AFNetworking.h"

@interface MKPinAnnotationView (Extended_Pin)

@property (nonatomic, strong) Location *location;
@property (nonatomic, strong) UIImage *image;

@end
