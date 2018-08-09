//
//  TitleCollectionViewCell.m
//  GO
//
//  Created by Ajaita Saini on 8/8/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "TitleCollectionViewCell.h"

@implementation TitleCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setLabelText:(NSString *)stringVal {
    self.title.text = stringVal;
}

@end
