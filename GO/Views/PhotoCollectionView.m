//
//  PhotoCollectionView.m
//  GO
//
//  Created by Ajaita Saini on 7/19/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "PhotoCollectionView.h"
#import "PhotoCollectionViewCell.h"
#import "InstagramKit.h"
#import "APIManager.h"
#import "Location.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"

InstagramEngine *engine;
NSMutableArray<InstagramMedia *> *mediaGallery;
Location *currentLocation;
CLLocationCoordinate2D coordinates;
int indexVal;

@implementation PhotoCollectionView

# pragma mark - Lifecycle

- (void)awakeFromNib {
    [super awakeFromNib];
    
    engine = [InstagramEngine sharedEngine];
    mediaGallery = [[NSMutableArray alloc] init];
    indexVal = 0;
}


# pragma mark - Collection View setup

-(void)createCollectionViewCell:(Location *)location {
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    layout.minimumInteritemSpacing = 1;
    layout.minimumLineSpacing = 1;
    CGFloat imagesInEachLine = 3;
    CGFloat imageWidth = (self.collectionView.frame.size.width - layout.minimumInteritemSpacing * (imagesInEachLine -1)) / imagesInEachLine;
    CGFloat imageHeight = imageWidth;
    layout.itemSize = CGSizeMake(imageWidth, imageHeight);
    currentLocation = location;

    [self setupInstagramImages];
}

-(void)setupInstagramImages{
    [APIManager redirectToInstagram:engine];
    CLLocationCoordinate2D coordinates;
    coordinates.latitude = currentLocation.lat;
    coordinates.longitude = currentLocation.lon;
    
    [engine getSelfRecentMediaWithSuccess:^(NSArray<InstagramMedia *> * _Nonnull media, InstagramPaginationInfo *paginationInfo) {
        NSLog(@"Accessing media!!!!");
        for (int i = 0; i < [media count]; i++){
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
            [formatter setMaximumFractionDigits:2];
            
            NSString *instagram_latitude = [formatter stringFromNumber:@([media objectAtIndex:i].location.latitude)];
            NSString *current_latitude = [formatter stringFromNumber:@(coordinates.latitude)];
            NSString *instagram_longitude = [formatter stringFromNumber:@([media objectAtIndex:i].location.longitude)];
            NSString *current_longitude = [formatter stringFromNumber:@(coordinates.longitude)];
            if (instagram_latitude == current_latitude && instagram_longitude == current_longitude){
                [mediaGallery addObject:[media objectAtIndex:i]];
            }
        }
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        DetailsViewController *detailViewController = [[DetailsViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
        [detailViewController.mediaGalleryByLocation addObjectsFromArray:media];
    } failure:^(NSError * _Nonnull error, NSInteger serverStatusCode, NSDictionary * _Nonnull response) {
        NSLog(@"Error in getting media!!!");
        NSLog(@"%@", response);
    }];
}

# pragma mark - Collection View Datasource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [self.collectionView registerNib:[UINib nibWithNibName:@"PhotoCollectionViewCell" bundle:nil]
             forCellWithReuseIdentifier:@"PhotoCollectionViewCell"];
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCollectionViewCell" forIndexPath:indexPath];
    
    [cell.galleryImage setImageWithURL:[mediaGallery objectAtIndex:indexVal].thumbnailURL];
    indexVal++;
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

@end
