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
    TITLE_FEATURED = 0,
    CAROUSEL = 1,
    TITLE_CATEGORIES = 2,
    CATEGORIES = 3,
} cell_state;

@end

@implementation CategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDelegateAndDataSource];
    [self registerNibs];
    [self setTableDimensions];
    [self initCategoriesArray];
    //[self setCategoryCell:<#(CategoryCollectionViewCell *)#> item:<#(NSInteger)#>]
    [CurrentLocationPosition sharedInstance];
    
    //set up handle view
    self.pullUpController = [[ISHPullUpViewController alloc] init];
    self.firstAppearanceCompleted = true;
    self.pullUpController.stateDelegate = self;
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.topView addGestureRecognizer:gesture];
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
    
    
    
    [self.categoriesImagesArray addObject:@"selfie spots.png"]; //0
    [self.categoriesLabelsArray addObject:@"selfie spots"];
    
    [self.categoriesImagesArray addObject:@"food.png"]; //1
    [self.categoriesLabelsArray addObject:@"food"];
    
    [self.categoriesImagesArray addObject:@"cafes.png"]; //2
    [self.categoriesLabelsArray addObject:@"cafes"];
    
    [self.categoriesImagesArray addObject:@"art.png"]; //3
    [self.categoriesLabelsArray addObject:@"art"];
    
    [self.categoriesImagesArray addObject:@"architecture.png"]; //4
    [self.categoriesLabelsArray addObject:@"architecture"];
    
    [self.categoriesImagesArray addObject:@"culture.png"];//5
    [self.categoriesLabelsArray addObject:@"culture"];
    
    [self.categoriesImagesArray addObject:@"nature.png"]; //6
    [self.categoriesLabelsArray addObject:@"nature"];
    
    [self.categoriesImagesArray addObject:@"all.png"]; //7
    [self.categoriesLabelsArray addObject:@"all"];
}

-(void)setCategoryCell:(CategoryCollectionViewCell*)cell item:(NSInteger)item {
    cell.image.image = [UIImage imageNamed:self.categoriesImagesArray[item]];
    cell.image.layer.cornerRadius = 10;
    cell.image.layer.masksToBounds = true;
    
    //set corner radius of gradient
    cell.gradientView.layer.cornerRadius = 10;
    cell.gradientView.layer.masksToBounds = true;
    
    //set label text
    cell.label.text = self.categoriesLabelsArray[item];
}

#pragma mark - collection view protocol

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sections; //large image section and colletion view section
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(section != 3) {
        return 1;
    } else {
        return self.numberOfCategories;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    switch(indexPath.section){
        case TITLE_FEATURED: { //index 0
            TitleCollectionViewCell *titleCollectionViewCell = [self.categoriesCollectionView dequeueReusableCellWithReuseIdentifier:@"TitleCollectionViewCell" forIndexPath:indexPath];
            [titleCollectionViewCell setLabelText:@"Featured"];
            return titleCollectionViewCell;
        }
        case CAROUSEL: { //index 1
            FeatureCollectionViewCell *featureViewCell = [self.categoriesCollectionView dequeueReusableCellWithReuseIdentifier:@"FeatureCollectionViewCell" forIndexPath:indexPath];
            return featureViewCell;
        }
        case TITLE_CATEGORIES: { //index 2
            TitleCollectionViewCell *titleCollectionViewCell = [self.categoriesCollectionView dequeueReusableCellWithReuseIdentifier:@"TitleCollectionViewCell" forIndexPath:indexPath];
            [titleCollectionViewCell setLabelText:@"Categories"];
            return titleCollectionViewCell;
        }
        case CATEGORIES: { //index 3
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
    if(indexPath.section == 3) {
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
    if (indexPath.section == 0 || indexPath.section == 2) {
        return CGSizeMake(self.phoneWidth, 40);
    } else if (indexPath.section == 1) { // carousel
        return CGSizeMake(self.phoneWidth, self.imageHeight + 150);
    } else if (indexPath.section == 3) {
        return [self getCategoryItemSize]; //categories
    } else {
        return CGSizeMake(self.phoneWidth, self.imageHeight);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if(section != 3) {
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

-(void)handleTap:(UITapGestureRecognizer *)gesture {
    if ([self.pullUpController isLocked]){
        return;
    }
    
    [_pullUpController toggleStateAnimated:true];
}

//- (CGFloat)pullUpViewController:(nonnull ISHPullUpViewController *)pullUpViewController maximumHeightForBottomViewController:(nonnull UIViewController *)bottomVC maximumAvailableHeight:(CGFloat)maximumAvailableHeight {
//}
//
//- (CGFloat)pullUpViewController:(nonnull ISHPullUpViewController *)pullUpViewController minimumHeightForBottomViewController:(nonnull UIViewController *)bottomVC {
//}
//
//- (CGFloat)pullUpViewController:(nonnull ISHPullUpViewController *)pullUpViewController targetHeightForBottomViewController:(nonnull UIViewController *)bottomVC fromCurrentHeight:(CGFloat)height {
//}
//
//- (void)pullUpViewController:(nonnull ISHPullUpViewController *)pullUpViewController updateEdgeInsets:(UIEdgeInsets)edgeInsets forBottomViewController:(nonnull UIViewController *)contentVC {
//}
//


- (void)pullUpViewController:(nonnull ISHPullUpViewController *)pullUpViewController didChangeToState:(ISHPullUpState)state {
    [self.handleView setState:[ISHPullUpHandleView handleStateForPullUpState:state] animated:_firstAppearanceCompleted];
    //    [UIView animateWithDuration:0.25 animations:^{
    //        if (state == ISHPullUpStateCollapsed){
    //            self.topView.alpha = 0;
    //        } else {
    //            self.topView.alpha = 1;
    //        }
    //    }];
}

//func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, didChangeTo state: ISHPullUpState) {
//    topLabel.text = textForState(state);
//    handleView.setState(ISHPullUpHandleView.handleState(for: state), animated: firstAppearanceCompleted)
//
//    // Hide the scrollview in the collapsed state to avoid collision
//    // with the soft home button on iPhone X
//    UIView.animate(withDuration: 0.25) { [weak self] in
//        self?.scrollView.alpha = (state == .collapsed) ? 0 : 1;
//    }
//}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {}

@end
