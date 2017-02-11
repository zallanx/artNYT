//
//  ArticleListResponseModel.m
//  A-NYT
//
//  Created by Allan Zhang on 2/9/17.
//  Copyright © 2017 Allan Zhang. All rights reserved.
//

#import "ArticleListResponseModel.h"

@class ArticleModel;

@implementation ArticleListResponseModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"articles" : @"response.docs",
             @"status" : @"status",
             
             };
}

+ (NSValueTransformer *)articlesJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:ArticleModel.class];
}

@end
