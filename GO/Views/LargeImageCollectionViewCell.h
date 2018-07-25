//
//  LargeImageCollectionViewCell.h
//  GO
//
//  Created by Joel Gutierrez on 7/25/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LargeImageCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
-(void)setBigImage;

@end
