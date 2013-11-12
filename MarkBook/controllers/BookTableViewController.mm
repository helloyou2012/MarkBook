//
//  BookTableViewController.m
//  MarkBook
//
//  Created by ZhenzhenXu on 11/9/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import "BookTableViewController.h"
#import "MultiFormatReader.h"
#import "Book.h"
#import "BookMarks.h"
#import "BookCell.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
#import "BookDetail.h"


@implementation BookTableViewController

@synthesize managedObjectContext=_managedObjectContext;
@synthesize fetchedResultsController=_fetchedResultsController;
@synthesize selectedIndex=_selectedIndex;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _managedObjectContext=[appDelegate managedObjectContext];
    
    NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	}

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id  sectionInfo =
    [[_fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110.0f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"BookCell";
    
    BookCell *cell = (BookCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[BookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(BookCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Book *book = [_fetchedResultsController objectAtIndexPath:indexPath];
    [cell.btitle setText:book.title];
    [cell.bauthor setText:book.author];
    [cell.bcurPage setText:[NSString stringWithFormat:@"已读到%@页", book.curPage]];
    [cell.bimage setImageWithURL:[NSURL URLWithString:book.imageLink] placeholderImage:[UIImage imageNamed:@"placeholder"]];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //selected
    _selectedIndex=indexPath;
    [self performSegueWithIdentifier:TO_BOOK_MARK_LIST sender:nil];
}
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    _selectedIndex = indexPath;
    [self performSegueWithIdentifier:TO_BOOK_DETAIL sender:nil];
}

#pragma mark FetchResultController

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Book" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"addDate" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    [fetchRequest setFetchBatchSize:20];
    
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:_managedObjectContext sectionNameKeyPath:nil
                                                   cacheName:@"Root"];
    self.fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
    
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
            [self configureCell:(BookCell*)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}

- (IBAction)backPressed:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addBookPressed:(id)sender{
	
    ZXingWidgetController *widController =
    [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO];
    
    NSMutableSet *readers = [[NSMutableSet alloc ] init];
    MultiFormatReader* reader = [[MultiFormatReader alloc] init];
    [readers addObject:reader];
    widController.readers = readers;
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    widController.soundToPlay =
    [NSURL fileURLWithPath:[mainBundle pathForResource:@"beep-beep" ofType:@"aiff"] isDirectory:NO];
    
    //[self presentModalViewController:widController animated:YES];
    [self presentViewController:widController animated:YES completion:nil];
}

#pragma mark -
#pragma mark ZXingDelegateMethods

- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result {
    
    if (self.isViewLoaded) {
        self.title=result;
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    Book *book=[_fetchedResultsController objectAtIndexPath:_selectedIndex];
    if ([segue.identifier isEqualToString:TO_BOOK_DETAIL]) {
        BookDetail *bd =(BookDetail *)segue.destinationViewController;
        [bd setBook:book];
    }else if([segue.identifier isEqualToString:TO_BOOK_MARK_LIST]){
        
    }
}

@end
