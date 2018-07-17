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

-(Location*)dummyDataSetUp {
    Location *newLocation = [Location new];
    newLocation.title = @"MOMA";
    newLocation.synopsis = @"Some really cool art!";
    newLocation.address = @"151 3rd St, San Francisco, CA 94103";
    newLocation.lat = 37.7857;
    newLocation.lon = -122.4011;
    newLocation.rating = 4.9;
    [self.locationsArray addObject:newLocation];
    return newLocation;
}

#pragma mark - tableview protocol

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.locationsArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    LocationsTableViewCell *locationCell = [self.locationsTimelineView dequeueReusableCellWithIdentifier:@"LocationsTableViewCell"];
    Location *locationInfo = [self dummyDataSetUp];
    [locationCell setLocationObject:locationInfo];
    
//    NSString * locationImageString = @"https://media.licdn.com/dms/image/C5103AQFSzkTQcTNk3A/profile-displayphoto-shrink_200_200/0?e=1537401600&v=beta&t=jRM2BEccIEAMatPgEkw0RtNf5qYE2Bqx412fqD7zESg";
//    NSURL *locationURL = [NSURL URLWithString:locationImageString];
//    locationCell.locationImage.image = nil;
//    [locationCell.locationImage setImageWithURL:locationURL];
    
    return locationCell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    LocationsTableViewCell *tappedCell = sender;
    DetailsViewController *detailsController = [segue destinationViewController];
    detailsController.location = tappedCell.location;
}

@end
