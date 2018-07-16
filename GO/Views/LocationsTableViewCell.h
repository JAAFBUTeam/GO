//
//  LocationsTableViewCell.h
//  GO
//
//  Created by Joel Gutierrez on 7/16/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"

@interface LocationsTableViewCell : UITableViewCell

@property (strong, nonatomic) Location *location;
@property (weak, nonatomic) IBOutlet UIImageView *locationImage;

@end
