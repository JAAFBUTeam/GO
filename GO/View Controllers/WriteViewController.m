//
//  WriteViewController.m
//  GO
//
//  Created by Amy Liu on 7/30/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "WriteViewController.h"
#import "HCSStarRatingView.h"
#import "Review.h"

@interface WriteViewController ()

@end

@implementation WriteViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupRatings];
}

#pragma mark - Ratings

- (void)setupRatings {
    HCSStarRatingView *starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(50, 200, 200, 50)];
    starRatingView.maximumValue = 5;
    starRatingView.minimumValue = 0;
    starRatingView.value = 0;
    starRatingView.tintColor = [UIColor colorWithRed:0.97 green:0.80 blue:0.31 alpha:1.0];
    starRatingView.allowsHalfStars = YES;
    [starRatingView addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:starRatingView];
    
    starRatingView.translatesAutoresizingMaskIntoConstraints = NO;
    [[NSLayoutConstraint constraintWithItem:starRatingView
                                  attribute:NSLayoutAttributeTop
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeTop
                                 multiplier:1.f
                                   constant: 80.f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:starRatingView
                                  attribute:NSLayoutAttributeCenterX
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeCenterX
                                 multiplier:1.f
                                   constant:0.f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:starRatingView
                                  attribute:NSLayoutAttributeWidth
                                  relatedBy:NSLayoutRelationLessThanOrEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeWidth
                                 multiplier:.9f
                                   constant:0.f] setActive:YES];
}

- (IBAction)didChangeValue:(HCSStarRatingView *)sender {
    self.rating = (double) sender.value;
}

#pragma mark - Actions

- (IBAction)didTapSubmit:(id)sender {
    Review *newReview = [Review new];
    newReview.location = self.location;
    newReview.user = User.currentUser;
    newReview.reviewText = self.reviewText.text;
    newReview.rating = self.rating;
    
    [Review postReview:newReview withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        [User.currentUser.reviews addObject:newReview];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (IBAction)didTapCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
