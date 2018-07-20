//
//  CarouselTableViewCell.h
//  GO
//
//  Created by Joel Gutierrez on 7/19/18.


#import <UIKit/UIKit.h>
#import "Location.h"
#import "UIImageView+AFNetworking.h"
#import "iCarousel.h"

@interface CarouselTableViewCell : UITableViewCell <iCarouselDelegate, iCarouselDataSource>

@property (strong, nonatomic) Location *location;
@property (strong, nonatomic) NSMutableArray *locationImagesArray;
@property (strong, nonatomic) NSMutableArray *imageDataArray;
@property (weak, nonatomic) IBOutlet iCarousel *carousel;

-(void) setLocationObject:(Location *)location;
-(void)setCarouselProperties:(iCarouselType) carouselType;

@end
