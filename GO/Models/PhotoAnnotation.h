//
//  PhotoAnnotation.h
//  GO
//
//  Created by Amy Liu on 7/16/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "MapKit/MapKit.h"
#import <UIKit/UIKit.h>

@interface PhotoAnnotation : NSObject <MKAnnotation>

@property (strong, nonatomic) UIImage *photo;

@end
