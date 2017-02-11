//
//  ArticleListRequestModel.m
//  A-NYT
//
//  Created by Allan Zhang on 2/9/17.
//  Copyright © 2017 Allan Zhang. All rights reserved.
//

#import "ArticleListRequestModel.h"

@implementation ArticleListRequestModel

//ArticleListRequestModel specifies how the properties of the model are mapped into its JSON representations.

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             @"query": @"q",
             @"articlesFromDate": @"begin_date",
             @"articlesToDate": @"end_date"
             };
    
}

//Date needed for article request

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMdd";
    return dateFormatter;
}

+ (NSValueTransformer *)articlesFromDateJSONTransformer {
    
    //Tells Mantle how the value of a specific JSON field (FromDate) should be transformed during JSON deserialization.
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success,
                                                                 NSError *__autoreleasing *error) {
        return [self.dateFormatter dateFromString:dateString];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

+ (NSValueTransformer *)articlesToDateJSONTransformer {
    
    //Tells Mantle how the value of a specific JSON field (ToDate) should be transformed during JSON deserialization.
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter dateFromString:dateString];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter stringFromDate:date];
    }];
}



@end
