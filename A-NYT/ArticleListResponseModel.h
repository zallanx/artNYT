//
//  ArticleListResponseModel.h
//  A-NYT
//
//  Created by Allan Zhang on 2/9/17.
//  Copyright © 2017 Allan Zhang. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "ArticleModel.h"

@interface ArticleListResponseModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSArray *articles;
@property (nonatomic, copy) NSString *status;

@end
