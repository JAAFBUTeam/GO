//
//  DetailInfoTableViewCell.h
//  GO
//
//  Created by Ajaita Saini on 7/29/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"

@interface DetailInfoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *synopsis;
@property (weak, nonatomic) IBOutlet UILabel *rating;
@property (weak, nonatomic) IBOutlet UILabel *distanceAway;
@property (weak, nonatomic) IBOutlet UIButton *address;
@property (strong, nonatomic) Location *map_location;

-(void)setTableProperties:(Location *)location;

@end
