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

@property (nonatomic, strong) NSArray *articles;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ArticleListRequestModel *requestModel = [[ArticleListRequestModel alloc] init];
    [[APIManager sharedManager] getArticlesWithRequestModel:requestModel success:^(ArticleListResponseModel *responseModel) {
        
        self.articles = (NSArray *)responseModel.articles;

    } failure:^(NSError *error) {
        
        NSLog(@"%@", error);
        
        //Find previous articles.
        //If no previous articles, show warning about inability to connect to internet
        
    }];
    
}






@end
