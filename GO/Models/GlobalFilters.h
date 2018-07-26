//
//  GlobalFilters.h
//  GO
//
//  Created by Joel Gutierrez on 7/26/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ALL = 0,
    RESTAURANTS,
    SELFIESPOTS,
    HOTELS,
    EVENTS,
    GAS
} CategoryType;

@interface GlobalFilters : NSObject

@property (assign, nonatomic) CategoryType categoryType;

+ (GlobalFilters *)sharedInstance;

@end
