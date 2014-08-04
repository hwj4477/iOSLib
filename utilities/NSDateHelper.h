//
//  NSDateHelper.h
//
//  Created by hwj4477 on 2014. 3. 10..
//

#import <Foundation/Foundation.h>

@interface NSDateHelper : NSObject

+ (NSString*)getStringWithFormat:(NSString*)format;

+ (NSInteger)daysBetweenFromDate:(NSDate*)fromDate ToDate:(NSDate*)toDate;

@end
