//
//  ScanCodeViewController.m
//  MarkBook
//
//  Created by ZhenzhenXu on 11/10/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import "ScanCodeViewController.h"
#import "MultiFormatReader.h"
#import "SVProgressHUD.h"
#import "CoreDataEnvir.h"
#import "Book.h"

@implementation ScanCodeViewController

@synthesize connection=_connection;
@synthesize cur_book=_cur_book;

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
    [self resetViewsWithDelegate:self showCancel:YES OneDMode:NO];
    
    
    self.readers = [[NSMutableSet alloc ] init];
    MultiFormatReader* reader = [[MultiFormatReader alloc] init];
    [(NSMutableSet*)self.readers addObject:reader];
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    self.soundToPlay =
    [NSURL fileURLWithPath:[mainBundle pathForResource:@"beep-beep" ofType:@"aiff"] isDirectory:NO];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doubanRequestFinished:(NSDictionary *)data withError:(NSString *)error{
    if (error) {
        [SVProgressHUD showErrorWithStatus:error];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [SVProgressHUD dismiss];
        _cur_book = [Book insertItem];
        [_cur_book setData:data];
        [_cur_book save];
        [self performSegueWithIdentifier:@"gotoAddMark" sender:self];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [segue.destinationViewController setValue:_cur_book forKey:@"book"];
}

#pragma mark -
#pragma mark ZXingDelegateMethods

- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result_ {
    
    if (self.isViewLoaded) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(isbn = %@)", result_];
        _cur_book=[Book lastItemWithPredicate:predicate];
        if (_cur_book) {
            [self performSegueWithIdentifier:@"gotoAddMark" sender:self];
        }else{
            _connection=[[DoubanBookConnection alloc] initWithParam:result_];
            _connection.delegate=self;
            [_connection createConnection];
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
        }
    }
}

- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
