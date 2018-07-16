//
//  DetailedViewController.h
//  GO
//
//  Created by Amy Liu on 7/13/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"

@interface DetailsViewController : UIViewController

@property (strong, nonatomic) Location *location;
@property (weak, nonatomic) IBOutlet UIImageView *location_image;

@end
