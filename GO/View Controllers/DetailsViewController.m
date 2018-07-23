//
//  DetailedViewController.m
//  GO
//
//  Created by Amy Liu on 7/13/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "DetailsViewController.h"
#import "InfoTableViewCell.h"
#import "TitleTableViewCell.h"
#import "ReviewsTableViewCell.h"
#import "PhotoCollectionView.h"
#import "CarouselTableViewCell.h"
#import "ReviewViewController.h"

@interface DetailsViewController () <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) NSMutableArray<UIImage *> *imagesCopy;

typedef enum {
    CAROUSEL = 0,
    INFO = 1,
    TITLE_REVIEW = 2,
    REVIEW_1 = 3,
    REVIEW_2 = 4,
    REVIEW_3 = 5,
    TITLE_PHOTOS = 6,
    IMAGE_COLLECTION = 7
} cell_state;

@end

@implementation DetailsViewController

# pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self setImageArray];
    [self registerNibs];
}

-(void)setImageArray {
    _imagesCopy = _location.images;
}


# pragma mark - Register nibs

-(void)registerNibs {
    UINib *infoTableViewCell = [UINib nibWithNibName:@"InfoTableViewCell" bundle:nil];
    [_tableView registerNib:infoTableViewCell forCellReuseIdentifier:@"InfoTableViewCell"];
    
    UINib *titleTableViewCell = [UINib nibWithNibName:@"TitleTableViewCell" bundle:nil];
    [_tableView registerNib:titleTableViewCell forCellReuseIdentifier:@"TitleTableViewCell"];
    
    UINib *reviewTableViewCell = [UINib nibWithNibName:@"ReviewTableViewCell" bundle:nil];
    [_tableView registerNib:reviewTableViewCell forCellReuseIdentifier:@"ReviewTableViewCell"];
    
    UINib *photoCollectionView = [UINib nibWithNibName:@"PhotoCollectionView" bundle:nil];
    [_tableView registerNib:photoCollectionView forCellReuseIdentifier:@"PhotoCollectionView"];
    
    UINib *carouselTableViewCell = [UINib nibWithNibName:@"CarouselTableViewCell" bundle:nil];
    [self.tableView registerNib:carouselTableViewCell forCellReuseIdentifier:@"CarouselTableViewCell"];
}

# pragma mark - Tableview Datasource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        switch(indexPath.section){
        case CAROUSEL: {
            CarouselTableViewCell *carouselTableViewCell = [self.tableView dequeueReusableCellWithIdentifier:@"CarouselTableViewCell"];
            [carouselTableViewCell setupCarouselCell];
            return carouselTableViewCell;
        }
        case INFO: {
            InfoTableViewCell *infoTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"InfoTableViewCell"];
            [infoTableViewCell setTableProperties:_location];
            return infoTableViewCell;
        }
        case TITLE_REVIEW: {
            TitleTableViewCell *titleTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"TitleTableViewCell"];
            [titleTableViewCell setupTitleCell:@"Reviews"];
            return titleTableViewCell;
        }
        case REVIEW_1: {
            ReviewsTableViewCell *reviewTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"ReviewTableViewCell"];
            [reviewTableViewCell setupReviewsTableViewCell:[UIImage imageNamed:@"cat.jpg"] setupUsername:@"Cat" setupRating:@"1 star" setupReviewText:@"review text for Cat"];
            return reviewTableViewCell;
        }
        case REVIEW_2: {
            ReviewsTableViewCell *reviewTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"ReviewTableViewCell"];
            [reviewTableViewCell setupReviewsTableViewCell:[UIImage imageNamed:@"dog.jpg"] setupUsername:@"Dog1" setupRating:@"3 stars" setupReviewText:@"review text for Dog1"];
            return reviewTableViewCell;
        }
        case REVIEW_3: {
            ReviewsTableViewCell *reviewTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"ReviewTableViewCell"];
            [reviewTableViewCell setupReviewsTableViewCell:[UIImage imageNamed:@"dog.jpg"] setupUsername:@"Dog2" setupRating:@"4 stars" setupReviewText:@"review text for Dog2"];
            return reviewTableViewCell;
        }
        case TITLE_PHOTOS: {
            TitleTableViewCell *titleTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"TitleTableViewCell"];
            [titleTableViewCell setupTitleCell:@"Photos"];
            return titleTableViewCell;
        }
        case IMAGE_COLLECTION: {
            PhotoCollectionView *collectionViewTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"PhotoCollectionView"];
            [collectionViewTableViewCell createCollectionViewCell];
            return collectionViewTableViewCell;
        }
        default:{
            TitleTableViewCell *titleTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"TitleTableViewCell"];
            [titleTableViewCell setupTitleCell:@"Placeholder"];
            return titleTableViewCell;
        }
    }
}


# pragma mark - Tableview Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2){
        [self performSegueWithIdentifier:@"reviewsSegue" sender:nil];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 8;
}


# pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CarouselTableViewCell *tappedCell = sender;
    ReviewViewController *reviewsController = [segue destinationViewController];
    reviewsController.location = tappedCell.location;
}

@end
