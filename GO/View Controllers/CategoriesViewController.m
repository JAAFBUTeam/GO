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
#import "TitleCollectionViewCell.h"

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
@property (nonatomic, assign) CGFloat phoneHeight;
@property (nonatomic, assign) CGFloat minInteritemSpacing;

typedef enum {
    HEADER = 0,
    TITLE_FEATURED = 1,
    CAROUSEL = 2,
    TITLE_CATEGORIES = 3,
    CATEGORIES = 4,
    MORE_REVIEWS = 5,
} cell_state;

@end

@implementation CategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDelegateAndDataSource];
    [self registerNibs];
    [self setTableDimensions];
    [self initCategoriesArray];
    [CurrentLocationPosition sharedInstance];
}

- (void)viewWillAppear:(BOOL)animated {
    
    LoadView *view = [[LoadView alloc] init];
    
    [self.view addSubview:view];
    
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
    
    UINib *featureTableView = [UINib nibWithNibName:@"FeatureCollectionViewCell" bundle:nil];
    [self.categoriesCollectionView registerNib:featureTableView forCellWithReuseIdentifier:@"FeatureCollectionViewCell"];
    
    UINib *headerCollectionViewCell = [UINib nibWithNibName:@"CategoryHeaderCollectionViewCell" bundle:nil];
    [self.categoriesCollectionView registerNib:headerCollectionViewCell forCellWithReuseIdentifier:@"CategoryHeaderCollectionViewCell"];
    
    UINib *titleCollectionViewCell = [UINib nibWithNibName:@"TitleCollectionViewCell" bundle:nil];
    [self.categoriesCollectionView registerNib:titleCollectionViewCell forCellWithReuseIdentifier:@"TitleCollectionViewCell"];
}

-(void)setTableDimensions {
    self.sections = 5;
    self.numberOfCategories = 8;
    self.categoriesPerLine = 2;
    self.phoneWidth = [UIScreen mainScreen].bounds.size.width;
    
    self.imageHeight = 100;
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
    if(section != 4) {
        return 1;
    } else {
        return self.numberOfCategories;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    switch(indexPath.section){
        case HEADER: { //index 0
            CategoryHeaderCollectionViewCell *headerCell = [self.categoriesCollectionView dequeueReusableCellWithReuseIdentifier:@"CategoryHeaderCollectionViewCell" forIndexPath:indexPath];
            return headerCell;
        }
        case TITLE_FEATURED: { //index 1
            TitleCollectionViewCell *titleCollectionViewCell = [self.categoriesCollectionView dequeueReusableCellWithReuseIdentifier:@"TitleCollectionViewCell" forIndexPath:indexPath];
            [titleCollectionViewCell setLabelText:@"Featured"];
            return titleCollectionViewCell;
        }
        case CAROUSEL: { //index 2
            FeatureCollectionViewCell *featureViewCell = [self.categoriesCollectionView dequeueReusableCellWithReuseIdentifier:@"FeatureCollectionViewCell" forIndexPath:indexPath];
            return featureViewCell;
        }
        case TITLE_CATEGORIES: { //index 3
            TitleCollectionViewCell *titleCollectionViewCell = [self.categoriesCollectionView dequeueReusableCellWithReuseIdentifier:@"TitleCollectionViewCell" forIndexPath:indexPath];
            [titleCollectionViewCell setLabelText:@"Categories"];
            return titleCollectionViewCell;
        }
        case CATEGORIES: { //index 4
            CategoryCollectionViewCell *categoryCell = [self.categoriesCollectionView dequeueReusableCellWithReuseIdentifier:@"CategoryCollectionViewCell" forIndexPath:indexPath];
            [self setCategoryCell:categoryCell item:indexPath.item];
            return categoryCell;
        }
        default:{
            TitleCollectionViewCell *titleCollectionViewCell = [self.categoriesCollectionView dequeueReusableCellWithReuseIdentifier:@"TitleCollectionViewCell" forIndexPath:indexPath];
            [titleCollectionViewCell setLabelText:@"Placeholder"];
            return titleCollectionViewCell;
        }
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 4) {
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
    if (indexPath.section == 2) {
        return CGSizeMake(self.phoneWidth, self.imageHeight + 150);
    } else if (indexPath.section == 4) {
        return [self getCategoryItemSize];
    } else {
        return CGSizeMake(self.phoneWidth, self.imageHeight);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if(section != 4) {
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

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {}

@end
