//
//  ScanDetailViewController.m
//  MarkBook
//
//  Created by ZhenzhenXu on 11/10/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import "ScanDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"

@implementation ScanDetailViewController

@synthesize btitle=_btitle;
@synthesize bauthor=_bauthor;
@synthesize bcurPage=_bcurPage;
@synthesize bsummary=_bsummary;
@synthesize managedObjectContext=_managedObjectContext;
@synthesize book=_book;

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
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _managedObjectContext=[appDelegate managedObjectContext];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_btitle setText:_book.title];
    [_bauthor setText:_book.author];
    [_bimage setImageWithURL:[NSURL URLWithString:_book.imageLink] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    _bsummary.text = _book.summary;
    _bsummary.numberOfLines = 0; //will wrap text in new line
    [_bsummary sizeToFit];
    
    CGRect rect=_bcurPage.frame;
    rect.origin.y=_bsummary.frame.origin.y+_bsummary.frame.size.height+250;
    [_bcurPage setFrame:rect];
    [_bcurPage setText:@"0"];
    [_bcurPage setText:[NSString stringWithFormat:@"%@", _book.curPage]];
    _bcurPage.numberOfLines = 0; //will wrap text in new line
    [_bcurPage sizeToFit];
    
    
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
