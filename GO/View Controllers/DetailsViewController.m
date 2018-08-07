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
#import "InstagramKit.h"
#import "APIManager.h"
#import "PhotoCollectionViewController.h"
#import "MoreTableViewCell.h"

@interface DetailsViewController () <ReviewsTableViewCellDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) InstagramEngine *engine;
@property (nonatomic, strong) NSMutableArray *reviews;


typedef enum {
    CAROUSEL = 0,
    INFO = 1,
    TITLE_REVIEW = 2,
    REVIEW_1 = 3,
    REVIEW_2 = 4,
    MORE_REVIEWS = 5,
    TITLE_PHOTOS = 6,
    IMAGE_COLLECTION = 7,
    MORE_IMAGES = 8
} cell_state;

@end

@implementation DetailsViewController

# pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    self.navigationController.navigationBar.prefersLargeTitles = NO;
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back-24.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backTap)];
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor lightGrayColor];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self registerNibs];
}

-(void)backTap {
    [self.navigationController popViewControllerAnimated:YES];

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
    
    UINib *moreTableViewCell = [UINib nibWithNibName:@"MoreTableViewCell" bundle:nil];
    [self.tableView registerNib:moreTableViewCell forCellReuseIdentifier:@"MoreTableViewCell"];
    
    UINib *featureTableViewCell = [UINib nibWithNibName:@"FeatureTableViewCell" bundle:nil];
    [self.tableView registerNib:featureTableViewCell forCellReuseIdentifier:@"FeatureTableViewCell"];
}

# pragma mark - Tableview Datasource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        switch(indexPath.section){
        case CAROUSEL: {
            CarouselTableViewCell *carouselTableViewCell = [self.tableView dequeueReusableCellWithIdentifier:@"CarouselTableViewCell"];
            [carouselTableViewCell setCarouselTypeProperties:iCarouselTypeLinear];
            [carouselTableViewCell setLocationProperty:_location];
            [carouselTableViewCell setDatasourceAndDelegate];
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
            [reviewTableViewCell setupReviewsTableViewCell: reviewTableViewCell.review];
            return reviewTableViewCell;
        }
        case REVIEW_2: {
            ReviewsTableViewCell *reviewTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"ReviewTableViewCell"];
            [reviewTableViewCell setupReviewsTableViewCell: reviewTableViewCell.review];

            return reviewTableViewCell;
        }
        case MORE_REVIEWS: {
            MoreTableViewCell *moreTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"MoreTableViewCell"];
            moreTableViewCell.segueIdentifier = @"reviewsSegue";
            moreTableViewCell.labelDelegate = self;
            return moreTableViewCell;
        }
        case TITLE_PHOTOS: {
            TitleTableViewCell *titleTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"TitleTableViewCell"];
            [titleTableViewCell setupTitleCell:@"Photos"];
            return titleTableViewCell;
        }
        case IMAGE_COLLECTION: {
            PhotoCollectionView *collectionViewTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"PhotoCollectionView"];
            [collectionViewTableViewCell createCollectionViewCell:_location];
            return collectionViewTableViewCell;
        }
        case MORE_IMAGES: {
            MoreTableViewCell *moreTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"MoreTableViewCell"];
            moreTableViewCell.segueIdentifier = @"photoGalleryViewSegue";
            moreTableViewCell.labelDelegate = self;
            return moreTableViewCell;
        }
        default:{
            TitleTableViewCell *titleTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"TitleTableViewCell"];
            [titleTableViewCell setupTitleCell:@"Placeholder"];
            return titleTableViewCell;
        }
    }
}

#pragma mark - label delegate

-(void)didTapLabel:(NSString *)segueIdentifier {
    [self performSegueWithIdentifier:segueIdentifier sender:nil];
}

# pragma mark - Tableview Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 5){
        NSLog(@"hello!");
        [self performSegueWithIdentifier:@"reviewsSegue" sender:nil];
    }
    if (indexPath.section == 8){
        NSLog(@"%lu", (unsigned long)[_mediaGalleryByLocation count]);
        [self performSegueWithIdentifier:@"photoGalleryViewSegue" sender:nil];
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 9;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 7){
        return 250;
    }
    return UITableViewAutomaticDimension;
}

#pragma mark - Review Delegate

- (void) didTapMore:(User *) sender {
    NSLog(@"We made it!");

    if (sender != nil && sender == User.currentUser) {
        
        UIAlertController * view=   [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:nil
                                     preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction* edit = [UIAlertAction
                             actionWithTitle:@"Edit Review"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 //Do some thing here
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        UIAlertAction* cancel = [UIAlertAction
                                 actionWithTitle:@"Cancel"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [view dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
        
        [view addAction:edit];
        [view addAction:cancel];
        [self presentViewController:view animated:YES completion:nil];
    } else {
        UIAlertController * view=   [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:nil
                                     preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction* flag = [UIAlertAction
                               actionWithTitle:@"Flag Review"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   //Do some thing here
                                   [view dismissViewControllerAnimated:YES completion:nil];
                                   
                               }];
        UIAlertAction* cancel = [UIAlertAction
                                 actionWithTitle:@"Cancel"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [view dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
        
        [view addAction:flag];
        [view addAction:cancel];
        [self presentViewController:view animated:YES completion:nil];
    }
}

#pragma mark - Networking

- (void) fetchReviews {
    PFQuery *query = [PFQuery queryWithClassName:@"Review"];
    //if (self.user == nil) {
    [query whereKey:@"location" equalTo:self.location];
    //} else {
    // [query whereKey:@"user" equalTo:self.user];
    //}
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *reviews, NSError *error) {
        if (reviews != nil) {
            // do something with the array of object returned by the call
            /*for (Review *review in reviews){
             [self.reviews addObject:review];
             } */
            self.reviews = (NSMutableArray *) reviews;
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

# pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"reviewsSegue"]){
        NSLog(@"hello!");
        ReviewViewController *reviewsController = [segue destinationViewController];
        reviewsController.location = self.location;
    }
    
    if ([segue.identifier isEqualToString:@"photoGalleryViewSegue"]){
        TitleTableViewCell *tappedCell = sender;
        PhotoCollectionViewController *photoCollectionController = [segue destinationViewController];
        photoCollectionController.location = self.location;
    }
}

@end
