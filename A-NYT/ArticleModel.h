//
//  ArticleModel.h
//  A-NYT
//
//  Created by Allan Zhang on 2/9/17.
//  Copyright © 2017 Allan Zhang. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ArticleModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *abstract;
@property (nonatomic, copy) NSString *articleTitle;



@end
