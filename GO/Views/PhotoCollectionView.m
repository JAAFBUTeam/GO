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

@implementation PhotoCollectionView

# pragma mark - Lifecycle

- (void)awakeFromNib {
    [super awakeFromNib];
    
    engine = [InstagramEngine sharedEngine];
    mediaGallery = [[NSMutableArray alloc] init];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"PhotoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PhotoCollectionViewCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;

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
    
    [APIManager fetchMediaFromInstagram:currentLocation completionHandler:^(NSArray<InstagramMedia *> *media) {
        mediaGallery = [[NSMutableArray alloc] initWithArray:media];
        [self.collectionView reloadData];
    }];
}

# pragma mark - Collection View Datasource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCollectionViewCell" forIndexPath:indexPath];
    
    if (indexPath.row >= mediaGallery.count) {
        
    } else {
        [cell.galleryImage setImageWithURL:[mediaGallery objectAtIndex:indexPath.row].thumbnailURL];
    }
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return mediaGallery.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

@end
