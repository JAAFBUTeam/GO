//
//  ListViewController.m
//  GO
//
//  Created by Amy Liu on 7/13/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController ()

@property (strong, nonatomic) NSMutableArray *categoriesLocationsArray;
@property (strong, nonatomic) NSArray *filteredLocationsArray;
@property (strong, nonatomic) NSArray *searchfilteredLocationArray;
@property (strong, nonatomic) UISearchController *searchController;
@property (assign, nonatomic) NSInteger selectedRow;
@property (weak, nonatomic) IBOutlet UITableView *listTableView;

@end

@implementation ListViewController

#pragma mark - lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fadeIn];
    [self setNavigationBarSettings];
    [self initLocationsArrays];
    [self setDataSourceAndDelegate];
    [self setTableProperties];
    [self registerNibs];
    [self fetchCategoryLocations:[GlobalFilters sharedInstance].categoryType];
    [self disableAutoRotate];
}

-(void) fadeIn {
    self.listTableView.alpha = 0.0;
    [UIView animateWithDuration:.5 animations:^{self.listTableView.alpha = 1.0;} completion:(void (^)(BOOL)) ^{}];
}

-(void)calculateLocation{
    CurrentLocationPosition *distanceFromLocation = [[CurrentLocationPosition alloc] init];
    for (Location *location in _filteredLocationsArray){
        location.distanceAway = [distanceFromLocation setDistance:location];
    }
}

-(void) setNavigationBarSettings {
    self.navigationController.navigationBar.prefersLargeTitles = NO;
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
    self.listTableView.allowsSelection = NO;
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

-(void)copyDataToFilteredArray {
    self.filteredLocationsArray = self.categoriesLocationsArray;
}

-(BOOL)isCurrUserFavoritesArrayEmpty {
    return (User.currentUser.favorites == nil);
}

#pragma mark - Networking

- (void)fetchCategoryLocations:(CategoryType)categoryType {
    [MBProgressHUD showHUDAddedTo:self.listTableView animated:YES];
    PFQuery *query = [PFQuery queryWithClassName:@"Location"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *LocationsArray, NSError *error) {
        if (LocationsArray != nil) {
            [self addSelectedCategoryLocationsToArray:LocationsArray];
            [self copyDataToFilteredArray];
            [self calculateLocation];
            [MBProgressHUD hideHUDForView:self.listTableView animated:YES];
            [self.listTableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        
        [UIView animateWithDuration:.5 animations:^{[MBProgressHUD hideHUDForView:self.listTableView animated:YES];} completion:(void (^)(BOOL)) ^{}];}];
}

-(void)addSelectedCategoryLocationsToArray:(NSArray *)LocationsArray {
    for(Location *location in LocationsArray) {
        for(NSNumber *tagNumber in location.tags) {
            if(tagNumber == [NSNumber numberWithInteger:[GlobalFilters sharedInstance].categoryType]) {
                [self.categoriesLocationsArray addObject:location];
                break;
            }
        }
    }
}

#pragma mark - search bar protocol

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = self.searchController.searchBar.text;
    if (searchText) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title contains[cd] %@",searchText];
        if([GlobalFilters sharedInstance].appliedFilters) {
            if (searchText.length != 0) {
                self.filteredLocationsArray = [self.searchfilteredLocationArray filteredArrayUsingPredicate:predicate];
            } else {
                self.filteredLocationsArray = self.searchfilteredLocationArray;
            }
        } else {
            if (searchText.length != 0) {
                self.filteredLocationsArray = [self.categoriesLocationsArray filteredArrayUsingPredicate:predicate];
            } else {
                self.filteredLocationsArray = self.categoriesLocationsArray;
            }
        }
        [self.listTableView reloadData];
    }
}

#pragma mark - filters protocol

-(void)applyButtonTap {
    [self fetchFilteredLocations];
}

-(void)fetchFilteredLocations {
    [self filterOutByMinRating];
    
    if([GlobalFilters sharedInstance].nearestLocationSwitch) {
        [self sortByNearestLocation];
    }
    
    self.searchfilteredLocationArray = self.filteredLocationsArray;
    [self.listTableView reloadData];
}

-(void)filterOutByMinRating {
    NSNumber *minValue = [NSNumber numberWithInteger:[GlobalFilters sharedInstance].minRatingSlider];
    NSPredicate *ratingPredicate = [NSPredicate predicateWithFormat:@"rating >= %@", minValue];
    self.filteredLocationsArray = [self.categoriesLocationsArray filteredArrayUsingPredicate:ratingPredicate];
}

-(void)sortByNearestLocation {
    NSSortDescriptor *firstDescriptor = [[NSSortDescriptor alloc] initWithKey:@"distanceAway" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:firstDescriptor, nil];
    self.filteredLocationsArray = [self.filteredLocationsArray sortedArrayUsingDescriptors:sortDescriptors];
}

#pragma mark - carousel image tap protocol

-(void)imageTapped:(NSUInteger)section {
    self.searchController.active = NO;
    [self performSegueWithIdentifier:@"listToDetailsSegue" sender:self.categoriesLocationsArray[section]];
}

-(void)imageDoubleTapped:(NSUInteger)section {
    User *currentUser = User.currentUser;
    Location *currentLocation = self.filteredLocationsArray[section];
    
    BOOL hasAlreadyFavorited = NO;
    for (Location *favoritedLocation in currentUser.favorites) {
        if ([currentLocation.objectId isEqualToString:favoritedLocation.objectId]) {
            hasAlreadyFavorited = YES;
            break;
        }
    }
    
    if (!hasAlreadyFavorited) {
        [currentUser.favorites addObject:currentLocation];
        [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {}];
    }
}

#pragma mark - info table view tap protocol

-(void)labelTapped:(NSUInteger)section {
    self.selectedRow = section;
    self.searchController.active = NO;
    [self performSegueWithIdentifier:@"listToDetailsSegue" sender:nil];
}

-(BOOL)bookmarkTapped:(NSUInteger)section {
    User *currentUser = User.currentUser;
    Location *currentLocation = self.filteredLocationsArray[section];
    
    if(currentUser == nil) {
        [self showNotLoggedInWarning];
        return NO;
    }
    
    BOOL shouldAddToFavorites = [self shouldAddToLocationToCurrentUserFavorites:currentLocation currentUser:currentUser];
    [self updateCurrUserFavorites:currentUser currentLocation:currentLocation shouldAddToFavorites:shouldAddToFavorites];
    
    return shouldAddToFavorites;
}

-(BOOL)isCurrLocationInCurrUserFavorites:(Location *)location currentUser:(User *)currentUser {
    for (Location *favoritedLocation in currentUser.favorites) {
        if ([location.objectId isEqualToString:favoritedLocation.objectId]) {
            return YES;
        }
    }
    return NO;
}

-(BOOL)shouldAddToLocationToCurrentUserFavorites:(Location *)currentLocation currentUser:(User *)currentUser {
    for (Location *favoritedLocation in currentUser.favorites) {
        if ([currentLocation.objectId isEqualToString:favoritedLocation.objectId]) {
            return NO;
        }
    }
    return YES;
}

-(void)updateCurrUserFavorites:(User *)currentUser currentLocation:(Location *)currentLocation shouldAddToFavorites:(BOOL)shouldAddToFavorites {
    if(shouldAddToFavorites) {
        [currentUser.favorites addObject:currentLocation];
        [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {}];
    } else {
        [currentUser.favorites removeObject:currentLocation];
    }
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
        Location *location = self.filteredLocationsArray[indexPath.section];
        InfoTableViewCell *infoTableViewCell = [self.listTableView dequeueReusableCellWithIdentifier:@"InfoTableViewCell"];
        [infoTableViewCell setTableProperties:location];
        [infoTableViewCell setSectionIDProperty:indexPath.section];
        [infoTableViewCell hideAddressLabel];
        [infoTableViewCell highlightBookmark:[self isCurrLocationInCurrUserFavorites:location currentUser:User.currentUser]];
        infoTableViewCell.labelDelegate = self;
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

#pragma mark - Actions

- (IBAction)didTapBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)showNotLoggedInWarning {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Attention" message:@"Must be logged in to perform action" preferredStyle:(UIAlertControllerStyleAlert)];
    [self createOkAction:alert];
    [self presentViewController:alert animated:YES completion:^{}];
}

-(void) createOkAction:(UIAlertController *)alert {
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"ok button clicked");
    }];
    
    [alert addAction:okAction];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([sender isKindOfClass:[Location class]]) { //image tapped
        DetailsViewController *detailsController = [segue destinationViewController];
        detailsController.location = sender;
    } else if ([segue.identifier isEqualToString:@"listToDetailsSegue"]) { //info section tapped
        DetailsViewController *detailsController = [segue destinationViewController];
        detailsController.location = self.filteredLocationsArray[self.selectedRow];
        NSLog(@"label tap segue");
    } else if ([segue.identifier isEqualToString:@"listToFiltersSegue"]) {
        UINavigationController *navController = [segue destinationViewController];
        FiltersViewController *filtersViewController = (FiltersViewController*)[navController topViewController];
        filtersViewController.applyButtonDelegate = self;
    }
}

@end
