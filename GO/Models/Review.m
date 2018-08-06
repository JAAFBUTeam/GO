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

+ (void) postReview: (Review *)review withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    [review saveInBackgroundWithBlock: completion];
}

/* #pragma mark - Networking

- (void) fetchReviews {
    PFQuery *query = [PFQuery queryWithClassName:@"Review"];
    if (self.user == nil) {
        [query whereKey:@"location" equalTo:self.location.title];
    } else {
        [query whereKey:@"user" equalTo:self.user];
    }
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *reviews, NSError *error) {
        if (reviews != nil) {
            // do something with the array of object returned by the call
            for (Review *review in reviews){
                [self.reviews addObject:review];
            }
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
} */

@end
