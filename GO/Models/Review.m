//
//  Review.m
//  GO
//
//  Created by Amy Liu on 7/20/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "Review.h"

@implementation Review

@dynamic reviewText;
@dynamic rating;
@dynamic location;
@dynamic user;

+ (nonnull NSString *)parseClassName {
    return @"Review";
}

+ (void) postReview: (PFBooleanResultBlock  _Nullable)completion {
    
    NSLog(@"uploading hopefully");
    Review *newReview = [Review new];
    newReview.location = @"MOMA";
    //newReview.userImage = [[NSMutableArray alloc] init];
    //[newReview.userImage addObject: [UIImage imageNamed:@"amy"]];
    newReview.reviewText = @"Wow, this place really is super cool!";
    newReview.user.username = @"CoolUser264";
    newReview.rating = 5.0;
    
    [newReview saveInBackgroundWithBlock: completion];
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
