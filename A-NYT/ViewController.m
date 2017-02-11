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
        
        //NSLog(@"true response articke: %@", responseModel.articles);
        //NSLog(@"%@", responseModel.articles);
        for (ArticleModel *article in responseModel.articles){
            NSLog(@"article %@", article);
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@", error);
        
        //Find previous articles.
        //If no previous articles, show warning about inability to connect to internet
        
    }];
    
}

- (void)downloadImageFromArticles {
    
    
}



@end
