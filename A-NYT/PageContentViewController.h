//
//  PageContentViewController.h
//  A-NYT
//
//  Created by Allan Zhang on 2/11/17.
//  Copyright © 2017 Allan Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleModel.h"
#import "DesignElements.h"

@interface PageContentViewController : UIViewController

@property  NSUInteger pageIndex;

@property (copy, nonatomic) ArticleModel *article;
@property (copy, nonatomic) UIColor *rewardColor;

@end
