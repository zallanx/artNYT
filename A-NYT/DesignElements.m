//
//  DesignElements.m
//  A-NYT
//
//  Created by Allan Zhang on 2/12/17.
//  Copyright © 2017 Allan Zhang. All rights reserved.
//

#import "DesignElements.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)568) < DBL_EPSILON)

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
    
    float fontSize = 32.0;
    if (IS_IPHONE_4 || IS_IPHONE_5){
        fontSize = 24.0;
    }
    
    return @{
             @"textColor" : UIColorFromRGB(0xffffff),
             @"font" : [UIFont fontWithName:@"Futura-CondensedMedium" size:fontSize],
             };
}

- (NSDictionary *)configureBodyTextAttributes
{
    float fontSize = 16.0;
    if (IS_IPHONE_4 || IS_IPHONE_5){
        fontSize = 14.0;
    }
    
    return @{
             @"textColor" : UIColorFromRGB(0xffffff),
             @"font" : [UIFont fontWithName:@"Palatino-Roman" size:fontSize],
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
