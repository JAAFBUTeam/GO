//
//  InfoTableViewCell.m
//  GO
//
//  Created by Amy Liu on 7/18/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "InfoTableViewCell.h"
#import "CurrentLocationPosition.h"
#import "APIManager.h"

@implementation InfoTableViewCell

#pragma mark - Lifecycle

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setupTapGestures];
}

#pragma mark - Setup cell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setTableProperties:(Location *)location{
    self.map_location = location;
    [self.address setTitle:location.address forState:UIControlStateNormal];
    self.title.text = location.title;
    self.synopsis.text = location.synopsis;
    double ratingDouble = location.rating;
    self.rating.text = [NSString stringWithFormat:@"%.1f", ratingDouble];
    self.distanceAway.text = [[NSString stringWithFormat:@"%.1f",location.distanceAway] stringByAppendingString:@" miles away"];
}

-(void)setSectionIDProperty:(NSInteger)sectionID {
    self.sectionID = sectionID;
}

-(void)hideAddressLabel{
    [self.address setTitle:nil forState:UIControlStateNormal];
    [self.address removeFromSuperview];
}

-(void)highlightBookmark:(BOOL)shouldHighlight {
    if(shouldHighlight) {
        self.bookmarkImageView.highlighted = YES;
    } else {
        self.bookmarkImageView.highlighted = NO;
    }
}

#pragma mark - actions

- (IBAction)onTapAddress:(id)sender {
    CLLocationCoordinate2D mapCoordinate = CLLocationCoordinate2DMake(_map_location.lat, _map_location.lon);
    MKPlacemark *mapPlacemark = [[MKPlacemark alloc] initWithCoordinate:mapCoordinate addressDictionary:nil];
    MKMapItem *item = [[MKMapItem alloc] initWithPlacemark:mapPlacemark];
    [item setName:_map_location.title];
    [item openInMapsWithLaunchOptions:nil];
}

-(void)didTapRow {
    [self.labelDelegate labelTapped:self.sectionID];
}

-(void)didTapBookmark {
    if(self.bookmarkImageView.highlighted){
        self.bookmarkImageView.highlighted = NO;
    } else {
        self.bookmarkImageView.highlighted = YES;
    }
    [self.labelDelegate bookmarkTapped:self.sectionID];
}

-(void)setupTapGestures {
    self.contentView.userInteractionEnabled = YES;
    UITapGestureRecognizer *rowTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapRow)];
    rowTapGesture.numberOfTapsRequired = 1;
    [self.contentView addGestureRecognizer:rowTapGesture];
    
    self.bookmarkImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *bookmarkTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapBookmark)];
    bookmarkTapGesture.numberOfTapsRequired = 1;
    [self.bookmarkImageView addGestureRecognizer:bookmarkTapGesture];
}

@end
