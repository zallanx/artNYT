//
//  APIManager.h
//  A-NYT
//
//  Created by Allan Zhang on 2/9/17.
//  Copyright © 2017 Allan Zhang. All rights reserved.
//

#import "SessionManager.h"
#import "ArticleListRequestModel.h"
#import "ArticleListResponseModel.h"

@interface APIManager : SessionManager

// `APIManager` takes an `ArticleListRequestModel` request model as a parameter
// and returns an `ArticleListResponseModel` in case of success, or an NSError otherwise

// The `APIManager` uses `AFNetworking` to perform the GET request to the NYT API

- (NSURLSessionDataTask *)getArticlesWithRequestModel:(ArticleListRequestModel *)requestModel
                                              success:(void (^)(ArticleListResponseModel *responseModel))success
                                              failure:(void (^)(NSError *error))failure;


@end
