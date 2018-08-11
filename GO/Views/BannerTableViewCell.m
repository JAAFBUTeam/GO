//
//  BannerTableViewCell.m
//  GO
//
//  Created by Amy Liu on 8/10/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "BannerTableViewCell.h"

@implementation BannerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void) setBanner: (UIImageView *)image {
    self.image = image;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        self.contentView.backgroundColor = UIColor.whiteColor;
    }
}

@end
