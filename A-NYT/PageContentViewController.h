//
//  PageContentViewController.h
//  A-NYT
//
//  Created by Allan Zhang on 2/11/17.
//  Copyright © 2017 Allan Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleModel.h"

@interface PageContentViewController : UIViewController

@property  NSUInteger pageIndex;

@property (strong, nonatomic) ArticleModel *article;

@end
