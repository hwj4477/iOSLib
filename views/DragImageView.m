//
//  DragImageView.m
//
//  Created by hwj4477 on 2014. 1. 24..
//

#import "DragImageView.h"

@implementation DragImageView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(id)initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
	if ( self )
    {
        self.userInteractionEnabled = YES;
    }
	return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        self.userInteractionEnabled = YES;
    }
    return self;
}

#pragma mark - Touch Event.

-(void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
	point = [[touches anyObject] locationInView:self];
    [self.superview bringSubviewToFront:self];
}

-(void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
	CGPoint touchedPoints = [[touches anyObject] locationInView:self];
	CGPoint newPoints     = CGPointMake(self.center.x + (touchedPoints.x - point.x),
                                         self.center.y + (touchedPoints.y - point.y));
    CGFloat midX = CGRectGetMidX(self.bounds);
	CGFloat midY = CGRectGetMidY(self.bounds);
    CGSize superviewSize = self.superview.bounds.size;

    if (newPoints.x > superviewSize.width  - midX)
    {
        newPoints.x = superviewSize.width - midX;
    }
    else if (newPoints.x < midX)
    {
        newPoints.x = midX;
    }
    
	if (newPoints.y > superviewSize.height  - midY)
    {
        newPoints.y = superviewSize.height - midY;
    }
    else if (newPoints.y < midY)
    {
        newPoints.y = midY;
    }
	
	self.center = newPoints;
}

@end
