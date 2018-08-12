//
//  TitleTableViewCell.m
//  GO
//
//  Created by Ajaita Saini on 7/18/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "TitleTableViewCell.h"

@implementation TitleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self registerGestures];
}

-(void)setupTitleCell:(NSString *)stringTextValue {
    if (![stringTextValue isEqualToString:@"Photos"]) {
        [self.plus setHidden:TRUE];
    }
    self.title.text = stringTextValue;
}

-(void)registerGestures {
    self.plus.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedAdd)];
    tapGesture.numberOfTapsRequired = 1;
    [self.plus addGestureRecognizer:tapGesture];
}

#pragma mark - actions

-(void)tappedAdd {
    [self.addDelegate didTapAdd];
}

#pragma mark - visuals

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.contentView.backgroundColor = UIColor.whiteColor;
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted) {
        self.contentView.backgroundColor = UIColor.whiteColor;
    }
}


@end
