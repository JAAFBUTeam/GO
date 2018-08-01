//
//  DetailInfoTableViewCell.m
//  GO
//
//  Created by Ajaita Saini on 7/29/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "DetailInfoTableViewCell.h"
#import "CurrentLocationPosition.h"
#import "APIManager.h"

@implementation DetailInfoTableViewCell

#pragma mark - Lifecycle

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


#pragma mark - Setup cell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)setTableProperties:(Location *)location{
    _map_location = location;
    self.title.text = location.title;
    [self.address setTitle:location.address forState:UIControlStateNormal];
    self.synopsis.text = location.synopsis;
    double ratingDouble = location.rating;
    self.rating.text = [NSString stringWithFormat:@"%.1f", ratingDouble];
}

- (IBAction)onTapAddress:(id)sender {
    CLLocationCoordinate2D mapCoordinate = CLLocationCoordinate2DMake(_map_location.lat, _map_location.lon);
    MKPlacemark *mapPlacemark = [[MKPlacemark alloc] initWithCoordinate:mapCoordinate addressDictionary:nil];
    MKMapItem *item = [[MKMapItem alloc] initWithPlacemark:mapPlacemark];
    [item setName:_map_location.title];
    [item openInMapsWithLaunchOptions:nil];
}

@end
