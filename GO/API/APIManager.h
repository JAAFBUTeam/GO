//
//  APIManager.h
//  GO
//
//  Created by Ajaita Saini on 7/24/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "BDBOAuth1SessionManager.h"
#import "InstagramKit.h"

@interface APIManager : BDBOAuth1SessionManager

+(void)redirectToInstagram:(InstagramEngine *)engine;

@end
