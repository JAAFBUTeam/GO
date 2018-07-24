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
    [self setDelegateAndDataSource];
    [self registerNibs];
    [self setRowsAndColumns];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setDelegateAndDataSource {
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

-(void)registerNibs {
    UINib *categoryNib = [UINib nibWithNibName:@"CategoryCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:categoryNib forCellWithReuseIdentifier:@"CategoryCollectionViewCell"];
}

-(void)setRowsAndColumns {
    self.rows = 2;
    self.columns = 3;
}

-(void)initCategoriesArray {
    self.categoriesImagesArray = [[NSMutableArray alloc]init];
    self.categoriesLabelsArray = [[NSMutableArray alloc]init];
    
    [self.categoriesImagesArray addObject:@"icons8-checked-48.png"]; //0
    [self.categoriesLabelsArray addObject:@"All"];
    
    [self.categoriesImagesArray addObject:@"icons8-food-40.png"]; //1
    [self.categoriesLabelsArray addObject:@"Restaurants"];

    [self.categoriesImagesArray addObject:@"icons8-selfie-48.png"]; //2
    [self.categoriesLabelsArray addObject:@"Selfie Spots"];
    
    [self.categoriesImagesArray addObject:@"icons8-bed-48.png"]; //3
    [self.categoriesLabelsArray addObject:@"Hotels"];
    
    [self.categoriesImagesArray addObject:@"icons8-two-tickets-40"]; //4
    [self.categoriesLabelsArray addObject:@"Events"];
    
    [self.categoriesImagesArray addObject:@"icons8-gas-station-40.png"]; //5
    [self.categoriesLabelsArray addObject:@"Gas"];
}

-(void)setCell:(CategoryCollectionViewCell*)cell section:(NSInteger)section column:(NSInteger)column {
    NSInteger arrayIndex = (section*self.columns) + column;
    
}



#pragma mark - collection view protocol

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.rows;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.columns;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CategoryCollectionViewCell *categoryCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryCollectionViewCell" forIndexPath:indexPath];

    return categoryCell;
}

@end
