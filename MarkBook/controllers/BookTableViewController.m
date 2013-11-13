//
//  BookTableViewController.m
//  MarkBook
//
//  Created by ZhenzhenXu on 11/9/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import "BookTableViewController.h"
#import "Book.h"
#import "BookMarks.h"
#import "BookCell.h"
#import "UIImageView+WebCache.h"
#import "CoreDataEnvir.h"



@implementation BookTableViewController

@synthesize selectedIndex=_selectedIndex;
@synthesize books=_books;

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"addDate" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
	
	NSMutableArray *sortedBooks = [[NSMutableArray alloc] initWithArray:[Book items]];
	[sortedBooks sortUsingDescriptors:sortDescriptors];
	self.books = sortedBooks;
    
    [self.tableView reloadData];
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
    return [_books count];
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
    Book *book = [_books objectAtIndex:indexPath.row];
    [cell.btitle setText:book.title];
    [cell.bauthor setText:book.author];
    [cell.bcurPage setText:[NSString stringWithFormat:@"已读到第 %@ 页", book.curPage]];
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // Only allow deletion, and only in the ingredients section
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the managed object for the given index path
        Book *book=[_books objectAtIndex:indexPath.row];
        [book remove];
        [[CoreDataEnvir mainInstance] saveDataBase];
        [_books removeObject:book];
        [self.tableView reloadData];
	}
}

#pragma mark -
#pragma mark Moving rows

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (IBAction)backPressed:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if (![segue.identifier isEqualToString:@"gotoScan"]) {
        Book *book=[_books objectAtIndex:_selectedIndex.row];
        [segue.destinationViewController setValue:book forKey:@"book"];
    }
}

@end
