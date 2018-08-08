//
//  FeatureTableView.h
//  GO
//
//  Created by Ajaita Saini on 8/8/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"

@interface FeatureTableView : UICollectionViewCell <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) Location* currentLocation;
@property(nonatomic, strong) NSMutableArray<Location *> *locations;
@property(nonatomic, weak) IBOutlet UITableView *tableView;

-(void)swipePageControl:(UISwipeGestureRecognizer *)direction;

@end
