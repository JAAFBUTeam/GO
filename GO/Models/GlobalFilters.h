//
//  GlobalFilters.h
//  GO
//
//  Created by Joel Gutierrez on 7/26/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    SELFIESPOTS = 0,
    FOOD,
    CAFES,
    ART,
    ARCHITECTURE,
    CULTUREANDHISTORY,
    NATURE,
    ALL
} CategoryType;

@interface GlobalFilters : NSObject

@property (assign, nonatomic) CategoryType categoryType;

@property (assign, nonatomic) BOOL appliedFilters;
@property (assign, nonatomic) NSInteger hiddenGemSegmented;
@property (assign, nonatomic) NSInteger minRatingSlider;
@property (assign, nonatomic) BOOL openLocationSwitch;
@property (assign, nonatomic) BOOL nearestLocationSwitch;

+ (GlobalFilters *)sharedInstance;

@end
