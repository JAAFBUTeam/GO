//
//  InfoTableViewCell.m
//  GO
//
//  Created by Amy Liu on 7/18/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "InfoTableViewCell.h"

@implementation InfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setTableProperties:(Location *)location{
    self.title.text = location.title;
    self.address.text = location.address;
    self.synopsis.text = location.synopsis;
    double ratingDouble = location.rating;
    self.rating.text = [NSString stringWithFormat:@"%.1f", ratingDouble];
}

@end
