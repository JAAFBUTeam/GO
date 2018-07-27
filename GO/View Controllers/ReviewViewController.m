//
//  ReviewViewController.m
//  GO
//
//  Created by Amy Liu on 7/20/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "ReviewViewController.h"
#import "ReviewsTableViewCell.h"
#import "Review.h"
#import "Location.h"

@interface ReviewViewController () <ReviewsTableViewCellDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *reviews;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self fetchReviews];
    
}

#pragma mark - Networking

- (void) fetchReviews {
    PFQuery *query = [PFQuery queryWithClassName:@"Review"];
    if (self.user == nil) {
        [query whereKey:@"location" equalTo:self.location.title];
    } else {
        [query whereKey:@"user" equalTo:self.user];
    }
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *reviews, NSError *error) {
        if (reviews != nil) { 
            // do something with the array of object returned by the call
            for (Review *review in reviews){
                [self.reviews addObject:review];
            }
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

#pragma mark - table view

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.reviews.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ReviewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReviewTableViewCell"];
    cell.review = self.reviews[indexPath.row];
    
    return cell;
}

#pragma mark - Review Delegate

- (void) didTapMore:(Review *) sender {
    
    if (sender.user == User.currentUser) {
        
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
