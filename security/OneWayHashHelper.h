//
//  OneWayHashHelper.h
//
//  Created by Woojeong Hong on 2014. 1. 15..
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface OneWayHashHelper : NSObject

+ (NSString*) sha1:(NSString*)input;

+ (NSString *) md5:(NSString *) input;

@end
