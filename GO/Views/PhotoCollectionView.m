//
//  PhotoCollectionView.m
//  GO
//
//  Created by Ajaita Saini on 7/19/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "PhotoCollectionView.h"
#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionView

# pragma mark - Lifecycle

- (void)awakeFromNib {
    [super awakeFromNib];
}


# pragma mark - Collection View setup

-(void)createCollectionViewCell {
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    layout.minimumInteritemSpacing = 1;
    layout.minimumLineSpacing = 1;
    CGFloat imagesInEachLine = 3;
    CGFloat imageWidth = (self.collectionView.frame.size.width - layout.minimumInteritemSpacing * (imagesInEachLine -1)) / imagesInEachLine;
    CGFloat imageHeight = imageWidth;
    layout.itemSize = CGSizeMake(imageWidth, imageHeight);
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}


# pragma mark - Collection View Datasource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [self.collectionView registerNib:[UINib nibWithNibName:@"PhotoCollectionViewCell" bundle:nil]
             forCellWithReuseIdentifier:@"PhotoCollectionViewCell"];
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCollectionViewCell" forIndexPath:indexPath];
    
    cell.galleryImage.image = [UIImage imageNamed:@"dog.jpg"];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

@end
