//
//  ProfileTableViewCell.h
//  GO
//
//  Created by Amy Liu on 7/23/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Parse/Parse.h"
#import "ParseUI/ParseUI.h"

@interface ProfileTableViewCell : UITableViewCell

@property (nonatomic, strong) User *user;
@property (weak, nonatomic) IBOutlet PFImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *username;

- (void)setProfile:(User *)user;
- (void)setProfile;


@end
