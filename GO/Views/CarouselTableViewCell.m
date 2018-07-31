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
    [self allocImagesArray];
    [self setDefaultCarouselStyle];
}

# pragma mark - Setup

-(void)allocImagesArray {
    self.locationImagesArray = [[NSMutableArray alloc] init];
}

-(void)setLocationProperty:(Location *)location {
    self.location = location;
    for (NSString* imageString in location.imageURLs){
        [self.locationImagesArray addObject:imageString];
    }
}

-(void)setSectionIDProperty:(NSInteger)sectionID {
    self.sectionID = sectionID;
}

-(void)setDefaultCarouselStyle {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.carousel.type = iCarouselTypeLinear;
    self.carousel.pagingEnabled = YES;
    self.carousel.bounceDistance = 0.3;
}

-(void)setCarouselTypeProperties:(iCarouselType) carouselType {
    self.carousel.type = carouselType;
    [self.carousel scrollByNumberOfItems:1 duration:1.5];
    self.carousel.pagingEnabled = YES;
}

-(void)setupCarouselCell {
    [self setCarouselTypeProperties:iCarouselTypeInvertedTimeMachine];
    [self.carousel scrollByNumberOfItems:1 duration:1.5];
    //[self setLocationProperty:_location];
}

#pragma mark - carousel protocol methods

-(void)setDatasourceAndDelegate {
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
}

-(void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    [self.imageDelegate ImageTapped:self.sectionID];
}

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return self.locationImagesArray.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view {
    view = [[UIImageView alloc] initWithFrame:self.carousel.bounds];
    [((UIImageView *)view) setImageWithURL:[NSURL URLWithString:self.locationImagesArray[index]]];
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
