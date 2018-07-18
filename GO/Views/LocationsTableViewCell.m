//
//  LocationsTableViewCell.m
//  GO
//
//  Created by Joel Gutierrez on 7/16/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "LocationsTableViewCell.h"

@implementation LocationsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setCarouselProperties];
    [self setDummyImageArray];
    [self setDatasourceAndDelegate];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void) setLocationObject:(Location *)location {
    
    self.location = location;
    //[self setDummyImageArray];
}

-(void)setCarouselProperties {
    self.carousel.type = iCarouselTypeLinear;
    self.carousel.pagingEnabled = YES;
}

-(void)setDummyImageArray {
    
    self.locationImagesArray = [[NSMutableArray alloc] init];
    
    NSString * locationImageString = @"https://media.licdn.com/dms/image/C5103AQFSzkTQcTNk3A/profile-displayphoto-shrink_200_200/0?e=1537401600&v=beta&t=jRM2BEccIEAMatPgEkw0RtNf5qYE2Bqx412fqD7zESg";
    NSURL *locationURL = [NSURL URLWithString:locationImageString];
    UIImageView *one = [[UIImageView alloc] init];
    [one setImageWithURL:locationURL];

    NSString * locationImageStringTwo = @"https://media.licdn.com/dms/image/C5103AQFSzkTQcTNk3A/profile-displayphoto-shrink_200_200/0?e=1537401600&v=beta&t=jRM2BEccIEAMatPgEkw0RtNf5qYE2Bqx412fqD7zESg";
    NSURL *locationURLTwo = [NSURL URLWithString:locationImageStringTwo];
    UIImageView *two = [[UIImageView alloc] init];
    [two setImageWithURL:locationURLTwo];
    
    [self.locationImagesArray addObject:one];
    [self.locationImagesArray addObject:two];
    
}

#pragma mark - carousel protocol methods
-(void) setDatasourceAndDelegate {
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
}

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return self.locationImagesArray.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view {
    
    view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 200.0f)];
    view.backgroundColor = UIColor.blueColor;
    UIImageView *image  = self.locationImagesArray[index];
    //((UIImageView *)view).image = image;
    [view addSubview:image];
    return view;
}



@end
