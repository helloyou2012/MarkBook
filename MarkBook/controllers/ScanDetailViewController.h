//
//  ScanDetailViewController.h
//  MarkBook
//
//  Created by ZhenzhenXu on 11/10/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"

@interface ScanDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *btitle;
@property (weak, nonatomic) IBOutlet UILabel *bauthor;
@property (weak, nonatomic) IBOutlet UILabel *bcurPage;
@property (weak, nonatomic) IBOutlet UIImageView *bimage;
@property (weak, nonatomic) IBOutlet UILabel *bsummary;

@property (nonatomic, retain) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain) Book *book;

@end
