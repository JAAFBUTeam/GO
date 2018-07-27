//
//  SettingsViewController.h
//  GO
//
//  Created by Amy Liu on 7/24/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import "ParseUI/ParseUI.h"

@interface SettingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet PFImageView *image;
@property (weak, nonatomic) IBOutlet UIButton *changePhoto;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *username;

@end
