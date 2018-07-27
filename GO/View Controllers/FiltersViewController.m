//
//  FiltersViewController.m
//  GO
//
//  Created by Joel Gutierrez on 7/26/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "FiltersViewController.h"

@interface FiltersViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *hiddenGemSegmentedControl;
@property (weak, nonatomic) IBOutlet UISlider *minRatingSlider;
@property (weak, nonatomic) IBOutlet UISwitch *openLocationSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *nearestLocationsSwitch;
@property (weak, nonatomic) IBOutlet UIButton *applyButton;

@end

@implementation FiltersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self LayoutUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)LayoutUI {
    self.applyButton.layer.cornerRadius = 5;
    self.applyButton.clipsToBounds = YES;
}

-(void)showDefaults {
    self.hiddenGemSegmentedControl.selectedSegmentIndex = 0;
    self.minRatingSlider.value = 0;
    [self.openLocationSwitch setOn:NO];
    [self.nearestLocationsSwitch setOn:NO];
}

#pragma mark - actions

- (IBAction)cancelButtonTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)resetButtonTap:(id)sender {
    [self showDefaults];
}

- (IBAction)applyButtonTap:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil]; //change nil?
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
