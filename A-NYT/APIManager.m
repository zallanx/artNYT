//
//  APIManager.m
//  A-NYT
//
//  Created by Allan Zhang on 2/9/17.
//  Copyright © 2017 Allan Zhang. All rights reserved.
//

#import "APIManager.h"
#import "Mantle.h"

static NSString *const kArticlesListPath = @"/svc/search/v2/articlesearch.json";
static NSString *const kApiKey = @"a9d7f3efa1554f7ca48719428e5c1842";

@implementation APIManager

- (NSURLSessionDataTask *)getArticlesWithRequestModel:(ArticleListRequestModel *)requestModel
                                              success:(void (^)(ArticleListResponseModel *responseModel))success
                                              failure:(void (^)(NSError *error))failure {
    
    NSDictionary *parameters = [MTLJSONAdapter JSONDictionaryFromModel:requestModel error:nil];
    NSMutableDictionary *parametersWithKey = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    [parametersWithKey setObject:kApiKey forKey:@"api-key"];
    
    return [self GET:kArticlesListPath
          parameters:parametersWithKey
            progress:nil
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *responseDictionary = (NSDictionary *)responseObject;
        NSError *error;
                 
        //`responseDictionary received from quest is mapped into an object of ArticleListResponseModel class using the following class method:
        
        ArticleListResponseModel *list = [MTLJSONAdapter modelOfClass:ArticleListResponseModel.class fromJSONDictionary:responseDictionary error:&error];
        success(list);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
    
    
}

@end
