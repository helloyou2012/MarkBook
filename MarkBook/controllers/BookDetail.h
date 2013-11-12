//
//  BookDetail.h
//  MarkBook
//
//  Created by lk on 13-11-9.
//  Copyright (c) 2013年 kelvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"
#import "DetailWebPage.h"

@interface BookDetail : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *btitle;

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (nonatomic,retain) NSString *ISBN;
@property (weak, nonatomic) IBOutlet UILabel *other;
@property (weak, nonatomic) IBOutlet UITextView *summary;
@property (nonatomic,retain) Book *book;
@end
