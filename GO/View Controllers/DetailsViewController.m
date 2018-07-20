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

# pragma mark - Table view setup

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        switch(indexPath.section){
            //read online that you shouldnt be declaring variables inside case blocks?
        case CAROUSEL: {
            CarouselTableViewCell *carouselTableViewCell = [self.tableView dequeueReusableCellWithIdentifier:@"CarouselTableViewCell"];
            [carouselTableViewCell setLocationObject:_location];
            return carouselTableViewCell;
        }
        case INFO: {
            InfoTableViewCell *infoTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"InfoTableViewCell"];
            infoTableViewCell.title.text = _location.title;
            infoTableViewCell.address.text = _location.address;
            infoTableViewCell.synopsis.text = _location.synopsis;
            return infoTableViewCell;
        }
        case TITLE_REVIEW: {
            TitleTableViewCell *titleTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"TitleTableViewCell"];
            titleTableViewCell.title.text = @"Reviews";
            return titleTableViewCell;
        }
        case REVIEW_1: {
            ReviewsTableViewCell *reviewTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"ReviewTableViewCell"];
            reviewTableViewCell.userImage.image = [UIImage imageNamed:@"cat.jpg"];
            reviewTableViewCell.username.text = @"Cat";
            reviewTableViewCell.rating.text = @"1 star";
            reviewTableViewCell.reviewText.text = @"review text for Cat";
            return reviewTableViewCell;
        }
        case REVIEW_2: {
            ReviewsTableViewCell *reviewTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"ReviewTableViewCell"];
            reviewTableViewCell.userImage.image = [UIImage imageNamed:@"dog.jpg"];
            reviewTableViewCell.username.text = @"Dog1";
            reviewTableViewCell.rating.text = @"5 star";
            reviewTableViewCell.reviewText.text = @"review text for Dog1";
            return reviewTableViewCell;
        }
        case REVIEW_3: {
            ReviewsTableViewCell *reviewTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"ReviewTableViewCell"];
            reviewTableViewCell.userImage.image = [UIImage imageNamed:@"dog.jpg"];
            reviewTableViewCell.username.text = @"Dog2";
            reviewTableViewCell.rating.text = @"4 stars";
            reviewTableViewCell.reviewText.text = @"review text for Dog2";
            return reviewTableViewCell;
        }
        case TITLE_PHOTOS: {
            TitleTableViewCell *titleTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"TitleTableViewCell"];
            titleTableViewCell.title.text = @"Photos";
            return titleTableViewCell;
        }
        case IMAGE_COLLECTION: {
            PhotoCollectionView *collectionViewTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"PhotoCollectionView"];
            [collectionViewTableViewCell createCollectionViewCell];
            return collectionViewTableViewCell;
        }
        default:{
            TitleTableViewCell *titleTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"TitleTableViewCell"];
            titleTableViewCell.title.text = @"Placeholder";
            return titleTableViewCell;
        }
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
    return 9;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CarouselTableViewCell *tappedCell = sender;
    ReviewViewController *reviewsController = [segue destinationViewController];
    reviewsController.location = tappedCell.location;
}

@end
