//
//  LocationsTableViewCell.m
//  GO
//
//  Created by Joel Gutierrez on 7/16/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "LocationsTableViewCell.h"

@implementation LocationsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setLocationObject:(Location *)location {
    self.location = location;
    [self setDummyImageData];
}

-(void)setDummyImageData {
    NSString * locationImageString = @"https://media.licdn.com/dms/image/C5103AQFSzkTQcTNk3A/profile-displayphoto-shrink_200_200/0?e=1537401600&v=beta&t=jRM2BEccIEAMatPgEkw0RtNf5qYE2Bqx412fqD7zESg";
    NSURL *locationURL = [NSURL URLWithString:locationImageString];
    self.locationImage.image = nil;
    [self.locationImage setImageWithURL:locationURL];
}

@end
