//
//  APIManager.m
//  GO
//
//  Created by Ajaita Saini on 7/24/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "APIManager.h"
#import "InstagramKit.h"

static NSString * const baseRedirectURLString = @"https://api.instagram.com/oauth/authorize/?client_id=";
static NSString * const clientID = @"daa39e5d2da244f49fc0470bfd996154";
static NSString * const tailRedirectURLString = @"&redirect_uri=REDIRECT-URI&response_type=code";

@implementation APIManager

+(void)redirectToInstagram:(InstagramEngine *)engine {
    //mediaGallery = [[NSMutableArray alloc] init];
    [[InstagramEngine sharedEngine] setAccessToken:@"8282989252.1677ed0.7c78fb4fa96e45f2b7b8aa27d0aedfc5"];
    
//    [engine getSelfRecentMediaWithSuccess:^(NSArray *media, InstagramPaginationInfo *paginationInfo) {
//        NSLog(@"Accessing media");
//        //return media;
//        [mediaGallery addObjectsFromArray:media];
//        //NSLog(@"%@", [mediaGallery objectAtIndex:0]);
//    } failure:^(NSError * _Nonnull error, NSInteger serverStatusCode, NSDictionary * _Nonnull response) {
//        NSLog(@"Error in getting media");
//        NSLog(@"%@", response);
//    }];
}

@end
