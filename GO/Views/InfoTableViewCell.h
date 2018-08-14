//
//  InfoTableViewCell.h
//  GO
//
//  Created by Amy Liu on 7/18/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"

@protocol InfoTapDelegate

-(void)labelTapped:(NSUInteger)section;
-(BOOL)bookmarkTapped:(NSUInteger)section;

@end

@interface InfoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *address;
@property (weak, nonatomic) IBOutlet UILabel *synopsis;
@property (weak, nonatomic) IBOutlet UILabel *rating;
@property (weak, nonatomic) IBOutlet UILabel *distanceAway;
@property (strong, nonatomic) Location *map_location;
@property (nonatomic, weak) id<InfoTapDelegate> labelDelegate;
@property (weak, nonatomic) IBOutlet UIImageView *label;
@property (nonatomic, assign) NSInteger sectionID;
@property (weak, nonatomic) IBOutlet UIImageView *bookmarkImageView;
@property (weak, nonatomic) IBOutlet UIImageView *star;

-(void)setTableProperties:(Location *)location;
-(void)setSectionIDProperty:(NSInteger)sectionID;
-(void)hideAddressLabel;
-(void)hideRating;
-(void)highlightBookmark:(BOOL)shouldHighlight;

@end
