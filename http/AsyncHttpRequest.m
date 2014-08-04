//
//  AsyncHttpRequest.m
//
//  Created by hwj4477 on 2014. 3. 26..
//

#import "AsyncHttpRequest.h"

@implementation AsyncHttpRequest

+ (id)request:(NSString *)requestUrl
   parameters:(NSDictionary*)parameters
       header:(NSDictionary*)header
completeBlock:(completeBlock_t)completeBlock
   errorBlock:(errorBlock_t)errorBlock
{
    return [[[self alloc] initWithRequest:requestUrl
                               parameters:parameters
                                   header:header
                            completeBlock:completeBlock
                               errorBlock:errorBlock] autorelease];
}

- (id)initWithRequest:(NSString *)requestUrl
           parameters:(NSDictionary*)parameters
               header:(NSDictionary*)header
        completeBlock:(completeBlock_t)completeBlock
           errorBlock:(errorBlock_t)errorBlock
{
    if ((self=[super init]))
    {
        receivedData = [[NSMutableData alloc] init];
        completeBlock_ = completeBlock;
        errorBlock_ = errorBlock;
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestUrl]
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:TIMEOUT_INTERVAL];
        
        [request setHTTPMethod:@"POST"];
        
        if(parameters)
        {
            NSMutableArray *parts = [NSMutableArray array];
            NSString *part;
            id key;
            id value;
            
            for(key in parameters)
            {
                value = [parameters objectForKey:key];
                part = [NSString stringWithFormat:@"%@=%@", [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                        [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                [parts addObject:part];
            }
            
            [request setHTTPBody:[[parts componentsJoinedByString:@"&"] dataUsingEncoding:NSUTF8StringEncoding]];
        }
        
        if(header)
        {
            for(NSString* key in [header allKeys])
            {
                [request addValue:[header valueForKey:key] forHTTPHeaderField:key];
            }
        }
        
        [NSURLConnection connectionWithRequest:request delegate:self];
    }
    
    return self;
}

- (void)dealloc
{
    [receivedData release];
    
    [super dealloc];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    NSString *resultString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    
    completeBlock_(resultString);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    errorBlock_([error localizedDescription]);
}

@end