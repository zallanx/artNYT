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
    
    // Parameters placed after .json could be added here
    // NYT Most Shared API does not support this
    return @{

             };
    
}




@end
