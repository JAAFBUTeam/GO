//
//  FeatureTableViewCell.h
//  GO
//
//  Created by Ajaita Saini on 8/2/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeatureTableViewCell : UITableViewCell

@property(nonatomic, strong) NSMutableArray<UIImage *> *images;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@end
