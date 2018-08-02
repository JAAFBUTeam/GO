//
//  DetailedViewController.h
//  GO
//
//  Created by Amy Liu on 7/13/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
#import "InstagramKit.h"
#import "MoreTableViewCell.h"

@interface DetailsViewController : UIViewController <LabelDelegate>

@property (strong, nonatomic) Location *location;
@property (weak, nonatomic) IBOutlet UIImageView *location_image;
@property (strong, nonatomic) NSMutableArray<InstagramMedia *> *mediaGalleryByLocation;
@property (nonatomic, strong) CLLocationManager *currentLocation;

@end
