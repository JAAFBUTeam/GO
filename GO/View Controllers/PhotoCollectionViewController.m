//
//  PhotoCollectionViewController.m
//  GO
//
//  Created by Amy Liu on 7/20/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "PhotoCollectionViewController.h"
#import "APIManager.h"
#import "InstagramKit.h"
#import <WebKit/WebKit.h>
#import "DetailsViewController.h"
#import "InfoTableViewCell.h"
#import "TitleTableViewCell.h"
#import "ReviewsTableViewCell.h"
#import "PhotoCollectionView.h"
#import "CarouselTableViewCell.h"
#import "ReviewViewController.h"


@interface PhotoCollectionViewController () <UITableViewDelegate, UITableViewDataSource, WKNavigationDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *instagramButton;
@property (weak, nonatomic) InstagramEngine *engine;
@property (strong, nonatomic) NSMutableArray *mediaGallery;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PhotoCollectionViewController

# pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    _mediaGallery = [[NSMutableArray alloc] init];
    _engine = [InstagramEngine sharedEngine];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self registerNibs];
}

# pragma mark - Register nibs

-(void)registerNibs {
    UINib *photoCollectionView = [UINib nibWithNibName:@"PhotoCollectionView" bundle:nil];
    [_tableView registerNib:photoCollectionView forCellReuseIdentifier:@"PhotoCollectionView"];
}

- (IBAction)onTapConnectInstagramButton:(id)sender {
    [APIManager redirectToInstagram:_engine];
    
    [_engine getSelfRecentMediaWithSuccess:^(NSArray<InstagramMedia *> * _Nonnull media, InstagramPaginationInfo *paginationInfo) {
        NSLog(@"Accessing media!!!");
        //return media;
        [self.mediaGallery addObjectsFromArray:media];
        NSLog(@"%@", [self.mediaGallery objectAtIndex:0]);
    } failure:^(NSError * _Nonnull error, NSInteger serverStatusCode, NSDictionary * _Nonnull response) {
        NSLog(@"Error in getting media!!!");
        NSLog(@"%@", response);
    }];
}

# pragma mark - Tableview Datasource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PhotoCollectionView *collectionViewTableViewCell = [_tableView dequeueReusableCellWithIdentifier:@"PhotoCollectionView"];
    [collectionViewTableViewCell createCollectionViewCell:_location];
    return collectionViewTableViewCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

@end
