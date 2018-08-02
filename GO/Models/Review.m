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

+ (void) postReviews: (PFBooleanResultBlock  _Nullable)completion {
    
    NSLog(@"uploading hopefully");
    Review *newReview = [Review new];
//    newReview.location = @"MOMA";
    newReview.user = User.currentUser;
    newReview.reviewText = @"Wow, this place really is super cool!";
    newReview.rating = 5.0;
    
    Review *newReview1 = [Review new];
//    newReview1.location = @"MOMA";
    newReview1.user = User.currentUser;
    newReview1.reviewText = @"Nice art!";
    newReview1.rating = 4.5;
    
    Review *newReview2 = [Review new];
//    newReview2.location = @"16th Avenue Tiled Steps";
    newReview2.user = User.currentUser;
    newReview2.reviewText = @"It glows!";
    newReview2.rating = 4.9;
    
    Review *newReview3 = [Review new];
//    newReview3.location = @"Sunnyside Conservatory";
    newReview3.user = User.currentUser;
    newReview3.reviewText = @"Beautiful place for weddings!";
    newReview3.rating = 4.8;
    
    [newReview saveInBackgroundWithBlock: completion];
    [newReview1 saveInBackgroundWithBlock: completion];
    [newReview2 saveInBackgroundWithBlock: completion];
    [newReview3 saveInBackgroundWithBlock: completion];
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
