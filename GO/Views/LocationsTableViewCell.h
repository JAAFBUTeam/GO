//
//  LocationsTableViewCell.h
//  GO
//
//  Created by Joel Gutierrez on 7/16/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
#import "UIImageView+AFNetworking.h"
#import "iCarousel.h"

@interface LocationsTableViewCell : UITableViewCell <iCarouselDelegate, iCarouselDataSource>

@property (strong, nonatomic) Location *location;
@property (strong, nonatomic) NSMutableArray *locationImagesArray;
@property (weak, nonatomic) IBOutlet iCarousel *carousel;

-(void) setLocationObject:(Location *)location;

@end
