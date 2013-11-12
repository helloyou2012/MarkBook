//
//  ScanCodeViewController.m
//  MarkBook
//
//  Created by ZhenzhenXu on 11/10/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import "ScanCodeViewController.h"
#import "MultiFormatReader.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"

@implementation ScanCodeViewController

@synthesize managedObjectContext=_managedObjectContext;
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
        NSError *saveError = nil;
        _cur_book=[NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:_managedObjectContext];
        [_cur_book setData:data];
        [_managedObjectContext save:&saveError];
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
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        _managedObjectContext=[appDelegate managedObjectContext];
        
        //首先查询coredata中是否存在数据
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Book" inManagedObjectContext:_managedObjectContext];
        //按照isbn获取
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
        [fetchRequest setEntity:entityDescription];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(isbn = %@)", result_];
        [fetchRequest setPredicate:predicate];
        
        NSError *error = nil;
        NSArray *itemsArray = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
        //如果获取到的数组元素个数为0，则说明coredata中还没有数据，这时需要下载数据。
        if ([itemsArray count] == 0) {
            _connection=[[DoubanBookConnection alloc] initWithParam:result_];
            _connection.delegate=self;
            [_connection createConnection];
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
        }else{
            _cur_book=[itemsArray objectAtIndex:0];
            [self performSegueWithIdentifier:@"gotoAddMark" sender:self];
        }
    }
    //[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
