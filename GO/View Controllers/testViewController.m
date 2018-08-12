//
//  testViewController.m
//  GO
//
//  Created by Ajaita Saini on 8/11/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "testViewController.h"
#import "ISHPullUp/ISHPullUpHandleView.h"
#import "ISHPullUp/ISHPullUpRoundedView.h"
#import "ISHPullUp/ISHPullUpViewController.h"

@interface testViewController ()

@end

@implementation testViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pullUpController = [[ISHPullUpViewController alloc] init];
    self.firstAppearanceCompleted = true;
    self.pullUpController.stateDelegate = self;
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.topView addGestureRecognizer:gesture];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)handleTap:(UITapGestureRecognizer *)gesture {
    if ([self.pullUpController isLocked]){
        return;
    }
    
    [_pullUpController toggleStateAnimated:true];
    //[self pullUpViewController:_pullUpController didChangeToState:<#(ISHPullUpState)#>];
}

//- (CGFloat)pullUpViewController:(nonnull ISHPullUpViewController *)pullUpViewController maximumHeightForBottomViewController:(nonnull UIViewController *)bottomVC maximumAvailableHeight:(CGFloat)maximumAvailableHeight {
//}
//
//- (CGFloat)pullUpViewController:(nonnull ISHPullUpViewController *)pullUpViewController minimumHeightForBottomViewController:(nonnull UIViewController *)bottomVC {
//}
//
//- (CGFloat)pullUpViewController:(nonnull ISHPullUpViewController *)pullUpViewController targetHeightForBottomViewController:(nonnull UIViewController *)bottomVC fromCurrentHeight:(CGFloat)height {
//}
//
//- (void)pullUpViewController:(nonnull ISHPullUpViewController *)pullUpViewController updateEdgeInsets:(UIEdgeInsets)edgeInsets forBottomViewController:(nonnull UIViewController *)contentVC {
//}
//


- (void)pullUpViewController:(nonnull ISHPullUpViewController *)pullUpViewController didChangeToState:(ISHPullUpState)state {
    [self.handleView setState:[ISHPullUpHandleView handleStateForPullUpState:state] animated:_firstAppearanceCompleted];
    //    [UIView animateWithDuration:0.25 animations:^{
    //        if (state == ISHPullUpStateCollapsed){
    //            self.topView.alpha = 0;
    //        } else {
    //            self.topView.alpha = 1;
    //        }
    //    }];
}

//func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, didChangeTo state: ISHPullUpState) {
//    topLabel.text = textForState(state);
//    handleView.setState(ISHPullUpHandleView.handleState(for: state), animated: firstAppearanceCompleted)
//
//    // Hide the scrollview in the collapsed state to avoid collision
//    // with the soft home button on iPhone X
//    UIView.animate(withDuration: 0.25) { [weak self] in
//        self?.scrollView.alpha = (state == .collapsed) ? 0 : 1;
//    }
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
