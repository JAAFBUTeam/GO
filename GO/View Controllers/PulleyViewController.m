//
//  PulleyViewController.m
//  GO
//
//  Created by Ajaita Saini on 8/10/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "PulleyViewController.h"
#import "MapViewController.h"
#import "CategoriesViewController.h"
#import "ISHPullUp/ISHPullUpHandleView.h"
#import "ISHPullUp/ISHPullUpRoundedView.h"
#import "ISHPullUp/ISHPullUpViewController.h"
#import "FeatureCollectionViewCell.h"

@interface PulleyViewController ()

@end

@implementation PulleyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBottomSheetView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addBottomSheetView {
    UIStoryboard *storyBoardMap = [UIStoryboard storyboardWithName:@"MapView" bundle:nil];
    MapViewController *mapViewController = [storyBoardMap instantiateViewControllerWithIdentifier:@"MapViewController"];
    [self presentViewController:mapViewController animated:YES completion:nil];
    
    UIStoryboard *storyBoardtest = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CategoriesViewController *testViewController = [storyBoardtest instantiateViewControllerWithIdentifier:@"Main"];
    [self presentViewController:testViewController animated:YES completion:nil];
    
    self.bottomViewController = testViewController;
    self.contentViewController = mapViewController;
    testViewController.pullUpController = self;
}

@end
