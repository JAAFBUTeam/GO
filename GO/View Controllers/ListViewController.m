//
//  ListViewController.m
//  GO
//
//  Created by Amy Liu on 7/13/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "ListViewController.h"
#import "ReviewsTableViewCell.h"
#import "CurrentLocationPosition.h"

@interface ListViewController ()

@property (strong, nonatomic) NSMutableArray *locationsArray;
@property (strong, nonatomic) NSArray *categoriesLocationArray;
@property (strong, nonatomic) NSArray *filteredLocationArray;
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (strong, nonatomic) UISearchController *searchController;
@property (nonatomic, assign) NSInteger selectedRow;

@end

@implementation ListViewController

#pragma mark - lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarSettings];
    [self initLocationsArrays];
    [self setDataSourceAndDelegate];
    [self setTableProperties];
    [self registerNibs];
    [self disableAutoRotate];
    if([GlobalFilters sharedInstance].appliedFilters) {
        //do filters search
    } else {
        [self fetchCategoryLocations:[GlobalFilters sharedInstance].categoryType];
    }
}

-(void)authorizeLocation{
    CurrentLocationPosition *distanceFromLocation = [[CurrentLocationPosition alloc] init];
    [distanceFromLocation setUserCurrentLocation];
}

-(void) setNavigationBarSettings {
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.navigationItem.searchController = self.searchController;
    self.searchController.dimsBackgroundDuringPresentation = NO;
}

-(void)initLocationsArrays {
    self.locationsArray = [[NSMutableArray alloc]init];
    self.categoriesLocationArray = [[NSArray alloc]init];
    self.filteredLocationArray = [[NSArray alloc]init];
}

- (void) setDataSourceAndDelegate {
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
}

-(void) setTableProperties {
    self.listTableView.rowHeight = UITableViewAutomaticDimension;
    self.listTableView.estimatedRowHeight = 300;
    self.listTableView.contentInset = UIEdgeInsetsMake(5, 0, 0, 0);
    self.listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.listTableView.backgroundColor = [UIColor whiteColor];
}

-(void) registerNibs {
    UINib *infoTableViewCell = [UINib nibWithNibName:@"InfoTableViewCell" bundle:nil];
    [self.listTableView registerNib:infoTableViewCell forCellReuseIdentifier:@"InfoTableViewCell"];
    
    UINib *carouselTableViewCell = [UINib nibWithNibName:@"CarouselTableViewCell" bundle:nil];
    [self.listTableView registerNib:carouselTableViewCell forCellReuseIdentifier:@"CarouselTableViewCell"];
}

-(void) disableAutoRotate {
    AppDelegate* shared = [UIApplication sharedApplication].delegate;
    shared.blockRotation=YES;
}

-(void)copyDataToCategoriesArray {
    self.categoriesLocationArray = self.locationsArray;
}

#pragma mark - Networking

- (void)fetchCategoryLocations:(CategoryType)categoryType {
    PFQuery *query = [PFQuery queryWithClassName:@"Location"];
    // [query whereKey:@"rating" greaterThan:@2.0];
    [query findObjectsInBackgroundWithBlock:^(NSArray *LocationsArray, NSError *error) {
        if (LocationsArray != nil) {
            for (Location *location in LocationsArray){
                [self.locationsArray addObject:location];
            }
            [self copyDataToCategoriesArray];
            [self.listTableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

-(void)fetchFilteredLocations {
    
}

#pragma mark - search bar protocol

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = self.searchController.searchBar.text;
    if (searchText) {
        if (searchText.length != 0) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title contains[cd] %@",searchText];
            self.categoriesLocationArray = [self.locationsArray filteredArrayUsingPredicate:predicate];
        } else {
            self.categoriesLocationArray = self.locationsArray;
        }
        [self.listTableView reloadData];
    }
}

#pragma mark - carousel image tap protocol

-(void)ImageTapped:(NSUInteger)section {
    [self performSegueWithIdentifier:@"listToDetailsSegue" sender:self.locationsArray[section]];
}

#pragma mark - tableview protocol

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2; //info and carousel
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.categoriesLocationArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        InfoTableViewCell *infoTableViewCell = [self.listTableView dequeueReusableCellWithIdentifier:@"InfoTableViewCell"];
        [infoTableViewCell setTableProperties:self.categoriesLocationArray[indexPath.section]];
        return infoTableViewCell;
    } else { //indexPath.row == 1
        CarouselTableViewCell *carouselTableViewCell = [self.listTableView dequeueReusableCellWithIdentifier:@"CarouselTableViewCell"];
        [carouselTableViewCell setLocationProperty:self.categoriesLocationArray[indexPath.section]];
        [carouselTableViewCell setSectionIDProperty:indexPath.section];
        [carouselTableViewCell setDatasourceAndDelegate];
        carouselTableViewCell.imageDelegate = self;
        return carouselTableViewCell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedRow = indexPath.section;
    [self performSegueWithIdentifier:@"listToDetailsSegue" sender:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}
    
#pragma mark - Navigation
    
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([sender isKindOfClass:[Location class]]) { //image tapped
        NSLog(@"location type recognized");
        DetailsViewController *detailsController = [segue destinationViewController];
        detailsController.location = sender;
    } else if ([segue.identifier isEqualToString:@"listToDetailsSegue"]) { //info section tapped
        NSLog(@"location type passed");
        DetailsViewController *detailsController = [segue destinationViewController];
        detailsController.location = self.locationsArray[self.selectedRow];
    }
}
    
@end
