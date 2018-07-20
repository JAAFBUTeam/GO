//
//  ReviewViewController.m
//  GO
//
//  Created by Amy Liu on 7/20/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "ReviewViewController.h"
#import "ReviewsTableViewCell.h"

@interface ReviewViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *reviews;

@end

@implementation ReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.reviews.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ReviewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReviewTableViewCell"];
    
    cell.tweet = self.tweetArray[indexPath.row];
    
    return cell;
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
