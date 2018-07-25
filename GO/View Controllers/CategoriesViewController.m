//
//  CategoriesViewController.m
//  GO
//
//  Created by Joel Gutierrez on 7/24/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "CategoriesViewController.h"

@interface CategoriesViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *categoriesCollectionView;
@property (strong, nonatomic) NSMutableArray *categoriesImagesArray;
@property (strong, nonatomic) NSMutableArray *categoriesLabelsArray;
@property (nonatomic, assign) NSInteger numberOfCategories;
@property (nonatomic, assign) NSInteger sections;


@end

@implementation CategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDelegateAndDataSource];
    [self registerNibs];
    [self setRowsAndColumns];
    [self autolayout];
    [self initCategoriesArray];
}

-(void)setDelegateAndDataSource {
    self.categoriesCollectionView.delegate = self;
    self.categoriesCollectionView.dataSource = self;
}

-(void) registerNibs {
    UINib *imageNib = [UINib nibWithNibName:@"LargeImageCollectionViewCell" bundle:nil];
    [self.categoriesCollectionView registerNib:imageNib forCellWithReuseIdentifier:@"LargeImageCollectionViewCell"];
    
    UINib *collectionNib = [UINib nibWithNibName:@"CategoryCollectionViewCell" bundle:nil];
    [self.categoriesCollectionView registerNib:collectionNib forCellWithReuseIdentifier:@"CategoryCollectionViewCell"];
}

-(void)setRowsAndColumns {
    self.sections = 2;
    self.numberOfCategories = 6;
}

-(void)autolayout {
    //    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    //    layout.minimumInteritemSpacing = 1;
    //    layout.minimumLineSpacing = 1;
    //    CGFloat imagesInEachLine = self.columns;
    //    CGFloat imageWidth = (self.collectionView.frame.size.width - layout.minimumInteritemSpacing * (imagesInEachLine -1)) / imagesInEachLine;
    //    CGFloat imageHeight = imageWidth;
    //    layout.itemSize = CGSizeMake(imageWidth, imageHeight);
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

-(void)setCategoryCell:(CategoryCollectionViewCell*)cell item:(NSInteger)item {
    cell.image.image = [UIImage imageNamed:self.categoriesImagesArray[item]];
    cell.label.text = self.categoriesLabelsArray[item];
}

#pragma mark - collection view protocol

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sections; //large image section and colletion view section
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(section == 0) { //big image section
        return 1;
    } else { //section == 1;
        return self.numberOfCategories;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        LargeImageCollectionViewCell *largeImageCell = [self.categoriesCollectionView dequeueReusableCellWithReuseIdentifier:@"LargeImageCollectionViewCell" forIndexPath:indexPath];
        [largeImageCell setBigImage];
        return largeImageCell;
    } else { //indexPath.section == 1
        CategoryCollectionViewCell *categoryCell = [self.categoriesCollectionView dequeueReusableCellWithReuseIdentifier:@"CategoryCollectionViewCell" forIndexPath:indexPath];
        [self setCategoryCell:categoryCell item:indexPath.item];
        return categoryCell;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 1) {
        [self performSegueWithIdentifier:@"categoriesToListSegue" sender:nil];
        NSLog(@"category selected - segue and send other data through");
    }
}

# pragma mark - collection view layout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100, 100);
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 1) {
//        return 600;
//    } else {
//        return UITableViewAutomaticDimension;
//    }
//}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //categor
    ListViewController *listController = [segue destinationViewController];
    //ListViewController.location = tappedCell.location;
}

@end
