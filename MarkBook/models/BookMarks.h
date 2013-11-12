//
//  BookMarks.h
//  MarkBook
//
//  Created by ZhenzhenXu on 11/10/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Book;

@interface BookMarks : NSManagedObject

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSDate * marktime;
@property (nonatomic, retain) NSString * mid;
@property (nonatomic, retain) NSNumber * page;
@property (nonatomic, retain) NSData * photo;
@property (nonatomic, retain) Book *book;

-(BOOL)setDataFromBookMarks:(BookMarks *)bookMark;
-(BOOL)setDataWithLatitude:(NSNumber *)lati Longitude:(NSNumber *)longi MarkTime:(NSDate *)t Mid:(NSString *)mid Page:(NSNumber *)page Photo:(NSData *)p Book:(Book *)b;
@end
