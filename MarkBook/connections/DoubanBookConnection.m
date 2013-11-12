//
//  DoubanBookConnection.m
//  MarkBook
//
//  Created by ZhenzhenXu on 11/10/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import "DoubanBookConnection.h"

@implementation DoubanBookConnection

@synthesize receivedData=_receivedData;
@synthesize requestData=_requestData;
@synthesize delegate=_delegate;
@synthesize connection=_connection;

- (id)initWithParam:(NSString*)data{
    if (self=[super init]) {
        _requestData=data;
    }
    return self;
}

- (void)createConnection{
    // Create the request.
    NSString *isbnURl = [NSString stringWithFormat:@"https://api.douban.com/v2/book/isbn/%@",_requestData];
    NSURL *url=[NSURL URLWithString:isbnURl];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    
    [request setTimeoutInterval:30.0f];
    [request setHTTPMethod:@"GET"];
    // create the connection with the request
    // and start loading the data
    
    _connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (_connection) {
        // Create the NSMutableData to hold the received data.
        _receivedData = [NSMutableData data];
        
    } else {
        // Inform the user that the connection failed.
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse.
    [_receivedData setLength:0];
    NSInteger statusCode = [((NSHTTPURLResponse *)response) statusCode];
    if (statusCode > 400)
    {
        [connection cancel];  // stop connecting; no more delegate messages
        [_delegate doubanRequestFinished:nil withError:@"网络连接失败！"];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    [_receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [_delegate doubanRequestFinished:nil withError:@"加载失败！"];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"Hello world");
    // do something with the data
    NSError *jsonError = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:_receivedData options:NSJSONReadingMutableContainers error:&jsonError];
    NSLog(@"%@", json);
    if(json!=nil) {
        if ([json objectForKey:@"msg"]) {
            [_delegate doubanRequestFinished:nil withError:@"未查询到数据！"];
        }else{
            [_delegate doubanRequestFinished:json withError:nil];
        }
        
    }else{
        [_delegate doubanRequestFinished:nil withError:@"没有数据！"];
    }
}
@end
