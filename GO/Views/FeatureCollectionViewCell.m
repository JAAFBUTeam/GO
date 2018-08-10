//
//  FeatureTableViewCell.m
//  GO
//
//  Created by Ajaita Saini on 8/2/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "FeatureCollectionViewCell.h"
#import <Parse/Parse.h>
#import "Location.h"
#import "UIImageView+AFNetworking.h"

@implementation FeatureCollectionViewCell

#pragma mark - Lifecycle

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setLocations];
    [self setFeaturedCarousel];
    [self setDefaultCarouselStyle];
    [self setDatasourceAndDelegate];
    self.carousel.userInteractionEnabled = NO;
}

#pragma mark - Setup

- (void) setLocations {
    self.locations = [[NSMutableArray alloc] init];
    
    Location *newLocation3 = [Location new];
    newLocation3.title = @"16th Avenue Tiled Steps";
    newLocation3.address = @"16th Ave, San Francisco, CA 94122";
    newLocation3.lat = 37.75663375854492;
    newLocation3.lon = -122.47356414794922;
    newLocation3.synopsis = @"Gorgeous tiled staircase!";
    newLocation3.rating = 4.3;
    newLocation3.tags = [[NSMutableArray alloc] init];
    newLocation3.imageURLs = [[NSMutableArray alloc] init];
    [newLocation3.imageURLs addObject:@"https://3.bp.blogspot.com/-UgBRK5ITezU/V1ZFDxTs9GI/AAAAAAAAB1I/y_W-RAJnibAbckLz5y2xjcG2hSWLnuOoACLcB/s1600/san%2Bfrancisco%2B16th%2Bave%2Btiled%2Bsteps%2B330x396x53kb.jpg"];
    [newLocation3.imageURLs addObject:@"https://assets.atlasobscura.com/media/W1siZiIsInVwbG9hZHMvcGxhY2VfaW1hZ2VzL2E2MGY2Y2MyNDVjNmEwM2U5MGEwMTJjYzYwMmQ1ODg4Yzc0ZWM4YmYuanBnIl0sWyJwIiwidGh1bWIiLCJ4MzkwPiJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA4MSAtYXV0by1vcmllbnQiXV0/a60f6cc245c6a03e90a012cc602d5888c74ec8bf.jpg"];
    [newLocation3.imageURLs addObject:@"https://s3-media4.fl.yelpcdn.com/bphoto/yNIqkR51EHtQTDiEAKmBNw/o.jpg"];
    [newLocation3.imageURLs addObject:@"https://i.pinimg.com/originals/93/c5/62/93c56288b2606f6c42b48937208b3d06.jpg"];
    [newLocation3.imageURLs addObject:@"https://i0.wp.com/inspiredimperfection.com/wp-content/uploads/2016/10/16th-ave-tiled-steps-ocean-san-francisco.jpg?ssl=1"];
    [newLocation3.imageURLs addObject:@"https://mymodernmet.com/wp/wp-content/uploads/archive/yYEoqhYiYYydURyAOzq-_1082098668.jpeg"];
    [self.locations addObject:newLocation3];
    
    Location *newLocation8 = [Location new];
    newLocation8.title = @"Billy Goat Hill";
    newLocation8.address = @"2442 Castro St, San Francisco, CA 94131";
    newLocation8.lat = 37.741492;
    newLocation8.lon = -122.4329806;
    newLocation8.synopsis = @"A cute hilltop park complete with a swing that offers a view of San Francisco!";
    newLocation8.rating = 4.3;
    newLocation8.tags = [[NSMutableArray alloc] init];
    newLocation8.imageURLs = [[NSMutableArray alloc] init];
    [newLocation8.imageURLs addObject:@"https://hoodwork-production.s3.amazonaws.com/uploads/story/image/23315/Billy-Goat-Hill-Park_3.jpg"];
    [newLocation8.imageURLs addObject:@"https://www.opodo.fr/blog/wp-content/uploads/sites/16/2015/10/taylor-tippett.jpg"];
    [newLocation8.imageURLs addObject:@"https://cdn.funcheap.com/wp-content/uploads/2016/07/Melissa-Loesgen-Billy-Goat-Hill-600x4001.jpg"];
    [newLocation8.imageURLs addObject:@"https://cdn.herschelsupply.com/uploads/2015/06/HSC-SM15-CL-SanFrancisco_08.jpg"];
    [newLocation8.imageURLs addObject:@"https://s.hdnux.com/photos/50/40/21/10617951/5/940x940.jpg"];
    [newLocation8.imageURLs addObject:@"https://i2.wp.com/farm7.staticflickr.com/6237/6849796588_060e3e3e68_z.jpg"];
    [newLocation8.imageURLs addObject:@"https://theshannonigansoflife.files.wordpress.com/2015/05/img_1897.jpg"];
    [self.locations addObject:newLocation8];

    
    Location *newLocation6 = [Location new];
    newLocation6.title = @"Home Cafe";
    newLocation6.address = @"1222 Noriega St, San Francisco, CA 94122";
    newLocation6.lat = 37.7544545;
    newLocation6.lon = -122.4770135;
    newLocation6.synopsis = @"Classic & unique latte drinks, plus creative toast options, served in a contemporary coffee shop!";
    newLocation6.rating = 4.2;
    newLocation6.tags = [[NSMutableArray alloc] init];
    newLocation6.imageURLs = [[NSMutableArray alloc] init];
    [newLocation6.imageURLs addObject:@"https://hoodwork-production.s3.amazonaws.com/uploads/story/image/9070/home3.jpg"];
    [newLocation6.imageURLs addObject:@"https://static1.squarespace.com/static/57689a02e4fcb58e1ae15194/57c7931446c3c48ab137934b/597b9186cd39c3708a0c9663/1515525222038/FullSizeRender+166.jpg?format=2500w"];
    [newLocation6.imageURLs addObject:@"https://s3.amazonaws.com/secretsaucefiles/photos/images/000/171/689/large/IMG_3562.JPG?1499805071"];
    [newLocation6.imageURLs addObject:@"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCtBngIfN_ClGYW0TmQeOEG7v-RpTqhJaFdX7LXnVzQfFpKSthvw"];
    [newLocation6.imageURLs addObject:@"https://s3-media2.fl.yelpcdn.com/bphoto/-XbIgKBLtfkAB79_q7NYIw/o.jpg"];
    [newLocation6.imageURLs addObject:@"https://s3-media2.fl.yelpcdn.com/bphoto/iADa_PtFSMA8BL3QurBszQ/o.jpg"];
    [newLocation6.imageURLs addObject:@"https://s3-media4.fl.yelpcdn.com/bphoto/PkzR2o1-rouCArfk6wqgYg/o.jpg"];
    [newLocation6.imageURLs addObject:@"https://s3-media4.fl.yelpcdn.com/bphoto/G2VaWiPGc8z0Zg14GsxAbQ/o.jpg"];
    [newLocation6.imageURLs addObject:@"https://s3-media2.fl.yelpcdn.com/bphoto/yJBWIspooiqKOP5EAjcABA/o.jpg"];
    [newLocation6.imageURLs addObject:@"https://s3-media2.fl.yelpcdn.com/bphoto/XYWxe0r2K6tjSHWMgjeUew/o.jpg"];
    [self.locations addObject:newLocation6];
}

# pragma mark - Setup

-(void)setFeaturedCarousel {
    self.locationImages = [[NSMutableArray alloc] init];
    for (Location *location in self.locations){
        [_locationImages addObject:location.imageURLs[0]];
    }
}

-(void)setDefaultCarouselStyle {
    self.carousel.type = iCarouselTypeLinear;
    self.carousel.pagingEnabled = YES;
    self.wrapEnabled = NO;
    self.carousel.bounceDistance = 0.3;
}

#pragma mark - carousel protocol methods

-(void)setDatasourceAndDelegate {
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
}

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return self.locationImages.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view {
    
    view = [[UIView alloc] initWithFrame:self.carousel.bounds];
    
    // set view corner radius
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = true;
    
    // set image view
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [imageView setImageWithURL:[NSURL URLWithString:self.locationImages[index]]];
    [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [view addSubview:imageView];
    [NSLayoutConstraint activateConstraints:@[[imageView.leadingAnchor constraintEqualToAnchor:view.leadingAnchor],
                                              [imageView.trailingAnchor constraintEqualToAnchor:view.trailingAnchor],
                                              [imageView.topAnchor constraintEqualToAnchor:view.topAnchor],
                                              [imageView.bottomAnchor constraintEqualToAnchor:view.bottomAnchor]]];
    
    //set gradient
    UIImageView *gradientView = [[UIImageView alloc] initWithFrame:CGRectZero];
    gradientView.image = [UIImage imageNamed:@"gradient_true.png"];
    [gradientView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [view addSubview:gradientView];
    [NSLayoutConstraint activateConstraints:@[[gradientView.leadingAnchor constraintEqualToAnchor:view.leadingAnchor],
                                              [gradientView.trailingAnchor constraintEqualToAnchor:view.trailingAnchor],
                                              [gradientView.topAnchor constraintEqualToAnchor:view.topAnchor constant:100],
                                              [gradientView.bottomAnchor constraintEqualToAnchor:view.bottomAnchor]]];
    
    
    // create label
    UILabel *label = [[UILabel alloc] initWithFrame:self.carousel.bounds];
    [label setText:[self.locations objectAtIndex:index].title];
    [label setTextColor:[UIColor whiteColor]];
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    [view addSubview:label];
    [NSLayoutConstraint activateConstraints:@[[label.leadingAnchor constraintEqualToAnchor:view.leadingAnchor constant:8],
                                              [label.trailingAnchor constraintEqualToAnchor:view.trailingAnchor constant:-8],
                                              [label.bottomAnchor constraintEqualToAnchor:view.bottomAnchor constant:-8]]];
    
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

@end
