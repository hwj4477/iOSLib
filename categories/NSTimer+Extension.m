//
//  NSTimer+Extension.m
//
//  Created by hwj4477 on 13. 2. 15..
//

#import "NSTimer+Extension.h"

@implementation NSTimer (Extension)
NSDate *pauseStart, *previousFireDate;
-(void)pauseTimer{
    pauseStart = [[NSDate dateWithTimeIntervalSinceNow:0] retain];
    
    previousFireDate = [[self fireDate] retain];
    
    [self setFireDate:[NSDate distantFuture]];
}
-(void)resumeTimer{
    float pauseTime = -1*[pauseStart timeIntervalSinceNow];
    
    [self setFireDate:[previousFireDate initWithTimeInterval:pauseTime sinceDate:previousFireDate]];
    
    [pauseStart release];
    
    [previousFireDate release];
    
}
@end
