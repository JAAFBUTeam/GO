//
//  CategoriesViewController.m
//  GO
//
//  Created by Joel Gutierrez on 7/24/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "CategoriesViewController.h"
#import "CurrentLocationPosition.h"
#import "FeatureCollectionViewCell.h"

@interface CategoriesViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *categoriesCollectionView;
@property (strong, nonatomic) NSMutableArray *categoriesImagesArray;
@property (strong, nonatomic) NSMutableArray *categoriesLabelsArray;
@property (nonatomic, assign) NSInteger numberOfCategories;
@property (nonatomic, assign) NSInteger sections;
@property (nonatomic, assign) NSInteger categoriesPerLine;
@property (nonatomic, assign) NSInteger imageHeight;
@property (nonatomic, assign) NSInteger categorySectionInset;
@property (nonatomic, assign) CGFloat phoneWidth;
@property (nonatomic, assign) CGFloat minInteritemSpacing;

@end

@implementation CategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDelegateAndDataSource];
    [self registerNibs];
    [self setTableDimensions];
    [self initCategoriesArray];
    [CurrentLocationPosition sharedInstance];
    [self setGestureRecognizers];
    
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
    
    UINib *featureCollectionViewCell = [UINib nibWithNibName:@"FeatureCollectionViewCell" bundle:nil];
    [self.categoriesCollectionView registerNib:featureCollectionViewCell forCellWithReuseIdentifier:@"FeatureCollectionViewCell"];
}

-(void)setTableDimensions {
    self.sections = 2;
    self.numberOfCategories = 6;
    self.categoriesPerLine = 2;
    self.phoneWidth = [UIScreen mainScreen].bounds.size.width;
    
    self.imageHeight = 250;
    self.categorySectionInset = 15;
    self.minInteritemSpacing = 15;
}

-(void)initCategoriesArray {
    self.categoriesImagesArray = [[NSMutableArray alloc]init];
    self.categoriesLabelsArray = [[NSMutableArray alloc]init];
    
    [self.categoriesImagesArray addObject:@"icons8-checked-48.png"]; //0
    [self.categoriesLabelsArray addObject:@"All"];
    
    [self.categoriesImagesArray addObject:@"icons8-food-40.png"]; //1
    [self.categoriesLabelsArray addObject:@"Food"];
    
    [self.categoriesImagesArray addObject:@"icons8-selfie-48.png"]; //2
    [self.categoriesLabelsArray addObject:@"Selfie Spots"];
    
    [self.categoriesImagesArray addObject:@"icons8-bed-48.png"]; //3
    [self.categoriesLabelsArray addObject:@"Museum"];
    
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
        self.featureCollectionViewCell = [self.categoriesCollectionView dequeueReusableCellWithReuseIdentifier:@"FeatureCollectionViewCell" forIndexPath:indexPath];
        return self.featureCollectionViewCell;
//        LargeImageCollectionViewCell *largeImageCell = [self.categoriesCollectionView dequeueReusableCellWithReuseIdentifier:@"LargeImageCollectionViewCell" forIndexPath:indexPath];
//        [largeImageCell setBigImage];
//        return largeImageCell;
    } else { //indexPath.section == 1
        CategoryCollectionViewCell *categoryCell = [self.categoriesCollectionView dequeueReusableCellWithReuseIdentifier:@"CategoryCollectionViewCell" forIndexPath:indexPath];
        [self setCategoryCell:categoryCell item:indexPath.item];
        return categoryCell;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 1) {
        switch(indexPath.item) {
            case ALL: {
                [GlobalFilters sharedInstance].categoryType = ALL;
                break;
            } case FOOD: {
                [GlobalFilters sharedInstance].categoryType = FOOD;
                break;
            } case SELFIESPOTS: {
                [GlobalFilters sharedInstance].categoryType = SELFIESPOTS;
                break;
            } case MUSEUM: {
                [GlobalFilters sharedInstance].categoryType = MUSEUM;
                break;
            } case EVENTS: {
                [GlobalFilters sharedInstance].categoryType = EVENTS;
                break;
            } case GAS: {
                [GlobalFilters sharedInstance].categoryType = GAS;
                break;
            }
        }
        [GlobalFilters sharedInstance].appliedFilters = NO;
        // [self.navigationController popViewControllerAnimated:YES];
        [self performSegueWithIdentifier:@"categoriesToListSegue" sender:nil];
    }
}

# pragma mark - collection view layout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) { //big image
        return CGSizeMake(self.phoneWidth, self.imageHeight);
    } else {
        return [self getCategoryItemSize];
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if(section == 0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    } else {
        return UIEdgeInsetsMake(self.categorySectionInset, self.categorySectionInset, self.categorySectionInset, self.categorySectionInset);
    }
}

-(CGSize)getCategoryItemSize {
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)self.categoriesCollectionView.collectionViewLayout;
    CGFloat categoryWidth = (self.phoneWidth - (self.minInteritemSpacing * (self.categoriesPerLine - 1) ) - (2 * self.categorySectionInset)) / self.categoriesPerLine;
    CGFloat categoryHeight = categoryWidth;
    layout.itemSize = CGSizeMake(categoryWidth, categoryHeight);
    return layout.itemSize;
}

# pragma mark - Gesture recognizer
-(void)setGestureRecognizers{
    _swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipe:)];
    _swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:_swipeLeft];
    
    _swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipe:)];
    _swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:_swipeRight];
}

- (void)onSwipe:(UISwipeGestureRecognizer *)swipeRecognizer {
    [self.featureCollectionViewCell swipePageControl:swipeRecognizer];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {}

@end
