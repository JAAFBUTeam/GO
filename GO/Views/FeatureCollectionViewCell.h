//
//  FeatureCollectionViewCell.h
//  GO
//
//  Created by Ajaita Saini on 8/6/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
#import "iCarousel.h"

@interface FeatureCollectionViewCell : UICollectionViewCell <iCarouselDelegate, iCarouselDataSource>

@property(nonatomic, strong) Location* currentLocation;
@property(nonatomic, strong) NSMutableArray<Location *> *locations;
@property (strong, nonatomic) NSMutableArray *locationImages;
@property (nonatomic, assign) NSInteger sectionID;
@property (weak, nonatomic) IBOutlet iCarousel *carousel;
@property (nonatomic, assign) BOOL wrapEnabled;

-(void)setLocationProperty:(Location *)location;
-(void)setCarouselTypeProperties:(iCarouselType)carouselType;
-(void)setSectionIDProperty:(NSInteger)sectionID;
-(void)setDatasourceAndDelegate;
-(void)setupCarouselCell;
-(void)setImages: (NSMutableArray *) favorites;

@end
