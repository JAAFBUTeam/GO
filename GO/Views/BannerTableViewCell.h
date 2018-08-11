//
//  BannerTableViewCell.h
//  GO
//
//  Created by Amy Liu on 8/10/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BannerTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;

- (void) setBanner: (UIImageView *)image;

@end
