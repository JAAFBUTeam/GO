//
//  CategoriesViewController.h
//  GO
//
//  Created by Joel Gutierrez on 7/24/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LargeImageCollectionViewCell.h"
#import "CategoryCollectionViewCell.h"
#import "ListViewController.h"
#import "GlobalFilters.h"
#import "FeatureCollectionViewCell.h"
#import "CategoryHeaderCollectionViewCell.h"
#import "LoadView.h"
#import "TitleCollectionViewCell.h"

@interface CategoriesViewController : UIViewController <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) FeatureCollectionViewCell *featureCollectionViewCell;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeLeft;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeRight;

@end
