//
//  HTTPRequest.h
//
//  Created by hwj4477 on 2014. 1. 14..
//
//  Last Update 2014. 3. 26..
//

#import <Foundation/Foundation.h>

#define TIMEOUT_INTERVAL 10.0

@protocol HTTPRequestDelegate;

@interface HTTPRequest : NSObject
{
    NSMutableData *receivedData;
    id target;
    SEL selector;
}

- (BOOL)getRequestUrl:(NSString*)url
           parameters:(NSDictionary*)parameters
               header:(NSDictionary*)header
             delegate:(id)aTarget
             selector:(SEL)aSelecter;

- (BOOL)postRequestUrl:(NSString*)url
            parameters:(NSDictionary*)parameters
                header:(NSDictionary*)header
              delegate:(id)aTarget
              selector:(SEL)aSelecter;

@property (nonatomic, assign) id<HTTPRequestDelegate> delegate;

@end

@protocol HTTPRequestDelegate

- (void)didFailWithError:(NSString*)error;

@end