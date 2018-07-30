//
//  Review.h
//  GO
//
//  Created by Amy Liu on 7/20/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImage+AFNetworking.h"
#import "Parse/Parse.h"
#import "ParseUI.h"
#import "Location.h"
#import "User.h"

@interface Review : PFObject <PFSubclassing>

@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) User *user;

@property (strong, nonatomic) NSString *reviewText;
@property (nonatomic) double rating;

+ (void) postReviews: (PFBooleanResultBlock  _Nullable)completion;

@end
