//
//  ReviewsTableViewCell.h
//  GO
//
//  Created by Amy Liu on 7/18/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Review.h"

@protocol ReviewsTableViewCellDelegate

- (void) didTapMore;

@end

@interface ReviewsTableViewCell : UITableViewCell

@property (nonatomic, weak) id<ReviewsTableViewCellDelegate> delegate;

@property (nonatomic, strong) Review *review;

@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *rating;
@property (weak, nonatomic) IBOutlet UILabel *reviewText;

-(void)setupReviewsTableViewCell:(UIImage *)image setupUsername:(NSString *)username setupRating:(NSString *)rating setupReviewText:(NSString *)reviewText;

@end
