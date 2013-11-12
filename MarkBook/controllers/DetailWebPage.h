//
//  DetailWebPage.h
//  MarkBook
//
//  Created by lk on 13-11-9.
//  Copyright (c) 2013年 kelvin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailWebPage : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webPage;
@property (nonatomic,strong) NSURL *url;

@end
