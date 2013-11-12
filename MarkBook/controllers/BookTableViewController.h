//
//  BookTableViewController.h
//  MarkBook
//
//  Created by ZhenzhenXu on 11/9/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//
#define TO_BOOK_MARK_LIST @"ToBookMarkList"
#define TO_BOOK_DETAIL @"ToBookDetail"

#import <UIKit/UIKit.h>

#import "ZXingWidgetController.h"


@interface BookTableViewController : UITableViewController<NSFetchedResultsControllerDelegate,ZXingDelegate>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *addBookButton;

@property (nonatomic, retain) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSIndexPath *selectedIndex;

- (IBAction)addBookPressed:(id)sender;
- (IBAction)backPressed:(id)sender;

@end
