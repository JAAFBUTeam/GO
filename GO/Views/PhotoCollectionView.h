//
//  PhotoCollectionView.h
//  GO
//
//  Created by Ajaita Saini on 7/19/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCollectionView : UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


-(void)createCollectionViewCell;

@end
