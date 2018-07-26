//
//  CarouselTableViewCell.h
//  GO
//
//  Created by Joel Gutierrez on 7/19/18.


#import <UIKit/UIKit.h>
#import "Location.h"
#import "UIImageView+AFNetworking.h"
#import "iCarousel.h"

@protocol CarouselImageTapDelegate

-(void) ImageTapped:(NSUInteger)section;

@end

@interface CarouselTableViewCell : UITableViewCell <iCarouselDelegate, iCarouselDataSource>

@property (strong, nonatomic) Location *location;
@property (strong, nonatomic) NSMutableArray *locationImagesArray;
@property (strong, nonatomic) NSMutableArray *imageDataArray;
@property (nonatomic, assign) NSInteger sectionID;
@property (weak, nonatomic) IBOutlet iCarousel *carousel;
@property (nonatomic, weak) id<CarouselImageTapDelegate> imageDelegate;

-(void) setLocationObject:(Location *)location;
-(void)setCarouselProperties:(iCarouselType) carouselType;
-(void)setSectionIDForCarousel:(NSInteger)sectionID;
-(void)setupCarouselCell;

@end
