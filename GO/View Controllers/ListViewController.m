//
//  ListViewController.m
//  GO
//
//  Created by Amy Liu on 7/13/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "ListViewController.h"
#import "Location.h"
#import "InfoTableViewCell.h"

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
    [self createSearchBar];

}

-(void) createSearchBar {
    CGPoint offset = CGPointMake(0, 44);
    [self.locationsTimelineView setContentOffset:offset];
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
    if (section == 0) { // Carousel
        return 1;
    } else if (section == 1) { // Title + Info
        return 2;
    } else {
        return 0;
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    /* if (indexPath.section == 1) { // Carousel
        LocationsTableViewCell *carouselTableViewCell = [self.locationsTimelineView dequeueReusableCellWithIdentifier:@"LocationsTableViewCell"];
        return carouselTableViewCell;
    } else if (indexPath.section == 0) { // Title + Info
        InfoTableViewCell *infoTableViewCell = [self.locationsTimelineView dequeueReusableCellWithIdentifier:@"InfoTableViewCell"];
        infoTableViewCell.title.text = @"I am a location";
        return infoTableViewCell;
    } else {
        return nil;
    } */
    
    
    LocationsTableViewCell *locationCell = [self.locationsTimelineView dequeueReusableCellWithIdentifier:@"LocationsTableViewCell"];
    [locationCell setLocationObject:self.locationsArray[indexPath.row]];

    return locationCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    LocationsTableViewCell *tappedCell = sender;
    DetailsViewController *detailsController = [segue destinationViewController];
    detailsController.location = tappedCell.location;
}

@end
