//
//  ArticleModel.m
//  A-NYT
//
//  Created by Allan Zhang on 2/9/17.
//  Copyright © 2017 Allan Zhang. All rights reserved.
//

#import "ArticleModel.h"

@implementation ArticleModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    //Properties of articles
    return @{
             @"url" : @"url",
             @"abstract" : @"abstract",
             @"articleTitle" : @"title",
             @"mediaArray" : @"media",
             };
}

@end
