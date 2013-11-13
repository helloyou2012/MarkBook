//
//  MarkTableViewController.m
//  MarkBook
//
//  Created by ZhenzhenXu on 11/10/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import "MarkTableViewController.h"
#import "MarkCell.h"
#import "BookMarks.h"
#import "UIImageView+WebCache.h"
#import "CoreDataEnvir.h"

@implementation MarkTableViewController

@synthesize book=_book;
@synthesize bookMarks=_bookMarks;

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
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                              initWithKey:@"marktime" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
	
	NSMutableArray *sortedIngredients = [[NSMutableArray alloc] initWithArray:[_book.marks allObjects]];
	[sortedIngredients sortUsingDescriptors:sortDescriptors];
	self.bookMarks = sortedIngredients;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem.title=@"编辑";
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
    return _bookMarks.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"MarkCell";
    
    MarkCell *cell = (MarkCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MarkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(MarkCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    BookMarks *mark = [_bookMarks objectAtIndex:indexPath.row];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [cell.time setText:[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:mark.marktime]]];
    
    [cell.pageNum setText:[NSString stringWithFormat:@"第 %@ 页", mark.page]];
    if (mark.photo) {
        [cell.img setImage:[UIImage imageWithData:mark.photo]];
    }else{
        //[cell.img setImage:[UIImage imageNamed:@"placeholder"]];
        [cell.img setBackgroundColor:[UIColor colorWithRed:0.153 green:0.682 blue:0.376 alpha:1.0]];
    }
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // Only allow deletion, and only in the ingredients section
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Remove the corresponding ingredient object from the recipe's ingredient list and delete the appropriate table view cell.
        BookMarks *mark = [_bookMarks objectAtIndex:indexPath.row];
        [mark remove];
        [_book removeMarksObject:mark];
        [[CoreDataEnvir mainInstance] saveDataBase];
        [_bookMarks removeObject:mark];
        
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }
}

#pragma mark -
#pragma mark Moving rows

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark -
#pragma mark Editing

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    [super setEditing:editing animated:animated];
	[self.navigationItem setHidesBackButton:editing animated:YES];
    
    if (editing) {
        self.navigationItem.rightBarButtonItem.title=@"完成";
    }else{
        self.navigationItem.rightBarButtonItem.title=@"编辑";
    }
}

@end
