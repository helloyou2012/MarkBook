//
//  Book.h
//  MarkBook
//
//  Created by ZhenzhenXu on 11/10/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Book : NSManagedObject

@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSString * bid;
@property (nonatomic, retain) NSString * detailLink;
@property (nonatomic, retain) NSString * imageLink;
@property (nonatomic, retain) NSString * isbn;
@property (nonatomic, retain) NSNumber * numRater;
@property (nonatomic, retain) NSNumber * pageNum;
@property (nonatomic, retain) NSString * price;
@property (nonatomic, retain) NSNumber * rate;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * curPage;
@property (nonatomic, retain) NSDate * addDate;

- (void)setData:(NSDictionary*)bookDict;

@end
