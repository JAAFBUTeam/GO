//
//  ListViewController.m
//  GO
//
//  Created by Amy Liu on 7/13/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController ()

@property (strong, nonatomic) NSMutableArray *locationsArray;
@property (weak, nonatomic) IBOutlet UITableView *locationsTimelineView;

@end

@implementation ListViewController

#pragma mark - lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dummyDataSetUp];
}

-(void)dummyDataSetUp {
    //TODO: populate array with location objects that have dummy data
    Location *object1;
}

#pragma mark - tableview protocol

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.locationsArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    LocationsTableViewCell *locationsCell = [self.locationsTimelineView dequeueReusableCellWithIdentifier:@"LocationsTableViewCell"];
    return locationsCell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    LocationsTableViewCell *tappedCell = sender;
    DetailsViewController *detailsController = [segue destinationViewController];
    //detailsController.location = tappedCell.location;
}

@end
