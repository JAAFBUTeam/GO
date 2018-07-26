//
//  CarouselTableViewCell.m
//  GO
//
//  Created by Joel Gutierrez on 7/19/18.
//

#import "CarouselTableViewCell.h"

@implementation CarouselTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setDummyImageArray];
    [self setDefaultCarouselProperties];
    [self setDatasourceAndDelegate];
}

# pragma mark -- Setup
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void) setLocationObject:(Location *)location {
    self.location = location;
}

-(void)setSectionIDForCarousel:(NSInteger)sectionID {
    self.sectionID = sectionID;
}

-(void)setDefaultCarouselProperties {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.carousel.type = iCarouselTypeLinear;
    self.carousel.pagingEnabled = YES;
    self.carousel.bounceDistance = 0.3;
}

-(void)setCarouselProperties:(iCarouselType) carouselType {
    self.carousel.type = carouselType;
    self.carousel.pagingEnabled = YES;
}

-(void)setDummyImageArray {
    self.locationImagesArray = [[NSMutableArray alloc] init];
    
    NSString *one = @"cat.jpg";
    NSString *two = @"dog.jpg";
    
    [self.locationImagesArray addObject:one];
    [self.locationImagesArray addObject:two];
}

-(void)setupCarouselCell {
    [self setCarouselProperties:iCarouselTypeInvertedTimeMachine];
    [self.carousel scrollByNumberOfItems:1 duration:1.5];
    [self setLocationObject:_location];
}

#pragma mark - carousel protocol methods

-(void) setDatasourceAndDelegate {
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
}

//TODO: do function
-(void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    [self.imageDelegate ImageTapped:self.sectionID];
}

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return self.locationImagesArray.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view {
    view = [[UIImageView alloc] initWithFrame:self.carousel.bounds];
    ((UIImageView *)view).image = [UIImage imageNamed:self.locationImagesArray[index]];
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = true;
    return view;
}

-(CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value {
    CGFloat result;
    switch(option) {
        case iCarouselOptionSpacing:
            result = 1.025f;
            break;
        default:
            result = value;
            break;
    }
    return result;
}

@end
