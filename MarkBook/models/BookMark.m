//
//  BookMark.m
//  MarkBook
//
//  Created by lk on 13-11-9.
//  Copyright (c) 2013年 kelvin. All rights reserved.
//

#import "BookMark.h"

@implementation BookMark

-(void)setLocationByLatitude:(double)lati AndLongitude:(double)longit{
    latitude = [NSString stringWithFormat:@"%f",lati];
    longitude = [NSString stringWithFormat:@"%f",longit];
}
-(double)Latitude{
    double d = [latitude doubleValue];
    return d;
}
-(double)Longitude{
    return [longitude doubleValue];
}

-(NSDictionary *)BookMarkToDictionary{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (latitude && ![latitude isEqualToString:@""])
        [dict setValue:latitude forKey:LATITUDE];
    if (longitude && ![longitude isEqualToString:@""])
        [dict setValue:longitude forKey:LONGITUDE];
    if (self.pageNum && ![self.pageNum isEqualToString:@""])
        [dict setValue:self.pageNum forKey:PageNum];
    if (self.ISBN && ![self.ISBN isEqualToString:@""])
        [dict setValue:self.ISBN forKey:ISBN_KEY];
    if (self.time && ![self.time isEqualToString:@""])
        [dict setValue:self.time forKey:Time];
    if (self.bookTitle && ![self.bookTitle isEqualToString:@""])
        [dict setValue:self.bookTitle forKey:BookTitle];
    if (self.imgPath && ![self.imgPath isEqualToString:@""])
    [dict setValue:self.imgPath forKey:ImgPath];
    return dict;
}
+(BookMark *)bookmarkFromDictionary:(NSDictionary *)dict{
    BookMark *bm = [[BookMark alloc] init];
    [bm setLocationByLatitude:[[dict valueForKey:LATITUDE]doubleValue] AndLongitude:[[dict valueForKey:LATITUDE]doubleValue]];
    [bm setPageNum:[dict valueForKey:PageNum]];
    [bm setISBN:[dict valueForKey:ISBN_KEY]];
    [bm setTime:[dict valueForKey:Time]];
    [bm setBookTitle:[dict valueForKey:BookTitle]];
    [bm setImgPath:[dict valueForKey:ImgPath]];
    return bm;
}
@end
