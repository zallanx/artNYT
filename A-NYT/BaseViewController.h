//
//  ViewController.h
//  A-NYT
//
//  Created by Allan Zhang on 2/9/17.
//  Copyright © 2017 Allan Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"

@interface BaseViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, copy) NSArray *articles;
@property (nonatomic, copy) NSArray *rewardColors;

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index;

@end

