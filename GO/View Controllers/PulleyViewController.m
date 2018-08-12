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
#import "testViewController.h"

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
    
    UIStoryboard *storyBoardtest = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    testViewController *testViewController = [storyBoardtest instantiateViewControllerWithIdentifier:@"Main"];
    
    self.bottomViewController = testViewController;
    self.contentViewController = mapViewController;
    testViewController.pullUpController = self;
    

//    [self.contentDelegate pullUpViewController:self updateEdgeInsets:UIEdgeInsetsZero forContentViewController:categoriesViewController];
//    [self.sizingDelegate pullUpViewController:self minimumHeightForBottomViewController:mapViewController];
//    [self.stateDelegate pullUpViewController:self didChangeToState:ISHPullUpStateDragging];
    
    //self.contentDelegate = self;
    //self.sizingDelegate = self;
    //self.stateDelegate = self;
//    [self addViewOfSubViewController:self.mapViewController belowView:nil];
//    [self addViewOfSubViewController:self.categoriesViewController belowView:self.mapViewController.view];
    //[self presentViewController:mapViewC animated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
