//
//  DesignElements.m
//  A-NYT
//
//  Created by Allan Zhang on 2/12/17.
//  Copyright © 2017 Allan Zhang. All rights reserved.
//

#import "DesignElements.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation DesignElements

- (id)init {
    if (self = [super init]) {
        self.titleTextAttributes = [self configureTitleTextAttributes];
        self.bodyTextAttributes = [self configureBodyTextAttributes];
        self.buttonTextAttributes = [self configureButtonTextAttributes];
        self.backgroundColor = UIColorFromRGB(0x282828);
    }
    
    return self;
}

- (NSDictionary *)configureTitleTextAttributes
{
    return @{
             @"textColor" : UIColorFromRGB(0xffffff),
             @"font" : [UIFont fontWithName:@"Futura-CondensedMedium" size:32.0],
             };
}

- (NSDictionary *)configureBodyTextAttributes
{
    return @{
             @"textColor" : UIColorFromRGB(0xdedede),
             @"font" : [UIFont fontWithName:@"Palatino-Roman" size:16.0],
             };
}

- (NSDictionary *)configureButtonTextAttributes
{
    return @{
             @"titleColor" : UIColorFromRGB(0x1aacfb),
             @"highlightColor" : UIColorFromRGB(0x1b7db2),
             @"font" : [UIFont fontWithName:@"Futura-CondensedMedium" size:16.0],
             };
}

@end