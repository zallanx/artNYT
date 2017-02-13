//
//  ViewController.m
//  A-NYT
//
//  Created by Allan Zhang on 2/9/17.
//  Copyright © 2017 Allan Zhang. All rights reserved.
//

#import "BaseViewController.h"
#import "ArticleListRequestModel.h"
#import "APIManager.h"
#import "DesignElements.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface BaseViewController ()

@property (strong, nonatomic) NSMutableArray *readArticlesURL;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self prefersStatusBarHidden];
    self.readArticlesURL = [[NSMutableArray alloc] init];
    self.rewardColors = @[UIColorFromRGB(0x4c339f), UIColorFromRGB(0xf04a58), UIColorFromRGB(0x0b674e), UIColorFromRGB(0xA45976), UIColorFromRGB(0x0e87c4)];
    
    
    // Retrives articles from the NYT Art's Most Emailed section. If no articles are successfully
    // retrived, then use the placeholder article and image. Set up number of pages using
    // UIPageViewController depending on number of articles retrieved.
    
    ArticleListRequestModel *requestModel = [[ArticleListRequestModel alloc] init];
    [[APIManager sharedManager] getArticlesWithRequestModel:requestModel success:^(ArticleListResponseModel *responseModel) {
    
        NSLog(@"Success. Found %lu art", (unsigned long)self.articles.count);
        
        NSArray *articleArray = (NSArray *)responseModel.articles;
        self.articles = [articleArray subarrayWithRange:NSMakeRange(0, MIN(5, articleArray.count))];
        [self setupPagination];

    } failure:^(NSError *error) {
        
        NSLog(@"Found an error%@", error);
        self.articles = @[[self makeAPlaceholderArticle]];
         [self setupPagination];
        
    }];
    
    [self addNotifications];
   
    
}

- (void)addNotifications
{
    //Keep track of articles read status. If all articles are read for the day, display a reward visual.
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidBecomeActiveNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(checkArticlesReadStatus)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"articleRead" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(processNotification:) name:@"articleRead" object:nil];
}

- (void)processNotification: (NSNotification *)sender {
    if ([sender.name isEqualToString:@"articleRead"]){
        NSDictionary *userInfo = sender.userInfo;
        NSString *readArticleUrl = [userInfo objectForKey:@"url"];
        if (![self.readArticlesURL containsObject:readArticleUrl]){
            [self.readArticlesURL addObject:readArticleUrl];
        }
    }
    

}

- (void)checkArticlesReadStatus {
    NSLog(@"Just got activated!");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    DesignElements *designDictionary = [[DesignElements alloc] init];
    self.view.backgroundColor = designDictionary.backgroundColor;
    
    
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

- (ArticleModel *)makeAPlaceholderArticle
{
    ArticleModel *placeholderArticle = [[ArticleModel alloc] init];
    placeholderArticle.articleTitle = @"Art can be offline, too";
    placeholderArticle.abstract = @"While you are not connected to the internet, you can explore galleries and museums around you to discover new art.";
    placeholderArticle.url = nil;
    placeholderArticle.mediaArray = nil;
    return placeholderArticle;
}

#pragma mark - Page View Datasource Methods

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
    pageContentViewController.rewardColor = self.rewardColors[index];

    return pageContentViewController;
}

#pragma mark - No of Pages Methods

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return [self.articles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}


- (BOOL)prefersStatusBarHidden {
    return YES;
}





@end
