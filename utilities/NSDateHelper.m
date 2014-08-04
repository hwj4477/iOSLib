//
//  NSDateHelper.m
//
//  Created by hwj4477 on 2014. 3. 10..
//

#import "NSDateHelper.h"

@implementation NSDateHelper

+ (NSString*)getStringWithFormat:(NSString*)format;
{
    NSDateFormatter *dateFommatter = [[NSDateFormatter alloc] init];
    [dateFommatter setDateFormat:format];
    
    NSString *strResult = [dateFommatter stringFromDate:[NSDate date]];
    
    return strResult;
}

+ (NSInteger)daysBetweenFromDate:(NSDate*)fromDate ToDate:(NSDate*)toDate
{
    NSDate *startDate = fromDate;
	NSDate *endDate = toDate;
	NSCalendar *gregorian = [[NSCalendar alloc]
							 initWithCalendarIdentifier:NSGregorianCalendar];
	unsigned int unitFlags = NSDayCalendarUnit;
	NSDateComponents *components = [gregorian components:unitFlags
												fromDate:startDate
												  toDate:endDate options:0];
	int days = [components day];
	return days;
}

@end
