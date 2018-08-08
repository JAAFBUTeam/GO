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
#import "CategoryHeaderCollectionViewCell.h"
#import "LoadView.h"
#import "FeatureTableView.h"

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

- (void)viewWillAppear:(BOOL)animated {
    
    LoadView *view = [[LoadView alloc] init];
    
    [self.view addSubview:view];
    //[self bringSubviewToFront:view];
    
    [UIView animateWithDuration:2 animations:^{view.alpha = 0.0;}
                     completion:(void (^)(BOOL)) ^{
                         [view removeFromSuperview];
                     }
     ];
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
    
    UINib *featureViewCell = [UINib nibWithNibName:@"FeatureTableViewCell" bundle:nil];
    [self.categoriesCollectionView registerNib:featureViewCell forCellWithReuseIdentifier:@"FeatureTableViewCell"];
    
    UINib *headerCollectionViewCell = [UINib nibWithNibName:@"CategoryHeaderCollectionViewCell" bundle:nil];
    [self.categoriesCollectionView registerNib:headerCollectionViewCell forCellWithReuseIdentifier:@"CategoryHeaderCollectionViewCell"];
    
}

-(void)setTableDimensions {
    self.sections = 2;
    self.numberOfCategories = 8;
    self.categoriesPerLine = 2;
    self.phoneWidth = [UIScreen mainScreen].bounds.size.width;
    
    self.imageHeight = 250;
    self.categorySectionInset = 10;
    self.minInteritemSpacing = 10;
}

-(void)initCategoriesArray {
    self.categoriesImagesArray = [[NSMutableArray alloc]init];
    self.categoriesLabelsArray = [[NSMutableArray alloc]init];
    
    [self.categoriesImagesArray addObject:@"ALL.png"]; //0
    
    [self.categoriesImagesArray addObject:@"SELFIE.png"]; //1
    
    [self.categoriesImagesArray addObject:@"FOOD.png"]; //2
    
    [self.categoriesImagesArray addObject:@"CAFES.png"]; //3
    
    [self.categoriesImagesArray addObject:@"ART.png"]; //4
    
    [self.categoriesImagesArray addObject:@"ARCHITECTURE.png"]; //5
    
    [self.categoriesImagesArray addObject:@"CULTURE.png"]; //6
    
    [self.categoriesImagesArray addObject:@"NATURE.png"]; //7
}

-(void)setCategoryCell:(CategoryCollectionViewCell*)cell item:(NSInteger)item {
    cell.image.image = [UIImage imageNamed:self.categoriesImagesArray[item]];
    cell.image.layer.cornerRadius = 10;
    cell.image.layer.masksToBounds = true;
}

#pragma mark - collection view protocol

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sections; //large image section and colletion view section
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(section == 0 || section == 1) { //big image section
        return 1;
    } else{ //section == 1;
        return self.numberOfCategories;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CategoryHeaderCollectionViewCell *headerCell = [self.categoriesCollectionView dequeueReusableCellWithReuseIdentifier:@"CategoryHeaderCollectionViewCell" forIndexPath:indexPath];
        return headerCell;
    } else if(indexPath.section == 1) {
        FeatureTableView *featureViewCell = [self.categoriesCollectionView dequeueReusableCellWithReuseIdentifier:@"FeatureTableViewCell" forIndexPath:indexPath];
        return featureViewCell;
    }
    else { //indexPath.section == 2
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
            } case SELFIESPOTS: {
                [GlobalFilters sharedInstance].categoryType = SELFIESPOTS;
                break;
            } case FOOD: {
                [GlobalFilters sharedInstance].categoryType = FOOD;
                break;
            } case CAFES: {
                [GlobalFilters sharedInstance].categoryType = CAFES;
                break;
            } case ART: {
                [GlobalFilters sharedInstance].categoryType = ART;
                break;
            } case ARCHITECTURE: {
                [GlobalFilters sharedInstance].categoryType = ARCHITECTURE;
                break;
            } case CULTUREANDHISTORY: {
                [GlobalFilters sharedInstance].categoryType = CULTUREANDHISTORY;
                break;
            } case NATURE: {
                [GlobalFilters sharedInstance].categoryType = NATURE;
                break;
            }
        }
        [GlobalFilters sharedInstance].appliedFilters = NO;
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
