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
#import "PhotoCollectionView.h"
#import "PhotoCollectionViewCell.h"
#import "CarouselTableViewCell.h"
#import "UIImageView+AFNetworking.h"


@interface PhotoCollectionViewController () <WKNavigationDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *instagramButton;
@property (strong, nonatomic) NSMutableArray<InstagramMedia *> *mediaGallery;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation PhotoCollectionViewController

# pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [APIManager fetchMediaFromInstagram:self.location completionHandler:^(NSArray<InstagramMedia *> *media) {
        self.mediaGallery = [[NSMutableArray alloc] initWithArray:media];
        [self.collectionView reloadData];
    }];
}

# pragma mark - CollectionView Datasource

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCollectionViewCell" forIndexPath:indexPath];
    
    [cell.galleryImage setImageWithURL:[_mediaGallery objectAtIndex:indexPath.item].thumbnailURL];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.mediaGallery.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

@end
