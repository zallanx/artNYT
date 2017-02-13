//
//  DesignElements.h
//  A-NYT
//
//  Created by Allan Zhang on 2/12/17.
//  Copyright © 2017 Allan Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DesignElements : NSObject

// Used to standarize all design elements

@property (nonatomic, copy) NSDictionary *titleTextAttributes;
@property (nonatomic, copy) NSDictionary *bodyTextAttributes;
@property (nonatomic, copy) NSDictionary *buttonTextAttributes;
@property (nonatomic, copy) UIColor *backgroundColor;


@end
