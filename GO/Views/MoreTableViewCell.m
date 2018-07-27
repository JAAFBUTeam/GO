//
//  MoreTableViewCell.m
//  GO
//
//  Created by Ajaita Saini on 7/27/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "MoreTableViewCell.h"
#import "DetailsViewController.h"

@implementation MoreTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)onTapMore:(id)sender {
    //[self performSegueWithIdentifier:@"photoGalleryViewSegue" sender:nil];
}

@end
