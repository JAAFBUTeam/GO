//
//  ProfileTableViewCell.m
//  GO
//
//  Created by Amy Liu on 7/23/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "ProfileTableViewCell.h"
#import "User.h"
#import "ParseUI/ParseUI.h"
#import "Parse/Parse.h"
#import "UIImage+AFNetworking.h"

@implementation ProfileTableViewCell

- (void) awakeFromNib {
    [super awakeFromNib];
}

- (void)setProfile:(User *)user {
    self.user = user;
    
    self.image.layer.cornerRadius = self.image.frame.size.width / 2;
    self.image.clipsToBounds = YES;
    self.image.file = self.user.image;
    
    self.username.text = self.user.username;
    self.name.text = self.user.name;
    
    [self.image loadInBackground:^(UIImage * _Nullable image, NSError * _Nullable error) {
        NSLog(@"WOAH");
    }];
}

#pragma mark - Visuals

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        self.contentView.backgroundColor = UIColor.whiteColor;
        self.image.backgroundColor = UIColor.lightGrayColor;
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted) {
        self.contentView.backgroundColor = UIColor.whiteColor;
        self.image.backgroundColor = UIColor.lightGrayColor;
    }
}

@end
