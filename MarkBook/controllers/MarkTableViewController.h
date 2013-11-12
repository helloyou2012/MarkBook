//
//  MarkTableViewController.h
//  MarkBook
//
//  Created by ZhenzhenXu on 11/10/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarkTableViewController : UITableViewController<NSFetchedResultsControllerDelegate>

@property (nonatomic, retain) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSIndexPath *selectedIndex;

@end
