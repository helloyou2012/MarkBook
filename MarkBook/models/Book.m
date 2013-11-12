//
//  Book.m
//  MarkBook
//
//  Created by ZhenzhenXu on 11/10/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import "Book.h"

#define TITLE @"title"
#define IMG @"image"
#define MOBILE  @"mobile"
#define AUTHOR @"author"
#define SUMMARY @"summary"
#define LINK @"link"

@implementation Book

@dynamic author;
@dynamic bid;
@dynamic detailLink;
@dynamic imageLink;
@dynamic isbn;
@dynamic numRater;
@dynamic pageNum;
@dynamic price;
@dynamic rate;
@dynamic summary;
@dynamic title;
@dynamic curPage;
@dynamic addDate;



- (void)setData:(NSDictionary*)bookDict{
    [self setTitle:[bookDict objectForKey:TITLE]];
    [self setImageLink:[bookDict objectForKey:IMG]];
    [self setIsbn:[bookDict objectForKey:@"isbn13"]];
    [self setBid:[bookDict objectForKey:@"id"]];
    NSArray *authors = [bookDict objectForKey:AUTHOR];
    
    NSMutableString *temp = [NSMutableString stringWithString:@""];
    for (NSUInteger i =0; i<authors.count; i++) {
        [temp appendString:[authors objectAtIndex:i]];
    }
    [self setAuthor:temp];
    
    [self setSummary:[bookDict objectForKey:SUMMARY]];
    [self setPrice:[bookDict objectForKey:@"price"]];
    NSString *pageNum = [bookDict objectForKey:@"pages"];
    
    [self setPageNum:[NSNumber numberWithInt:pageNum.integerValue]];
    NSDictionary *rating = [bookDict objectForKey:@"rating"];
    pageNum = [rating objectForKey:@"numRaters"];
    [self setNumRater:[NSNumber numberWithInteger:pageNum.intValue]];
    [self setRate:[NSNumber numberWithDouble:[[rating objectForKey:@"average"] doubleValue]]];
    [self setDetailLink:[bookDict objectForKey:@"alt"]];
    [self setCurPage:[NSNumber numberWithInt:0]];
    
    [self setAddDate:[NSDate date]];
}

@end
