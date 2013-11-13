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

@class CoreDataEnvir;
@class Book;


@interface BookTableViewController : UITableViewController

@property (nonatomic, strong) NSIndexPath *selectedIndex;

- (IBAction)backPressed:(id)sender;

@end
