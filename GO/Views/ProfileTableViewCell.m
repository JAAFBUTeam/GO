//
//  ProfileTableViewCell.m
//  GO
//
//  Created by Amy Liu on 7/23/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "ProfileTableViewCell.h"
#import "User.h"

@implementation ProfileTableViewCell

- (void) awakeFromNib {
    [super awakeFromNib];
}

- (void)setProfile:(User *)user {
    self.user = user;
    
    self.image.file = self.user.image;
    self.username.text = self.user.username;
    self.name.text = self.user.name;
    
    [self.image loadInBackground];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        self.contentView.backgroundColor = UIColor.whiteColor;
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted) {
        self.contentView.backgroundColor = UIColor.whiteColor;
    }
}

@end
