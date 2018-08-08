//
//  ProfileViewController.m
//  GO
//
//  Created by Amy Liu on 7/23/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "ProfileViewController.h"
#import "ReviewsTableViewCell.h"
#import "CarouselTableViewCell.h"
#import "TitleTableViewCell.h"
#import "ProfileTableViewCell.h"
#import "ParseUI/ParseUI.h"
#import "Parse/Parse.h"
#import "DetailsViewController.h"
#import "ReviewViewController.h"
#import "User.h"

@interface ProfileViewController () <ReviewsTableViewCellDelegate, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *reviews;

@end

@implementation ProfileViewController 

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupTableView];
    [self fetchReviews];
    [self registerNibs];
    [self.tableView reloadData];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

# pragma mark - Register nibs

-(void)registerNibs {
    
    UINib *reviewTableViewCell = [UINib nibWithNibName:@"ReviewTableViewCell" bundle:nil];
    [self.tableView registerNib:reviewTableViewCell forCellReuseIdentifier:@"ReviewTableViewCell"];
    
    UINib *carouselTableViewCell = [UINib nibWithNibName:@"CarouselTableViewCell" bundle:nil];
    [self.tableView registerNib:carouselTableViewCell forCellReuseIdentifier:@"CarouselTableViewCell"];
    
    UINib *titleTableViewCell = [UINib nibWithNibName:@"TitleTableViewCell" bundle:nil];
    [self.tableView registerNib:titleTableViewCell forCellReuseIdentifier:@"TitleTableViewCell"];
    
    UINib *profileTableViewCell = [UINib nibWithNibName:@"ProfileTableViewCell" bundle:nil];
    [self.tableView registerNib:profileTableViewCell forCellReuseIdentifier:@"ProfileTableViewCell"];
    
}

# pragma mark - Tableview

- (void) setupTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1){
        [self performSegueWithIdentifier:@"detailsSegue" sender:nil];
    } else if (indexPath.section == 3){
        [self performSegueWithIdentifier:@"reviewsSegue" sender:nil];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) { // Profile
        ProfileTableViewCell *profileTableViewCell = [self.tableView dequeueReusableCellWithIdentifier:@"ProfileTableViewCell"];
        [profileTableViewCell setProfile:User.currentUser];
        return profileTableViewCell;
    } else if (indexPath.section == 2) { // Carousel
        CarouselTableViewCell *carouselTableViewCell = [self.tableView dequeueReusableCellWithIdentifier:@"CarouselTableViewCell"];
        [carouselTableViewCell setImages:User.currentUser.favorites];
        [carouselTableViewCell setDatasourceAndDelegate];
        carouselTableViewCell.imageDelegate = self;
        return carouselTableViewCell;
    } else if (indexPath.section == 1) { // Title
        TitleTableViewCell *titleTableViewCell = [self.tableView dequeueReusableCellWithIdentifier:@"TitleTableViewCell"];
        [titleTableViewCell setupTitleCell:@"Favorites"];
        return titleTableViewCell;
    } else if (indexPath.section == 3) { // Title
        TitleTableViewCell *titleTableViewCell = [self.tableView dequeueReusableCellWithIdentifier:@"TitleTableViewCell"];
        [titleTableViewCell setupTitleCell:@"Reviews"];
        return titleTableViewCell;
    } else { // Review
        ReviewsTableViewCell *reviewTableViewCell = [self.tableView dequeueReusableCellWithIdentifier:@"ReviewTableViewCell"];
        [reviewTableViewCell setupReviewsTableViewCell:User.currentUser withReview:self.reviews[indexPath.row]];
        return reviewTableViewCell;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 4) {
        return self.reviews.count;
    } else {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

#pragma mark - Networking

- (void) fetchReviews {
    PFQuery *query = [PFQuery queryWithClassName:@"Review"];
    //if (self.user == nil) {
    [query whereKey:@"user" equalTo:User.currentUser];
    //} else {
    // [query whereKey:@"user" equalTo:self.user];
    //}
    // fetch data asynchronously
    self.reviews = [[NSMutableArray alloc] init];
    [query findObjectsInBackgroundWithBlock:^(NSArray *reviews, NSError *error) {
        if (reviews != nil) {
            // do something with the array of object returned by the call
            for (int i = reviews.count - 1; i >= 0; i--){
             [self.reviews addObject:reviews[i]];
            }
            //self.reviews = (NSMutableArray *) reviews;
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

#pragma mark - Actions

- (IBAction)didTapLogout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
    [self.navigationController popViewControllerAnimated:YES];
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


@end
