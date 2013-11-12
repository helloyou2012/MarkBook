//
//  DoubanBookConnection.h
//  MarkBook
//
//  Created by ZhenzhenXu on 11/10/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>

@protocol DoubanBookConnectionDelegage

-(void) doubanRequestFinished:(NSDictionary*)data withError:(NSString*)error;

@end

@interface DoubanBookConnection : NSObject

@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, strong) NSString *requestData;
@property (nonatomic, retain) id<DoubanBookConnectionDelegage> delegate;
@property (nonatomic, strong) NSURLConnection *connection;

- (id)initWithParam:(NSString*)data;
- (void)createConnection;

@end
