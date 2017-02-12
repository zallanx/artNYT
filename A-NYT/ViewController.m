//
//  ViewController.m
//  A-NYT
//
//  Created by Allan Zhang on 2/9/17.
//  Copyright © 2017 Allan Zhang. All rights reserved.
//

#import "ViewController.h"
#import "ArticleListRequestModel.h"
#import "APIManager.h"


@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ArticleListRequestModel *requestModel = [[ArticleListRequestModel alloc] init];
    [[APIManager sharedManager] getArticlesWithRequestModel:requestModel success:^(ArticleListResponseModel *responseModel) {
        
        self.articles = (NSArray *)responseModel.articles;
        [self setupPagination];

    } failure:^(NSError *error) {
        
        NSLog(@"%@", error);
        
        //Find previous articles.
        //If no previous articles, show warning about inability to connect to internet
        
    }];
    
    
    
}

- (void)setupPagination {
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    self.pageViewController.view.frame = self.view.frame;//CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height*1.20);
    [self addChildViewController:self.pageViewController];
   
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];

}

#pragma mark - Page View Datasource Methods
//11. page view methods
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    
    return [self viewControllerAtIndex:index];
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    
    if (index == [self.articles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index {
    if (([self.articles count] == 0) || (index >= [self.articles count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.article = self.articles[index];
    pageContentViewController.pageIndex = index;
    pageContentViewController.view.tag = index;

    return pageContentViewController;
}

#pragma mark - No of Pages Methods

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return [self.articles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}






@end
