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
    self.currentLocation = [self.locations objectAtIndex:0];
    [self.imageView setImageWithURL:[NSURL URLWithString:self.currentLocation.imageURLs[0]]];
    self.titleLabel.text = [@"Featured: " stringByAppendingString:self.currentLocation.title];
}

#pragma mark - Setup

- (void) setLocations {
    self.locations = [[NSMutableArray alloc] init];
    
    Location *newLocation = [Location new];
    newLocation.title = @"TEST1";
    newLocation.synopsis = @"Some really cool art!";
    newLocation.address = @"151 3rd St, San Francisco, CA 94103";
    newLocation.lat = 37.7857;
    newLocation.lon = -122.4011;
    newLocation.rating = 4.9;
    newLocation.tags = [[NSMutableArray alloc] init];
    newLocation.imageURLs = [[NSMutableArray alloc] init];
    [newLocation.imageURLs addObject:@"https://s3-us-west-2.amazonaws.com/sfmomamedia/media/t/uploads/images/O1na7VIebCKV.jpg"];
    [self.locations addObject:newLocation];
    
    Location *newLocation2 = [Location new];
    newLocation2.title = @"TEST2";
    newLocation2.synopsis = @"A botanic jewel!";
    newLocation2.address = @"236 Monterey Blvd, San Francisco, CA 94131";
    newLocation2.lat = 37.731928;
    newLocation2.lon = -122.440789;
    newLocation2.rating = 4.0;
    newLocation2.tags = [[NSMutableArray alloc] init];
    newLocation2.imageURLs = [[NSMutableArray alloc] init];
    [newLocation2.imageURLs addObject:@"https://static1.squarespace.com/static/5115ccdae4b04c436ed83ed4/572810e737013ba5d459b4f3/572810efe32140b8013928a0/1462243575441/Sunnyside+Conservatory+Wedding-15.jpg"];
    [self.locations addObject:newLocation2];
    
    Location *newLocation3 = [Location new];
    newLocation3.title = @"TEST3";
    newLocation3.address = @"16th Ave, San Francisco, CA 94122";
    newLocation3.lat = 37.75663375854492;
    newLocation3.lon = -122.47356414794922;
    newLocation3.synopsis = @"Gorgeous tiled staircase!";
    newLocation3.rating = 4.3;
    newLocation3.tags = [[NSMutableArray alloc] init];
    newLocation3.imageURLs = [[NSMutableArray alloc] init];
    [newLocation3.imageURLs addObject:@"https://3.bp.blogspot.com/-UgBRK5ITezU/V1ZFDxTs9GI/AAAAAAAAB1I/y_W-RAJnibAbckLz5y2xjcG2hSWLnuOoACLcB/s1600/san%2Bfrancisco%2B16th%2Bave%2Btiled%2Bsteps%2B330x396x53kb.jpg"];
    [self.locations addObject:newLocation3];
}

#pragma mark - Page control

-(void)swipePageControl:(UISwipeGestureRecognizer *)swipeGestureRecognizer{
    if ([swipeGestureRecognizer direction] == UISwipeGestureRecognizerDirectionLeft){
        self.pageControl.currentPage -=1;
        NSLog(@"swipe left!");
    } else if ([swipeGestureRecognizer direction] == UISwipeGestureRecognizerDirectionRight) {
        self.pageControl.currentPage +=1;
        NSLog(@"swipe right!");
    }
    
    NSInteger index = [self.pageControl currentPage];
    self.currentLocation = [self.locations objectAtIndex:index];
    [self.imageView setImageWithURL:[NSURL URLWithString:self.currentLocation.imageURLs[0]]];
    self.titleLabel.text = [@"Featured: " stringByAppendingString:self.currentLocation.title];
    //NSLog(@"%@", self.locations[[self.pageControl currentPage]].imageURLs[0]);
}

@end
