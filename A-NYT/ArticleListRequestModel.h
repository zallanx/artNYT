//
//  ArticleListRequestModel.h
//  A-NYT
//
//  Created by Allan Zhang on 2/9/17.
//  Copyright © 2017 Allan Zhang. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ArticleListRequestModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *query;
@property (nonatomic, copy) NSDate *articlesFromDate;
@property (nonatomic, copy) NSDate *articlesToDate;
@property (nonatomic, copy) NSString *sort;
//@property (nonatomic, copy) NSString *pageRequested;


+ (NSDateFormatter *)dateFormatter;


@end
