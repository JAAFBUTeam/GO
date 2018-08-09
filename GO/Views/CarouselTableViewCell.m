//
//  CarouselTableViewCell.m
//  GO
//
//  Created by Joel Gutierrez on 7/19/18.
//

#import "CarouselTableViewCell.h"
#import "Location.h"

@implementation CarouselTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self allocImagesArray];
    [self setDefaultCarouselStyle];
}

- (void)prepareForReuse {
    [super prepareForReuse];
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

-(void)setImages: (NSMutableArray *) favorites {
    [self allocImagesArray];
    UIImage *gradient = [[UIImage alloc] initWithContentsOfFile:@"gradient.png"];
    for (Location* location in favorites) {
        [self.locationImagesArray addObject:location.imageURLs.firstObject];
        UIImageView *image = [[UIImageView alloc] init];
        [image setImageWithURL:[NSURL URLWithString:location.imageURLs.firstObject]];
        [self addImageToImage:image.image withImage2:gradient];
    }
    
    [_carousel reloadData];
}

-(UIImage *) addImageToImage:(UIImage *)img withImage2:(UIImage *)img2
{
    CGRect rect = CGRectMake(32, 22, 246, 177);
    
    CGSize size = CGSizeMake(246,40);
    UIGraphicsBeginImageContext(size);
    
    CGPoint pointImg1 = CGPointMake(0,0);
    [img drawAtPoint:pointImg1];
    
    CGPoint pointImg2 = rect.origin;
    [img2 drawAtPoint: pointImg2];
    
    UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

-(void)setSectionIDProperty:(NSInteger)sectionID {
    self.sectionID = sectionID;
}

-(void)setDefaultCarouselStyle {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.carousel.type = iCarouselTypeLinear;
    self.carousel.pagingEnabled = YES;
    self.wrapEnabled = NO;
    self.carousel.bounceDistance = 0.3;
    self.heartImageView.alpha = 0;
}

-(void)setCarouselTypeProperties:(iCarouselType) carouselType {
    self.carousel.type = carouselType;
    if(self.carousel.type == iCarouselTypeLinear) {
        //[self.carousel scrollByNumberOfItems:3 duration:1.5];
        self.wrapEnabled = YES;
    }
}

#pragma mark - carousel protocol methods

-(void)setDatasourceAndDelegate {
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
}

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return self.locationImagesArray.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view {
    view = [[UIImageView alloc] initWithFrame:self.carousel.bounds];
    
    if (_locationImagesArray.count != 0 && [_locationImagesArray[0] isKindOfClass:[NSString class]]) {
        [((UIImageView *)view) setImageWithURL:[NSURL URLWithString:self.locationImagesArray[index]]];
    } else {
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:self.carousel.bounds];
        image.image = self.locationImagesArray[index];
        [view addSubview:image];
    }
    [self registerGestures:view];
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
        case iCarouselOptionWrap:
            result = self.wrapEnabled;
            break;
        default:
            result = value;
            break;
    }
    return result;
}

#pragma mark - actions

-(void)registerGestures:(UIView *)view {
    view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
    tapGesture.numberOfTapsRequired = 1;
    [view addGestureRecognizer:tapGesture];
}

-(void)didTap {
    [self.imageDelegate imageTapped:self.sectionID];
}

-(void)heartImageAnimation {
    [UIView animateWithDuration:1.0 animations:^{
        self.heartImageView.alpha = 1;
    }];
    
    [UIView animateWithDuration:1.0 animations:^{
        self.heartImageView.alpha = 0;
    }];
}

@end
