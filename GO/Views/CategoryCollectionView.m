//
//  CategoryCollectionView.m
//  GO
//
//  Created by Joel Gutierrez on 7/24/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "CategoryCollectionView.h"

@implementation CategoryCollectionView

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setDelegateAndDataSource {
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

#pragma mark - collection view protocol

//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    
//}
//
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    
//}

@end
