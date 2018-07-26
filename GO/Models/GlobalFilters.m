//
//  GlobalFilters.m
//  GO
//
//  Created by Joel Gutierrez on 7/26/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "GlobalFilters.h"

@implementation GlobalFilters

+ (GlobalFilters *)sharedInstance {
    static GlobalFilters *sharedInstance = nil;
    static dispatch_once_t onceToken; // onceToken = 0
    dispatch_once(&onceToken, ^{
        sharedInstance = [[GlobalFilters alloc] init];
    });
    
    return sharedInstance;
}

@end
