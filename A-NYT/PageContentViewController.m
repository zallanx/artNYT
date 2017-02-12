//
//  PageContentViewController.m
//  A-NYT
//
//  Created by Allan Zhang on 2/11/17.
//  Copyright © 2017 Allan Zhang. All rights reserved.
//

#import "PageContentViewController.h"

@interface PageContentViewController ()

@end

@implementation PageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 120)];
    testLabel.text = self.article.articleTitle;
    testLabel.textColor = [UIColor blueColor];
    testLabel.textAlignment = NSTextAlignmentCenter;
    testLabel.center = self.view.center;
    [self.view addSubview:testLabel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
