//
//  MarkCell.h
//  MarkBook
//
//  Created by lk on 13-11-10.
//  Copyright (c) 2013年 kelvin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarkCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *btitle;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *pageNum;
@property (weak, nonatomic) IBOutlet UIImageView *img;

@end
