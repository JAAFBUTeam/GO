//
//  DetailedViewController.m
//  GO
//
//  Created by Amy Liu on 7/13/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *location_title;
@property (weak, nonatomic) IBOutlet UILabel *location_description;
@property (weak, nonatomic) IBOutlet UILabel *location_address;

@property (nonatomic) float lat;
@property (nonatomic) float lon;

@property (nonatomic) double rating;

@property(nonatomic, strong) NSArray<UIImage *> *images;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self displayInformation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)displayImages {
    //self.location_image.image = [self.location.images objectAtIndex:0];
}

- (void)displayInformation {
    self.location_title.text = self.location.title;
    self.location_description.text = self.location.synopsis;
    self.location_address.text = self.location.address;
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
