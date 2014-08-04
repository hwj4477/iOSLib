//
//  TouchScrollView.m
//
//  Created by hwj4477 on 12. 7. 25..
//

#import "TouchScrollView.h"

@implementation TouchScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.superview touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.superview touchesMoved:touches withEvent:event];
}

- (void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event 
{	
    [self.superview touchesEnded:touches withEvent:event];
}

@end
