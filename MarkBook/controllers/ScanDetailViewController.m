//
//  ScanDetailViewController.m
//  MarkBook
//
//  Created by ZhenzhenXu on 11/10/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import "ScanDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "Book.h"

@implementation ScanDetailViewController

@synthesize btitle=_btitle;
@synthesize bauthor=_bauthor;
@synthesize bsummary=_bsummary;
@synthesize book=_book;
@synthesize circularProgressView=_circularProgressView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _circularProgressView.max=[[_book pageNum] intValue];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_btitle setText:_book.title];
    [_bauthor setText:_book.author];
    [_bimage setImageWithURL:[NSURL URLWithString:_book.imageLink] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _bsummary.text = _book.summary;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_circularProgressView setProgress:[_book.curPage floatValue] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [segue.destinationViewController setValue:_book forKey:@"book"];
}

@end
