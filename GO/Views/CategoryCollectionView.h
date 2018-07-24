//
//  CategoryCollectionView.h
//  GO
//
//  Created by Joel Gutierrez on 7/24/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryCollectionViewCell.h"

@interface CategoryCollectionView : UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *categoriesImagesArray;
@property (strong, nonatomic) NSMutableArray *categoriesLabelsArray;
@property (nonatomic, assign) NSInteger rows;
@property (nonatomic, assign) NSInteger columns;

@end
