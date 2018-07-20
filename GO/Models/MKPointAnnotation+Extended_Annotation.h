//
//  MKPointAnnotation+Extended_Annotation.h
//  GO
//
//  Created by Amy Liu on 7/16/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "Location.h"
#import "UIImage+AFNetworking.h"

@interface MKPointAnnotation (Extended_Annotation)

@property (nonatomic, strong) Location *location;
@property (nonatomic, strong) UIImage *picture;

@end
