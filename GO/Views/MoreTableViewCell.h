//
//  MoreTableViewCell.h
//  GO
//
//  Created by Ajaita Saini on 7/27/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LabelDelegate

-(void)didTapLabel:(NSString *)identifier;

@end

@interface MoreTableViewCell : UITableViewCell

@property (nonatomic, weak) id<LabelDelegate> labelDelegate;
@property (nonatomic, strong) NSString *segueIdentifier;

@end
