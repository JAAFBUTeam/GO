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

@property (strong, nonatomic) NSMutableArray *categoriesLocationsArray;
@property (strong, nonatomic) NSArray *filteredLocationsArray;
@property (strong, nonatomic) NSArray *searchfilteredLocationArray;
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
    [self fetchCategoryLocations:[GlobalFilters sharedInstance].categoryType];
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
    self.categoriesLocationsArray = [[NSMutableArray alloc]init];
    self.filteredLocationsArray = [[NSArray alloc]init];
    self.searchfilteredLocationArray = [[NSArray alloc]init];
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
    self.filteredLocationsArray = self.categoriesLocationsArray;
}

#pragma mark - Networking

- (void)fetchCategoryLocations:(CategoryType)categoryType {
    PFQuery *query = [PFQuery queryWithClassName:@"Location"];
    // [query whereKey:@"rating" greaterThan:@2.0];
    [query findObjectsInBackgroundWithBlock:^(NSArray *LocationsArray, NSError *error) {
        if (LocationsArray != nil) {
            for(Location *location in LocationsArray) {
                for(NSNumber *tagNumber in location.tags) {
                    if(tagNumber == [NSNumber numberWithInteger:[GlobalFilters sharedInstance].categoryType]) {
                        [self.categoriesLocationsArray addObject:location];
                        break;
                    }
                }
            }
            [self copyDataToCategoriesArray];
            [self.listTableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

-(void)fetchFilteredLocations {
    //hidden gem filter -- need ratings array before filter is applied - above 3 rating and under 80% of total reviews for max
    
    //min rating
    NSNumber *minValue = [NSNumber numberWithInteger:[GlobalFilters sharedInstance].minRatingSlider];
    NSPredicate *ratingPredicate = [NSPredicate predicateWithFormat:@"rating >= %@", minValue];
    self.filteredLocationsArray = [self.categoriesLocationsArray filteredArrayUsingPredicate:ratingPredicate];
    
    //nearestloc - sort - need distance property before sorting
    ////self.filteredLocationsArray = [self.filteredLocationsArray sortedArrayUsingSelector: @selector(compare:)];
//    NSSortDescriptor *firstDescriptor = [[NSSortDescriptor alloc] initWithKey:@"distance" ascending:YES];
//    NSArray *sortDescriptors = [NSArray arrayWithObjects:firstDescriptor, nil];
//    self.filteredLocationsArray = [self.filteredLocationsArray sortedArrayUsingDescriptors:sortDescriptors];

    [self.listTableView reloadData];
}

#pragma mark - search bar protocol

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = self.searchController.searchBar.text;
    if (searchText) {
        if([GlobalFilters sharedInstance].appliedFilters) {
            self.searchfilteredLocationArray = self.filteredLocationsArray;
            if (searchText.length != 0) {
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title contains[cd] %@",searchText];
                self.filteredLocationsArray = [self.searchfilteredLocationArray filteredArrayUsingPredicate:predicate];
            } else {
                self.filteredLocationsArray = self.searchfilteredLocationArray;
            }
        } else {
            if (searchText.length != 0) {
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title contains[cd] %@",searchText];
                self.filteredLocationsArray = [self.categoriesLocationsArray filteredArrayUsingPredicate:predicate];
            } else {
                self.filteredLocationsArray = self.categoriesLocationsArray;
            }
        }
        [self.listTableView reloadData];
    }
}

#pragma mark - filters delegate

-(void)applyButtonTap {
    [self fetchFilteredLocations];
}

#pragma mark - carousel image tap protocol

-(void)ImageTapped:(NSUInteger)section {
    [self performSegueWithIdentifier:@"listToDetailsSegue" sender:self.categoriesLocationsArray[section]];
}

#pragma mark - tableview protocol

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2; //info and carousel
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.filteredLocationsArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        InfoTableViewCell *infoTableViewCell = [self.listTableView dequeueReusableCellWithIdentifier:@"InfoTableViewCell"];
        [infoTableViewCell setTableProperties:self.filteredLocationsArray[indexPath.section]];
        return infoTableViewCell;
    } else { //indexPath.row == 1
        CarouselTableViewCell *carouselTableViewCell = [self.listTableView dequeueReusableCellWithIdentifier:@"CarouselTableViewCell"];
        [carouselTableViewCell setLocationProperty:self.filteredLocationsArray[indexPath.section]];
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
        DetailsViewController *detailsController = [segue destinationViewController];
        detailsController.location = sender;
    } else if ([segue.identifier isEqualToString:@"listToDetailsSegue"]) { //info section tapped
        DetailsViewController *detailsController = [segue destinationViewController];
        detailsController.location = self.categoriesLocationsArray[self.selectedRow];
    } else if ([segue.identifier isEqualToString:@"listToFiltersSegue"]) {
        UINavigationController *navController = [segue destinationViewController];
        FiltersViewController *filtersViewController = (FiltersViewController*)[navController topViewController];
        filtersViewController.applyButtonDelegate = self;
    }
}
    
@end
