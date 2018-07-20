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
@property (weak, nonatomic) IBOutlet UITableView *listTableView;

@end

@implementation ListViewController

#pragma mark - lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createLocationsArray];
    [self addDummyDataToArray];
    [self setDataSourceAndDelegate];
    [self setTableProperties];
    [self setNavigationBarSettings];
    [self registerNibs];
    //AppDelegate* shared=[UIApplication sharedApplication].delegate;
    //shared.blockRotation=YES;
}

-(void)createLocationsArray {
    self.locationsArray = [[NSMutableArray alloc]init];
}

-(void)addDummyDataToArray {
    [self.locationsArray addObject:[Location createLocation]];
    [self.locationsArray addObject:[Location createLocation]];
}

- (void) setDataSourceAndDelegate {
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
}

-(void) setTableProperties {
    self.listTableView.rowHeight = UITableViewAutomaticDimension;
    self.listTableView.estimatedRowHeight = 300;
    self.listTableView.contentInset = UIEdgeInsetsMake(-0, 0, 0, 0);
    self.listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //self.listTableView.separatorColor = [UIColor clearColor];
}

-(void) setNavigationBarSettings {
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    searchController.searchResultsUpdater = self;
    self.navigationItem.searchController = searchController;
}

-(void) registerNibs {
    UINib *infoTableViewCell = [UINib nibWithNibName:@"InfoTableViewCell" bundle:nil];
    [self.listTableView registerNib:infoTableViewCell forCellReuseIdentifier:@"InfoTableViewCell"];
    
    UINib *carouselTableViewCell = [UINib nibWithNibName:@"CarouselTableViewCell" bundle:nil];
    [self.listTableView registerNib:carouselTableViewCell forCellReuseIdentifier:@"CarouselTableViewCell"];
}

#pragma mark - search bar protocol

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSLog(@"search");
}

#pragma mark - tableview protocol

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2; //info and carousel
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.locationsArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        InfoTableViewCell *infoTableViewCell = [self.listTableView dequeueReusableCellWithIdentifier:@"InfoTableViewCell"];
        [infoTableViewCell setTableProperties:self.locationsArray[indexPath.row]];
        return infoTableViewCell;
    } else { //indexPath.row == 1
        CarouselTableViewCell *carouselTableViewCell = [self.listTableView dequeueReusableCellWithIdentifier:@"CarouselTableViewCell"];
        [carouselTableViewCell setLocationObject:self.locationsArray[indexPath.row]];

        UIGestureRecognizer *pinchGesture = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
        [carouselTableViewCell addGestureRecognizer:pinchGesture];
        
        return carouselTableViewCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (void)handlePinch:(UIGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateRecognized) {
        NSLog(@"Pinch Handled Here");
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CarouselTableViewCell *tappedCell = sender;
    DetailsViewController *detailsController = [segue destinationViewController];
    detailsController.location = tappedCell.location;
}

@end
