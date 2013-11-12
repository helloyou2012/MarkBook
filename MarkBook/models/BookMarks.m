//
//  BookMarks.m
//  MarkBook
//
//  Created by ZhenzhenXu on 11/10/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import "BookMarks.h"
#import "Book.h"


@implementation BookMarks

@dynamic latitude;
@dynamic longitude;
@dynamic marktime;
@dynamic mid;
@dynamic page;
@dynamic photo;
@dynamic book;

-(BOOL)setDataFromBookMarks:(BookMarks *)bookMark{
    self.latitude = bookMark.latitude;
    self.longitude = bookMark.longitude;
    self.marktime = bookMark.marktime;
    self.mid = bookMark.mid;
    self.page = bookMark.page;
    self.photo = bookMark.photo;
    self.book = bookMark.book;
    return YES;
}
-(BOOL)setDataWithLatitude:(NSNumber *)lati Longitude:(NSNumber *)longi MarkTime:(NSDate *)t Mid:(NSString *)mid Page:(NSNumber *)page Photo:(NSData *)p Book:(Book *)b{
    self.latitude = lati;
    self.longitude = longi;
    self.marktime = t;
    self.mid = mid;
    self.page = page;
    self.photo = p;
    self.book = b;
    return YES;
}
@end
