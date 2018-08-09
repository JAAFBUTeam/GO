//
//  TitleCollectionViewCell.h
//  GO
//
//  Created by Ajaita Saini on 8/8/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;

-(void)setLabelText:(NSString *)stringVal;

@end
