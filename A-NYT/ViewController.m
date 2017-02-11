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
    
    NSDate *today = [NSDate date];
    NSDate *yesterday = [today dateByAddingTimeInterval: -86400.0*1.0]; //Given 7 day difference, not using NSCalendar

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    
    ArticleListRequestModel *requestModel = [[ArticleListRequestModel alloc] init];
    requestModel.query = @"Modern art";
    requestModel.articlesToDate = [[ArticleListRequestModel dateFormatter] dateFromString:[dateFormatter stringFromDate:today]];
    requestModel.articlesFromDate = [[ArticleListRequestModel dateFormatter] dateFromString:[dateFormatter stringFromDate:yesterday]];
    requestModel.sort = @"newest";
    //requestModel.pageRequested = @"1";
    
    [[APIManager sharedManager] getArticlesWithRequestModel:requestModel success:^(ArticleListResponseModel *responseModel) {
        
        //NSLog(@"true response articke: %@", responseModel.articles);
        self.articles = (NSArray *)responseModel.articles;
        NSLog(@"articles: %@", self.articles);
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@", error);
        
        //Find previous articles.
        //If no previous articles, show warning about inability to connect to internet
        
    }];
    
}

- (void)downloadImageFromArticles {
    
    
}



@end
