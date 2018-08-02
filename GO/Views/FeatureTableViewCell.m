//
//  FeatureTableViewCell.m
//  GO
//
//  Created by Ajaita Saini on 8/2/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "FeatureTableViewCell.h"
#import <Parse/Parse.h>
#import "Location.h"

@implementation FeatureTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onSwipePageControl:(id)sender {
    self.testLabel.text = [NSString stringWithFormat:@"%li", ([self.pageControl currentPage]+1)];
}


@end
