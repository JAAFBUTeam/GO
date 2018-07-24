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

@interface ProfileViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ProfileViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - Register nibs

-(void)registerNibs {
    
    UINib *reviewTableViewCell = [UINib nibWithNibName:@"ReviewTableViewCell" bundle:nil];
    [self.tableView registerNib:reviewTableViewCell forCellReuseIdentifier:@"ReviewTableViewCell"];
    
    UINib *carouselTableViewCell = [UINib nibWithNibName:@"CarouselTableViewCell" bundle:nil];
    [self.tableView registerNib:carouselTableViewCell forCellReuseIdentifier:@"CarouselTableViewCell"];
    
    UINib *titleTableViewCell = [UINib nibWithNibName:@"TitleTableViewCell" bundle:nil];
    [self.tableView registerNib:titleTableViewCell forCellReuseIdentifier:@"TitleTableViewCell"];
    
}

# pragma mark - Tableview Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2){
        [self performSegueWithIdentifier:@"reviewsSegue" sender:nil];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) { // Carousel
        CarouselTableViewCell *carouselTableViewCell = [self.tableView dequeueReusableCellWithIdentifier:@"CarouselTableViewCell"];
        [carouselTableViewCell setupCarouselCell];
        return carouselTableViewCell;
    } else if (indexPath.section == 2) { // Title + Info
        TitleTableViewCell *titleTableViewCell = [self.tableView dequeueReusableCellWithIdentifier:@"TitleTableViewCell"];
        [titleTableViewCell setupTitleCell:@"Reviews"];
        return titleTableViewCell;
    } else if (indexPath.section == 3) { // Title + Info
        ReviewsTableViewCell *reviewTableViewCell = [self.tableView dequeueReusableCellWithIdentifier:@"ReviewTableViewCell"];
        [reviewTableViewCell setupReviewsTableViewCell:[UIImage imageNamed:@"cat.jpg"] setupUsername:@"Cat" setupRating:@"1 star" setupReviewText:@"review text for Cat"];
        return reviewTableViewCell;
    } else {
        return nil;
    }
}
    
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
