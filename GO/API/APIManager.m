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

+(NSURL *)redirectToInstagram {
//    NSString *redirectURLString = [baseRedirectURLString stringByAppendingString:clientID];
//    redirectURLString = [baseRedirectURLString stringByAppendingString:tailRedirectURLString];
//    NSURL *redirectURL = [NSURL URLWithString:redirectURLString];
    NSURL *authURL = [[InstagramEngine sharedEngine] authorizationURL];
    return authURL;
    //[self.webView loadRequest:[NSURLRequest requestWithURL:authURL]];
}

@end
