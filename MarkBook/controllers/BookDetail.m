    //
//  BookDetail.m
//  MarkBook
//
//  Created by lk on 13-11-9.
//  Copyright (c) 2013年 kelvin. All rights reserved.
//

#import "BookDetail.h"
#import "Book.h"
#import "UIImageView+WebCache.h"
#import "AddMarkViewController.h"

@implementation BookDetail
-(void)viewDidLoad{
    [super viewDidLoad];
    NSURL *imgLink = [NSURL URLWithString:self.book.imageLink];
    [self.img setImageWithURL:imgLink placeholderImage:[UIImage imageNamed:@"placeholder"]];
    [self.btitle setText:self.book.title];
    
    [self.summary setText:self.book.summary];
    
    NSString *o =[NSString stringWithFormat:@"作者：%@\n价格：%@\n评分：%@\n评分人数：%@",self.book.author,self.book.price,self.book.rate,self.book.numRater];
    [self.other setText:o];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"GoAddMark"]) {
        AddMarkViewController *add = segue.destinationViewController;
        [add setBook:self.book];
        return;
    }
    DetailWebPage *dwp = (DetailWebPage *)segue.destinationViewController;
    [dwp setUrl:[NSURL URLWithString:self.book.detailLink]];
}
@end
