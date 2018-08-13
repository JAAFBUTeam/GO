//
//  Review.m
//  GO
//
//  Created by Amy Liu on 7/20/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "Review.h"
#import "User.h"

@implementation Review

@dynamic location;
@dynamic reviewText;
@dynamic rating;
@dynamic user;

+ (nonnull NSString *)parseClassName {
    return @"Review";
}

#pragma mark - Networking

+ (void) postReview: (Review *)review withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    [review saveInBackgroundWithBlock: completion];
}

@end
