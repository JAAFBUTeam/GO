//
//  PhotoCollectionViewController.m
//  GO
//
//  Created by Amy Liu on 7/20/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "PhotoCollectionViewController.h"
#import "APIManager.h"

@interface PhotoCollectionViewController () 
@property (weak, nonatomic) IBOutlet UIWebView *webKitView;
@property (weak, nonatomic) IBOutlet UIButton *instagramButton;

@end

@implementation PhotoCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)onTapConnectInstagramButton:(id)sender {
    NSURL *authURL = [APIManager redirectToInstagram];
    [self.webKitView loadRequest:[NSURLRequest requestWithURL:authURL]];
}

@end
