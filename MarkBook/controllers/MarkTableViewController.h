//
//  MarkTableViewController.h
//  MarkBook
//
//  Created by ZhenzhenXu on 11/10/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"

@interface MarkTableViewController : UITableViewController

@property (nonatomic, retain) Book *book;
@property (nonatomic, retain) NSMutableArray *bookMarks;

@end
