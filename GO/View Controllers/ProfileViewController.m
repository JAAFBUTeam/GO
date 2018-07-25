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

@interface ProfileViewController () <ProfileTableViewCellDelegate, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ProfileViewController 

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupTableView];
    [self registerNibs];
    
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
        /*UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapProfile)];
        [profileTableViewCell.image addGestureRecognizer:tap]; */
//        tap.delegate = self;
    
        return profileTableViewCell;
    } else if (indexPath.section == 1) { // Carousel
        CarouselTableViewCell *carouselTableViewCell = [self.tableView dequeueReusableCellWithIdentifier:@"CarouselTableViewCell"];
        [carouselTableViewCell setupCarouselCell];
        return carouselTableViewCell;
    } else if (indexPath.section == 2) { // Title
        TitleTableViewCell *titleTableViewCell = [self.tableView dequeueReusableCellWithIdentifier:@"TitleTableViewCell"];
        [titleTableViewCell setupTitleCell:@"Reviews"];
        return titleTableViewCell;
    } else { // Review
        ReviewsTableViewCell *reviewTableViewCell = [self.tableView dequeueReusableCellWithIdentifier:@"ReviewTableViewCell"];
        [reviewTableViewCell setupReviewsTableViewCell:[UIImage imageNamed:@"cat.jpg"] setupUsername:@"Cat" setupRating:@"1 star" setupReviewText:@"review text for Cat"];
        return reviewTableViewCell;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

#pragma mark - Conversion

- (PFFile *)getPFFileFromImage: (UIImage * _Nullable)image {
    
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFile fileWithName:@"image.png" data:imageData];
}

#pragma mark - Actions

- (void) didTapProfile { // connect to imageview
    
    NSLog(@"thanks for tapping me!");
    
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
    
    [self reloadInputViews];
}

- (IBAction)didTapLogout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Images

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:^{
        
        User.currentUser.image = [self getPFFileFromImage:originalImage];
        [PFUser.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            
        }];
    }];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"detailsSegue"]) {
        
        Location *location = sender;
        
        DetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.location = location;
    } else if ([segue.identifier isEqualToString:@"reviewsSegue"]) {
        
        Location *location = sender;
        
        ReviewViewController *reviewsViewController = [segue destinationViewController];
        reviewsViewController.location = location;
        reviewsViewController.user = User.currentUser;
    }
}


@end
