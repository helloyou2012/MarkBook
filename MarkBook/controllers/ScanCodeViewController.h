//
//  ScanCodeViewController.h
//  MarkBook
//
//  Created by ZhenzhenXu on 11/10/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXingWidgetController.h"
#import "DoubanBookConnection.h"
#import "Book.h"

@interface ScanCodeViewController : ZXingWidgetController<ZXingDelegate, DoubanBookConnectionDelegage>

@property (nonatomic, strong) DoubanBookConnection *connection;
@property (nonatomic, retain) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain) Book *cur_book;
@end
