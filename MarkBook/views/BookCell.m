//
//  BookCell.m
//  MarkBook
//
//  Created by lk on 13-11-10.
//  Copyright (c) 2013年 kelvin. All rights reserved.
//

#import "BookCell.h"

@implementation BookCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
