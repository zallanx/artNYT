//
//  PageContentViewController.m
//  A-NYT
//
//  Created by Allan Zhang on 2/11/17.
//  Copyright © 2017 Allan Zhang. All rights reserved.
//

#import "PageContentViewController.h"
#import "UIImageView+AFNetworking.h"


@interface PageContentViewController ()
{
    int assetBuffer;
}

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *bodyLabel;
@property (strong, nonatomic) UIButton *readMoreButton;
@property (strong, nonatomic) UIImageView *headerImageView;


@end

@implementation PageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self placeTextContentOnScreen];
    
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.view addSubview:self.headerImageView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self assetsDownloader];
    
}


- (void)placeTextContentOnScreen
{
    DesignElements *designDictionary = [[DesignElements alloc] init];
    self.view.backgroundColor = designDictionary.backgroundColor;
    
    
    self.titleLabel = [[UILabel alloc] init];
    NSString *displayTitle = [self.article.articleTitle stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    self.titleLabel.text = displayTitle.uppercaseString;
    self.titleLabel.textColor = [designDictionary.titleTextAttributes objectForKey:@"textColor"];
    self.titleLabel.font = [designDictionary.titleTextAttributes objectForKey:@"font"];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.frame = CGRectMake(0, 0, self.view.frame.size.width*0.80, self.titleLabel.intrinsicContentSize.height);
    self.titleLabel.center = self.view.center;
    [self.titleLabel sizeToFit];
    [self.view addSubview:self.titleLabel];
    
    assetBuffer = 20;
    
    self.bodyLabel = [[UILabel alloc] init];
    self.bodyLabel.text = self.article.abstract;
    self.bodyLabel.textColor = [designDictionary.bodyTextAttributes objectForKey:@"textColor"];
    self.bodyLabel.font = [designDictionary.bodyTextAttributes objectForKey:@"font"];
    self.bodyLabel.numberOfLines = 0;
    self.bodyLabel.frame = CGRectMake(self.titleLabel.frame.origin.x,
                                      self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + assetBuffer,
                                      self.view.frame.size.width*0.80,
                                      self.bodyLabel .intrinsicContentSize.height);
    [self.bodyLabel  sizeToFit];
    [self.view addSubview:self.bodyLabel ];
    
    
    self.readMoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.readMoreButton addTarget:self action:@selector(tappedOnReadMore:) forControlEvents:UIControlEventTouchUpInside];
    [self.readMoreButton setTitle:@"READ MORE" forState:UIControlStateNormal];
    self.readMoreButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.readMoreButton.titleLabel.font = [designDictionary.buttonTextAttributes objectForKey:@"font"];
    [self.readMoreButton setTitleColor:[designDictionary.buttonTextAttributes objectForKey:@"titleColor"] forState:UIControlStateNormal];
    [self.readMoreButton setTitleColor:[designDictionary.buttonTextAttributes objectForKey:@"highlightColor"] forState:UIControlStateHighlighted];
    
    self.readMoreButton.frame = CGRectMake(self.bodyLabel.frame.origin.x,
                                           self.bodyLabel.frame.origin.y + self.bodyLabel.frame.size.height + assetBuffer,
                                           self.readMoreButton.intrinsicContentSize.width,
                                           self.readMoreButton.intrinsicContentSize.height);
    [self.view addSubview:self.readMoreButton];
    
    //If we are using a placeholder article
    if (!self.article.url){
        self.article.url = @"https://www.google.com/maps/search/new+york+art+museums/";
        [self.readMoreButton setTitle:@"FIND ART" forState:UIControlStateNormal];
    }
    
}


- (void)assetsDownloader {

    if (self.article.mediaArray.count > 0){
        NSArray *mediaMetadata = [[self.article.mediaArray firstObject] objectForKey:@"media-metadata"]; //this is a single object array
        NSDictionary *largestAsset = mediaMetadata.lastObject;
        NSString *largestAssetURL = [largestAsset objectForKey:@"url"];
        [self downloadAssetFromURL:[NSURL URLWithString:largestAssetURL]];
    }
    
}

- (void)downloadAssetFromURL: (NSURL *)assetURL {
    
    NSURLRequest *imageDownloadRequest = [NSURLRequest requestWithURL:assetURL];
    
    __unsafe_unretained typeof(self) weakSelf = self;
    [self.headerImageView setImageWithURLRequest:imageDownloadRequest placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        
        weakSelf.headerImageView.image = image;
        weakSelf.headerImageView.frame = CGRectMake(0, 0, weakSelf.view.frame.size.width, (image.size.height/image.size.width)*weakSelf.view.frame.size.width);
        [weakSelf repositionText];
        
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        
    }];
}

- (void)repositionText {

        self.titleLabel.frame = CGRectMake(self.titleLabel.frame.origin.x,
                                           self.headerImageView.frame.size.height + (assetBuffer*2),
                                           self.titleLabel.frame.size.width,
                                           self.titleLabel.frame.size.height);
        
        self.bodyLabel.frame = CGRectMake(self.titleLabel.frame.origin.x,
                                          self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + assetBuffer,
                                          self.bodyLabel.frame.size.width,
                                          self.bodyLabel.frame.size.height);
        
        self.readMoreButton.frame = CGRectMake(self.bodyLabel.frame.origin.x,
                                               self.bodyLabel.frame.origin.y + self.bodyLabel.frame.size.height + assetBuffer,
                                               self.readMoreButton.frame.size.width,
                                               self.readMoreButton.frame.size.height);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tappedOnReadMore: (id)sender
{
    NSString *articleURL = self.article.url;
    NSURL *url = [NSURL URLWithString:articleURL];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
        
        }];
    }
}



@end
