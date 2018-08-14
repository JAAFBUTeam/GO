
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
#import "BannerTableViewCell.h"

@interface DetailsViewController () <ReviewsTableViewCellDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) InstagramEngine *engine;
@property (nonatomic, strong) NSMutableArray *reviews;
@property (strong, nonatomic) UIImagePickerController *imagePickerVC;

typedef enum {
    BANNER = 0,
    INFO = 1,
    TITLE_PHOTOS = 2,
    IMAGE_COLLECTION = 3,
    MORE_IMAGES = 4,
    TITLE_REVIEW = 5,
    REVIEW_1 = 6,
    REVIEW_2 = 7,
    MORE_REVIEWS = 8
} cell_state;

@end

@implementation DetailsViewController

# pragma mark - Lifecycle

-(void)viewWillAppear:(BOOL)animated {
    [self fetchReviews];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.navigationController.navigationBar.prefersLargeTitles = NO;
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back-24.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backTap)];
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    self.title = self.location.title;
    self.tableView.allowsSelection = NO;

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self initImagePicker];
    
    [self fetchReviews];
    [self registerNibs];
}

-(void)backTap {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initImagePicker {
    self.imagePickerVC = [UIImagePickerController new];
    self.imagePickerVC.delegate = self;
    self.imagePickerVC.allowsEditing = YES;
    self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
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
    
    UINib *bannerTableViewCell = [UINib nibWithNibName:@"BannerTableViewCell" bundle:nil];
    [self.tableView registerNib:bannerTableViewCell forCellReuseIdentifier:@"BannerTableViewCell"];
    
}

# pragma mark - Tableview Datasource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch(indexPath.section){
            //        case CAROUSEL: {
            //            CarouselTableViewCell *carouselTableViewCell = [self.tableView dequeueReusableCellWithIdentifier:@"CarouselTableViewCell"];
            //            [carouselTableViewCell setCarouselTypeProperties:iCarouselTypeLinear];
            //            [carouselTableViewCell setLocationProperty:_location];
            //            [carouselTableViewCell setDatasourceAndDelegate];
            //            return carouselTableViewCell;
            //        }
        case BANNER: {
            BannerTableViewCell *bannerTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"BannerTableViewCell"];
            UIImageView *imageView = [[UIImageView alloc] init];
            NSURL *url =  [[NSURL alloc] initWithString: self.location.imageURLs[0]];
            //[imageView setImageWithURL:url];
            NSData *imageData = [NSData dataWithContentsOfURL:url];
            imageView.image = [UIImage imageWithData:imageData];
            [bannerTableViewCell setBanner: imageView];
            return bannerTableViewCell;
        }
        case INFO: {
            InfoTableViewCell *infoTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"InfoTableViewCell"];
            [infoTableViewCell setTableProperties:_location];
            [infoTableViewCell highlightBookmark:[self currLocationInCurrUserFavorites:self.location]];
            infoTableViewCell.title.text = self.location.title;
            infoTableViewCell.labelDelegate = self;
            return infoTableViewCell;
        }
        case TITLE_REVIEW: {
            TitleTableViewCell *titleTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"TitleTableViewCell"];
            [titleTableViewCell setupTitleCell:@"Reviews"];
            return titleTableViewCell;
        }
        case REVIEW_1: {
            ReviewsTableViewCell *reviewTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"ReviewTableViewCell"];
            if (self.reviews.count != 0) {
                [reviewTableViewCell setupReviewsTableViewCell: self.reviews[self.reviews.count - 1]];
            } else {
                [reviewTableViewCell setupReviewsTableViewCell:nil];
            }
            reviewTableViewCell.delegate = self;
            return reviewTableViewCell;
        }
        case REVIEW_2: {
            ReviewsTableViewCell *reviewTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"ReviewTableViewCell"];
            if (self.reviews.count > 1) {
                [reviewTableViewCell setupReviewsTableViewCell: self.reviews[self.reviews.count - 2]];
            } else {
                [reviewTableViewCell setupReviewsTableViewCell:nil];
            }
            reviewTableViewCell.delegate = self;
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
            titleTableViewCell.addDelegate = self;
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
    if(User.currentUser == nil) {
        [self showNotLoggedInWarning];
    } else {
        [self performSegueWithIdentifier:segueIdentifier sender:nil];
    }
}

#pragma mark - info tap delegate

-(void)labelTapped:(NSUInteger)section {}

-(BOOL)bookmarkTapped:(NSUInteger)section {
    User *currentUser = User.currentUser;
    Location *currentLocation = self.location;
    
    if(currentUser == nil) {
        [self showNotLoggedInWarning];
        return NO;
    }
    
    BOOL shouldAddToFavorites = [self shouldAddToLocationToCurrentUserFavorites:currentLocation currentUser:currentUser];
    [self updateCurrUserFavorites:currentUser currentLocation:currentLocation shouldAddToFavorites:shouldAddToFavorites];
    
    [self.detailsBookmarkDelegate detailsBookmarkTapped];
    
    return shouldAddToFavorites;
}

-(BOOL)shouldAddToLocationToCurrentUserFavorites:(Location *)currentLocation currentUser:(User *)currentUser {
    for (Location *favoritedLocation in currentUser.favorites) {
        if ([currentLocation.objectId isEqualToString:favoritedLocation.objectId]) {
            return NO;
        }
    }
    return YES;
}

-(void)updateCurrUserFavorites:(User *)currentUser currentLocation:(Location *)currentLocation shouldAddToFavorites:(BOOL)shouldAddToFavorites {
    if(shouldAddToFavorites) {
        [currentUser.favorites addObject:currentLocation];
        [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {}];
    } else {
        [currentUser.favorites removeObject:currentLocation];
    }
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
    if (indexPath.section == 3){
        return 250;
    } else if (indexPath.section == 0) {
        return 225;
    }
    return UITableViewAutomaticDimension;
}

-(BOOL)currLocationInCurrUserFavorites:(Location *)location {
    User *currentUser = User.currentUser;
    BOOL shouldHighlightBookMark = NO;
    for (Location *favoritedLocation in currentUser.favorites) {
        if ([location.objectId isEqualToString:favoritedLocation.objectId]) {
            shouldHighlightBookMark = YES;
            break;
        }
    }
    return shouldHighlightBookMark;
}

#pragma mark - title table view protocol

-(void)didTapAdd {
    if(User.currentUser == nil) {
        [self showNotLoggedInWarning];
        return;
    } else {
        [self presentViewController:self.imagePickerVC animated:YES completion:nil];
    }
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

#pragma mark - alerts

-(void)showNotLoggedInWarning {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Attention" message:@"Must be logged in to perform action" preferredStyle:(UIAlertControllerStyleAlert)];
    [self createOkAction:alert];
    [self presentViewController:alert animated:YES completion:^{}];
}

-(void) createOkAction:(UIAlertController *)alert {
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"ok button clicked");
    }];
    
    [alert addAction:okAction];
}

# pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"reviewsSegue"]){
        NSLog(@"hello!");
        ReviewViewController *reviewsController = [segue destinationViewController];
        reviewsController.location = self.location;
    }
    
    if ([segue.identifier isEqualToString:@"photoGalleryViewSegue"]){
        PhotoCollectionViewController *photoCollectionController = [segue destinationViewController];
        photoCollectionController.location = self.location;
    }
}

@end
