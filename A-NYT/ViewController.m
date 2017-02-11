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
#import <Realm/Realm.h>
#import "ArticleRealm.h"

@interface ViewController ()

@property (nonatomic, strong) RLMResults *articles;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDate *today = [NSDate date];
    NSDate *yesterday = [today dateByAddingTimeInterval: -86400.0]; //Given single day difference, not using NSCalendar

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    
    ArticleListRequestModel *requestModel = [[ArticleListRequestModel alloc] init];
    requestModel.query = @"modern art";
    requestModel.articlesToDate = [[ArticleListRequestModel dateFormatter] dateFromString:[dateFormatter stringFromDate:today]];
    requestModel.articlesFromDate = [[ArticleListRequestModel dateFormatter] dateFromString:[dateFormatter stringFromDate:yesterday]];
    
    [[APIManager sharedManager] getArticlesWithRequestModel:requestModel success:^(ArticleListResponseModel *responseModel) {
        
        
        //Realm transactions blocks up the thread, hence using non-UI thread
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            
            @autoreleasepool {
                
                //Ensures the `tempRealm` is empty at each new API call
                RLMRealm *tempRealm = [RLMRealm defaultRealm];
                [tempRealm beginWriteTransaction];
                [tempRealm deleteAllObjects];
                [tempRealm commitWriteTransaction];
                
                //Stores `ArticleModel` articles as `ArticleRealm` objects to non-main thread `tempRealm`
                [tempRealm beginWriteTransaction];
                for (ArticleModel *article in responseModel.articles){
                    ArticleRealm *articleRealm = [[ArticleRealm alloc] initWithModel:article];
                    [tempRealm addObject:articleRealm];
                }
                [tempRealm commitWriteTransaction];
                
                //Retrives the previously saved Realm objects on the main thread
                dispatch_async(dispatch_get_main_queue(), ^{
                    RLMRealm *mainRealm = [RLMRealm defaultRealm];
                    RLMResults *articles = [ArticleRealm allObjectsInRealm:mainRealm];
                    self.articles = articles;
                    NSLog(@"%@ from success", self.articles);
                    
                });
                
                
            }
            
        });
        
    } failure:^(NSError *error) {
        
        //If API retrival fails (after the initial time), previous articles are shown again
        self.articles = [ArticleRealm allObjects];
        NSLog(@"%@ from error", error);
        
        
        
    }];
    
    
}




@end
