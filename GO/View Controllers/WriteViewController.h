//
//  WriteViewController.h
//  GO
//
//  Created by Amy Liu on 7/30/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseUI/ParseUI.h"
#import "Location.h"
#import "Parse/Parse.h"

@interface WriteViewController : UIViewController

@property (nonatomic, strong) Location *location;
@property (weak, nonatomic) IBOutlet UITextView *reviewText;
@property (nonatomic) double rating;

@end
