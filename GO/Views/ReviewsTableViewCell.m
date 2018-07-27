//
//  ReviewsTableViewCell.m
//  GO
//
//  Created by Amy Liu on 7/18/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "ReviewsTableViewCell.h"

@implementation ReviewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupReviewsTableViewCell:(UIImage *)image setupUsername:(NSString *)username setupRating:(NSString *)rating setupReviewText:(NSString *)reviewText {
    self.userImage.image = image;
    self.username.text = username;
    self.rating.text = rating;
    self.reviewText.text = reviewText;
}

- (IBAction)tappedMore:(id)sender {
    [self.delegate didTapMore:self.review.user];
    NSLog(@"Thanks for the tap!");
}


@end
