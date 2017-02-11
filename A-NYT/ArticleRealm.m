//
//  ArticleRealm.m
//  A-NYT
//
//  Created by Allan Zhang on 2/9/17.
//  Copyright © 2017 Allan Zhang. All rights reserved.
//

#import "ArticleRealm.h"

@implementation ArticleRealm

- (id)initWithModel:(ArticleModel *)articleModel{
    self = [super init];
    if(!self) return nil;
    
    self.leadParagraph = articleModel.leadParagraph;
    self.url = articleModel.url;
    
    return self;
}

@end
