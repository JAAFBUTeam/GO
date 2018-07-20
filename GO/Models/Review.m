//
//  Review.m
//  GO
//
//  Created by Amy Liu on 7/20/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "Review.h"

@implementation Review

@dynamic userImage;
@dynamic username;
@dynamic reviewText;
@dynamic rating;

- (void) postLocation: (PFBooleanResultBlock  _Nullable)completion {
    
    NSLog(@"uploading hopefully");
    Review *newReview = [Review new];
    newReview.location = @"MOMA";
    newReview.userImage = [[NSMutableArray alloc] init];
    [newReview.userImage addObject: [UIImage imageNamed:@"amy"]];
    newReview.reviewText = @"Wow, this place really is super cool!";
    newReview.username = @"CoolUser264";
    newReview.rating = 5.0;
    
    [newReview saveInBackgroundWithBlock: completion];
}

@end
