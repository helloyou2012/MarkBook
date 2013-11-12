//
//  HomeViewController.m
//  MarkBook
//
//  Created by ZhenzhenXu on 11/10/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//
#define SUPPOSE_HEIGHT 340
#import "HomeViewController.h"
#import "MultiFormatReader.h"

@implementation HomeViewController

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
	// Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    
    [UIView animateWithDuration:1 animations:^{
        CGRect frame = self.backView.frame;
        frame.size.height = SUPPOSE_HEIGHT;
        //        frame.size = CGSizeMake(frame.size.width, SUPPOSE_HEIGHT);
        [self.backView setFrame:frame];
        [self.booklist setAlpha:1];
        [self.bookIcon setAlpha:1];
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.booklist setAlpha:0];
    [self.bookIcon setAlpha:0];
    [self.backView setFrame:CGRectMake(0, 0, 320, 570)];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
