//
//  TitleTableViewCell.h
//  GO
//
//  Created by Ajaita Saini on 7/18/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TitleTableViewDelegate

- (void) didTapAdd;

@end

@interface TitleTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *plus;

@property (nonatomic, weak) id<TitleTableViewDelegate> addDelegate;

-(void)setupTitleCell:(NSString *)stringTextValue;

@end
