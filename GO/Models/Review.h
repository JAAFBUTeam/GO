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

@interface Review : PFObject

@property (nonatomic, strong) NSString *location;

@property (strong, nonatomic) NSMutableArray <UIImage *> *userImage;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *reviewText;
@property (nonatomic) double rating;

+ (void) postLocation: (PFBooleanResultBlock  _Nullable)completion;

@end
