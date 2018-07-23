//
//  TitleTableViewCell.h
//  GO
//
//  Created by Ajaita Saini on 7/18/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;

-(void)setupTitleCell:(NSString *)stringTextValue;

@end
