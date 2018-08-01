//
//  FiltersViewController.h
//  GO
//
//  Created by Joel Gutierrez on 7/26/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalFilters.h"

@protocol ApplyFilterDelegate

-(void) applyButtonTap;

@end

@interface FiltersViewController : UIViewController

@property (nonatomic, weak) id<ApplyFilterDelegate> applyButtonDelegate;

@end
