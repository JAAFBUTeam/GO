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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupReviewsTableViewCell:(Review *) review {
    
    User *user = [review.user fetchIfNeeded];
    self.userImage.file = user.image;
    self.userImage.layer.cornerRadius = self.userImage.frame.size.width / 2;
    self.userImage.clipsToBounds = YES;
    self.username.text = review.user.username;
    
    self.rating.text = [[NSNumber numberWithDouble:review.rating] stringValue];
    self.reviewText.text = review.reviewText;
    
    [self.userImage loadInBackground];

}

-(void)setupReviewsTableViewCell:(User *) user withReview: (Review *) review {

    UIImageView *imageView = [[UIImageView alloc] init];
    Location *location = [review.location fetchIfNeeded];
    user = [user fetchIfNeeded];
    NSURL *url =  [[NSURL alloc] initWithString: location.imageURLs[0]];
    [imageView setImageWithURL:url];
    PFFile *file = [self getPFFileFromImage: imageView.image];
    self.userImage.file = file;
    self.userImage.layer.cornerRadius = self.userImage.frame.size.width / 2;
    self.userImage.clipsToBounds = YES;
    self.username.text = location.title;
    
    HCSStarRatingView *starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(73, 24, 96, 48)];
    starRatingView.maximumValue = 5;
    starRatingView.minimumValue = 0;
    starRatingView.allowsHalfStars = YES;
    starRatingView.value = (double) review.rating;
    starRatingView.tintColor = [UIColor redColor];
    [self addSubview:starRatingView];
    [self sendSubviewToBack: starRatingView];
    
    // self.rating.text = [[NSNumber numberWithDouble:review.rating] stringValue];
    self.reviewText.text = review.reviewText;
    
    [self.userImage loadInBackground];
    
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
