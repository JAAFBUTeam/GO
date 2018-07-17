//
//  ListViewController.m
//  GO
//
//  Created by Amy Liu on 7/13/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "ListViewController.h"
#import "Location.h"

@interface ListViewController ()

@property (strong, nonatomic) NSMutableArray *locationsArray;
@property (weak, nonatomic) IBOutlet UITableView *locationsTimelineView;

@end

@implementation ListViewController

#pragma mark - lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createLocationsArray];
    [self dummyDataSetUp];
    [self setDataSourceAndDelegate];
}

- (void) setDataSourceAndDelegate {
    self.locationsTimelineView.delegate = self;
    self.locationsTimelineView.dataSource = self;
}

-(void)createLocationsArray {
    self.locationsArray = [[NSMutableArray alloc]init];
}

-(void)dummyDataSetUp {
    [self.locationsArray addObject:[Location createLocation]];
    [self.locationsArray addObject:[Location createLocation]];
}

#pragma mark - tableview protocol

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.locationsArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    LocationsTableViewCell *locationCell = [self.locationsTimelineView dequeueReusableCellWithIdentifier:@"LocationsTableViewCell"];
    [locationCell setLocationObject:self.locationsArray[indexPath.row]];

    return locationCell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    LocationsTableViewCell *tappedCell = sender;
    DetailsViewController *detailsController = [segue destinationViewController];
    
    //detailsController.location = tappedCell.location;
   // NSLog(@"%@", detailsController.location.synopsis);
}

@end
