//
//  InfoTableViewCell.m
//  GO
//
//  Created by Amy Liu on 7/18/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "InfoTableViewCell.h"
#import "CurrentLocationPosition.h"

@implementation InfoTableViewCell

#pragma mark - Lifecycle

- (void)awakeFromNib {
    [super awakeFromNib];
    //self.address
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setupViewTapGesture];
}

#pragma mark - Setup cell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setTableProperties:(Location *)location{
    self.title.text = location.title;
    self.address.text = location.address;
    self.synopsis.text = location.synopsis;
    double ratingDouble = location.rating;
    self.rating.text = [NSString stringWithFormat:@"%.1f", ratingDouble];
    self.distanceAway.text = [[NSString stringWithFormat:@"%.1f",location.distanceAway] stringByAppendingString:@" miles away"];
}

-(void)setSectionIDProperty:(NSInteger)sectionID {
    self.sectionID = sectionID;
}

-(void)hideAddressAndSynopsisLabel{
    self.synopsis.text = nil;
    self.address.text = nil;
    [self.address removeFromSuperview];
    [self.synopsis removeFromSuperview];
}

#pragma mark - actions

-(void)didTap{
    [self.labelDelegate labelTapped:self.sectionID];
}
-(void)setupViewTapGesture {
    self.contentView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
    tapGesture.numberOfTapsRequired = 1;
    [self.contentView addGestureRecognizer:tapGesture];
}

@end
