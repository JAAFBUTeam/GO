//
//  CategoryCollectionViewCell.h
//  GO
//
//  Created by Joel Gutierrez on 7/24/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIImageView *gradientView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end
