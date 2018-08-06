//
//  FeatureCollectionViewCell.h
//  GO
//
//  Created by Ajaita Saini on 8/6/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"

@interface FeatureCollectionViewCell : UICollectionViewCell

@property(nonatomic, strong) Location* currentLocation;
@property(nonatomic, strong) NSMutableArray<Location *> *locations;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

-(void)swipePageControl:(UISwipeGestureRecognizer *)direction;

@end
