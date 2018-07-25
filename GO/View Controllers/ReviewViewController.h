//
//  ReviewViewController.h
//  GO
//
//  Created by Amy Liu on 7/20/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Location.h"

@interface ReviewViewController : UIViewController

@property (nonatomic, strong) Location *location;
@property (nonatomic, strong) User *user;
-(void) fetchReviews;

@end
