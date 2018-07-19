//
//  MKAnnotationView+Extended_View.h
//  GO
//
//  Created by Amy Liu on 7/17/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "Location.h"
#import "UIImage+AFNetworking.h"

@interface MKAnnotationView (Extended_View)

@property (nonatomic, strong) Location *location;
@property (nonatomic, strong) UIImage *image;

@end
