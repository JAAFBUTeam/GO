//
//  ReviewsTableViewCell.m
//  GO
//
//  Created by Amy Liu on 7/18/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "ReviewsTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "HCSStarRatingView.h"

@implementation ReviewsTableViewCell

#pragma mark - Visuals

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted) {
        self.contentView.backgroundColor = UIColor.whiteColor;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        self.contentView.backgroundColor = UIColor.whiteColor;
    }
}

#pragma mark - View Life Cycle

-(void)setupReviewsTableViewCell:(Review *) review {
    
    if (review != nil) {
    User *user = [review.user fetchIfNeeded];
    self.userImage.file = user.image;
    self.userImage.layer.cornerRadius = self.userImage.frame.size.width / 2;
    self.userImage.clipsToBounds = YES;
    self.username.text = review.user.username;
    
    self.locationImage.layer.cornerRadius = self.userImage.frame.size.width / 2;
    self.locationImage.clipsToBounds = YES;
    
    HCSStarRatingView *starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(73, 24, 96, 48)];
    starRatingView.maximumValue = 5;
    starRatingView.minimumValue = 0;
    starRatingView.allowsHalfStars = YES;
    starRatingView.value = (double) review.rating;
    starRatingView.tintColor = [UIColor redColor];
    [self.contentView insertSubview:starRatingView belowSubview:self.username.viewForLastBaselineLayout];

    self.reviewText.text = review.reviewText;
    
    [self.userImage loadInBackground];
    } else {
        self.userImage.file = nil;
        self.username.text = nil;
        self.rating.text = nil;
        self.reviewText.text = nil;
        self.button.alpha = 0.0;
    }
}

-(void)setupReviewsTableViewCell:(User *) user withReview: (Review *) review {

//    user = [user fetchIfNeeded];
    
    Location *location = [review.location fetchIfNeeded];
    NSString *firstImageURL = location.imageURLs.firstObject;
    NSURL *url = [[NSURL alloc] initWithString:firstImageURL];
    //NSData *imageData = [NSData dataWithContentsOfURL:url];
    //[UIImage imageWithData:imageData]];
    //self.userImage.file
    [self.locationImage setImageWithURL:url];
    
    self.userImage.layer.cornerRadius = self.userImage.frame.size.width / 2;
    self.userImage.clipsToBounds = YES;
    self.username.text = location.title;
    
    self.locationImage.layer.cornerRadius = self.userImage.frame.size.width / 2;
    self.locationImage.clipsToBounds = YES;
    
    HCSStarRatingView *starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(73, 24, 96, 48)];
    starRatingView.maximumValue = 5;
    starRatingView.minimumValue = 0;
    starRatingView.allowsHalfStars = YES;
    starRatingView.value = (double) review.rating;
    starRatingView.tintColor = [UIColor redColor];
    [self insertSubview:starRatingView aboveSubview:self.contentView];
    
    self.reviewText.text = review.reviewText;
    
}

- (IBAction)tappedMore:(id)sender {
    [self.delegate didTapMore:self.review.user];
    NSLog(@"Thanks for the tap!");
}

#pragma mark - Conversion

- (PFFile *)getPFFileFromImage: (UIImage * _Nullable)image {
    
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFile fileWithName:@"image.png" data:imageData];
}

@end
