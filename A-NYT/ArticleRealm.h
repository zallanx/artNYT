//
//  ArticleRealm.h
//  A-NYT
//
//  Created by Allan Zhang on 2/9/17.
//  Copyright © 2017 Allan Zhang. All rights reserved.
//

#import <Realm/Realm.h>
#import "ArticleModel.h"

@interface ArticleRealm : RLMObject

// Realm persists articles retrieved from the NYT API. When subsequent API retrivals fail, Realm shows previously loaded articles

@property NSString *leadParagraph;
@property NSString *url;

// Initializes with the `ArticleModel` object, since that is what gets featured and displayed

- (id)initWithModel:(ArticleModel *)articleModel;

@end
