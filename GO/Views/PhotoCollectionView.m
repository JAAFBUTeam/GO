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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //[self createCollectionViewCell];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)createCollectionViewCell {
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCollectionViewCell" forIndexPath:indexPath];
    
    cell.galleryImage.image = [UIImage imageNamed:@"dog.jpg"];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

@end
