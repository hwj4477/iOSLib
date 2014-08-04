//
//  HTTPRequest.m
//
//  Created hwj4477 on 2014. 1. 14..
//
//  Last Update 2014. 3. 26..
//

#import "HTTPRequest.h"

@implementation HTTPRequest

@synthesize delegate;

- (id)init
{
    if((self = [super init]))
    {
        receivedData = [[NSMutableData alloc] init];
        target = nil;
        selector = nil;
    }
    
    return self;
}

- (BOOL)getRequestUrl:(NSString*)url
           parameters:(NSDictionary*)parameters
               header:(NSDictionary*)header
             delegate:(id)aTarget
             selector:(SEL)aSelecter
{
    target = aTarget;
    selector = aSelecter;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:TIMEOUT_INTERVAL];
    
    [request setHTTPMethod:@"GET"];
    
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
    
    NSURLConnection *connection = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
    
    if(connection)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (BOOL)postRequestUrl:(NSString*)url
           parameters:(NSDictionary*)parameters
               header:(NSDictionary*)header
             delegate:(id)aTarget
             selector:(SEL)aSelecter
{
    target = aTarget;
    selector = aSelecter;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
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
    
    NSURLConnection *connection = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
    
    if(connection)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark - URLConnection Delegate.

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)aResponse
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    DebugLog(@"error : %@", [error localizedDescription]);
    
    [self.delegate didFailWithError:[error localizedDescription]];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    NSString *resultString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    
    if(target)
    {
        [target performSelector:selector withObject:resultString];
    }
}

- (void)dealloc
{
    [receivedData release];
    [super dealloc];
}

@end