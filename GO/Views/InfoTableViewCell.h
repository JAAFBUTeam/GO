//
//  InfoTableViewCell.h
//  GO
//
//  Created by Amy Liu on 7/18/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"

@protocol LabelTapDelegate

-(void)labelTapped:(NSUInteger)section;

@end

@interface InfoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *synopsis;
@property (weak, nonatomic) IBOutlet UILabel *rating;
@property (weak, nonatomic) IBOutlet UILabel *distanceAway;
@property (nonatomic, weak) id<LabelTapDelegate> labelDelegate;
@property (nonatomic, assign) NSInteger sectionID;

-(void)setTableProperties:(Location *)location;
-(void)setSectionIDProperty:(NSInteger)sectionID;

@end
