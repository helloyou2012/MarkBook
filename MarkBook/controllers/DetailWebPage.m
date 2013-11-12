//
//  DetailWebPage.m
//  MarkBook
//
//  Created by lk on 13-11-9.
//  Copyright (c) 2013年 kelvin. All rights reserved.
//

#import "DetailWebPage.h"

@implementation DetailWebPage
-(void)viewDidLoad{
    [super viewDidLoad];
    [self.webPage loadRequest:[NSURLRequest requestWithURL:self.url]];
}
@end
