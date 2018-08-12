//
//  testViewController.h
//  GO
//
//  Created by Ajaita Saini on 8/11/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISHPullUp/ISHPullUpHandleView.h"
#import "ISHPullUp/ISHPullUpRoundedView.h"
#import "ISHPullUp/ISHPullUpViewController.h"

@interface testViewController : UIViewController <ISHPullUpSizingDelegate, ISHPullUpStateDelegate>

@property (strong, nonatomic) ISHPullUpViewController *pullUpController;
@property bool firstAppearanceCompleted;
@property (strong, nonatomic) IBOutlet ISHPullUpHandleView *topView;
@property (weak, nonatomic) IBOutlet ISHPullUpHandleView *handleView;

@end
