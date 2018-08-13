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

-(void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self registerGestures];
}

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
    self.review = review;
    User *user = [review.user fetchIfNeeded];
    self.userImage.file = user.image;
    self.userImage.layer.cornerRadius = self.userImage.frame.size.width / 2;
    self.userImage.clipsToBounds = YES;
    self.username.text = review.user.username;
    
    self.locationImage.layer.cornerRadius = self.userImage.frame.size.width / 2;
    self.locationImage.clipsToBounds = YES;
    
    self.stars = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(73, 24, 96, 48)];
    self.stars.maximumValue = 5;
    self.stars.minimumValue = 0;
    self.stars.allowsHalfStars = YES;
    self.stars.value = (double) review.rating;
    self.stars.tintColor = [UIColor colorWithRed:0.97 green:0.80 blue:0.31 alpha:1.0];
    self.stars.userInteractionEnabled = NO;

    [self.contentView insertSubview:self.stars belowSubview:self.username.viewForLastBaselineLayout];

    self.reviewText.text = review.reviewText;
    
    [self.userImage loadInBackground];
    } else {
        self.userImage.file = nil;
        self.username.text = nil;
        self.rating.text = nil;
        self.reviewText.text = nil;
        self.moreButton.alpha = 0.0;
    }
}

-(void)setupReviewsTableViewCell:(User *) user withReview: (Review *) review {
//    user = [user fetchIfNeeded];
    
    self.review = review;
    Location *location = [review.location fetchIfNeeded];
    NSString *firstImageURL = location.imageURLs.firstObject;
    NSURL *url = [[NSURL alloc] initWithString:firstImageURL];
    [self.locationImage setImageWithURL:url];
    
    self.userImage.layer.cornerRadius = self.userImage.frame.size.width / 2;
    self.userImage.clipsToBounds = YES;
    self.username.text = location.title;
    
    self.locationImage.layer.cornerRadius = self.userImage.frame.size.width / 2;
    self.locationImage.clipsToBounds = YES;
    
    self.stars = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(73, 24, 96, 48)];
    self.stars.maximumValue = 5;
    self.stars.minimumValue = 0;
    self.stars.allowsHalfStars = YES;
    self.stars.value = (double) review.rating;
    self.stars.tintColor = [UIColor colorWithRed:0.97 green:0.80 blue:0.31 alpha:1.0];
    self.stars.userInteractionEnabled = NO;
    [self.contentView addSubview:self.stars];
    [self.contentView insertSubview:self.stars belowSubview:self.username.viewForLastBaselineLayout];
    
    self.reviewText.text = review.reviewText;
}

-(void)registerGestures {
    self.moreButton.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedMore)];
    tapGesture.numberOfTapsRequired = 1;
    [self.moreButton addGestureRecognizer:tapGesture];
}

-(void)tappedMore {
    [self.delegate didTapMore:self.review.user];
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
