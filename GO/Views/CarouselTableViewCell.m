//
//  CarouselTableViewCell.m
//  GO
//
//  Created by Joel Gutierrez on 7/19/18.
//

#import "CarouselTableViewCell.h"
#import "Location.h"
#import "User.h"
#import "APIManager.h"

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
    [APIManager fetchMediaFromInstagram:location completionHandler:^(NSArray<InstagramMedia *> *media) {
        self.locationImagesArray = [[NSMutableArray alloc] initWithArray:media];
    }];
}

-(void)setImages: (NSMutableArray *) favorites {
    [self allocImagesArray];
    for (Location* location in favorites) {
        [self.locationImagesArray addObject:location.imageURLs.firstObject];
    }
    [_carousel reloadData];
}

-(UIImage *) addImageToImage:(UIImage *)img withImage2:(UIImage *)img2
{
    CGSize size = CGSizeMake(250, 177);
    UIGraphicsBeginImageContext(size);
    
    CGPoint pointImg1 = CGPointMake(0,0);
    [img drawAtPoint:pointImg1];
    
    CGPoint pointImg2 = CGPointMake(0,0);
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
    
    if (_location != nil) {
        view = [[UIImageView alloc] initWithFrame:self.carousel.bounds];
        [((UIImageView *)view) setImageWithURL:[NSURL URLWithString:self.locationImagesArray[index]]];
    } else {
        view = [[UIView alloc] initWithFrame:self.carousel.bounds];
        UIImageView *gradient = [[UIImageView alloc] initWithFrame:self.carousel.bounds];
        gradient.image = [UIImage imageNamed:@"gradient.png"];
        UIImageView *image = [[UIImageView alloc] initWithFrame:self.carousel.bounds];
        [image setImageWithURL:[NSURL URLWithString:self.locationImagesArray[index]]];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 20)];
        
        [title setText: User.currentUser.favorites[index].title];
        [title setTextColor:[UIColor whiteColor]];
        [title setBackgroundColor:[UIColor clearColor]];
        [title setFont:[UIFont fontWithName: @"American Typewriter" size: 22.0f]];
        
        [view addSubview:image];
        [view addSubview:gradient];
        [view addSubview:title];
        
        [title setTranslatesAutoresizingMaskIntoConstraints:NO];
        [gradient setTranslatesAutoresizingMaskIntoConstraints:NO];

        [NSLayoutConstraint activateConstraints:@[[gradient.leadingAnchor constraintEqualToAnchor:view.leadingAnchor],
                                                  [gradient.trailingAnchor constraintEqualToAnchor:view.trailingAnchor],
                                                  [gradient.topAnchor constraintEqualToAnchor:view.topAnchor constant: 150],
                                                  [gradient.bottomAnchor constraintEqualToAnchor:view.bottomAnchor]]];
        
        [NSLayoutConstraint activateConstraints:@[[title.leadingAnchor constraintEqualToAnchor:view.leadingAnchor constant:8],
                                                  [title.trailingAnchor constraintEqualToAnchor:view.trailingAnchor constant:-8],
                                                  [title.bottomAnchor constraintEqualToAnchor:view.bottomAnchor constant:-8]]];
        
        
    }
    [self registerGestures:view];
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = true;
    
    /*
    view.layer.shadowOffset = CGSizeMake(0, 3); //default is (0.0, -3.0)
    view.layer.shadowColor = [UIColor blackColor].CGColor; //default is black
    view.layer.shadowRadius = 1.0; //default is 3.0
    view.layer.shadowOpacity = .5;
    */
    
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
