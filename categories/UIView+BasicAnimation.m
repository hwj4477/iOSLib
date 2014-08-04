//
//  UIView+BasicAnimation.m
//
//  Created by hwj4477 on 12. 5. 11..
//
//  Last Update 12. 11. 7

#import "UIView+BasicAnimation.h"
//#import "FileUtil.h"

@implementation UIView (UIViewBasicAnimation)


- (void)fadeInDuration:(CFTimeInterval)duration
{
	@synchronized(self)
	{
		self.alpha = 0.0;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:duration];   
        [UIView setAnimationDelegate:self];
        self.alpha = 1.0;
        [UIView commitAnimations];	
    }
}

- (void)fadeOutDuration:(CFTimeInterval)duration
{
	@synchronized(self)
	{
		self.alpha = 1.0;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:duration];   
        [UIView setAnimationDelegate:self];
        self.alpha = 0.0;
        [UIView commitAnimations];	
    }
}

- (void)flipFromLeftDuration:(CFTimeInterval)duration
{
    @synchronized(self)
	{
        [UIView beginAnimations:@"flip"
                        context:nil];
        [UIView setAnimationDuration:duration];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft
                               forView:self
                                 cache:YES];
        
        [UIView commitAnimations];
    }
}

- (void)flipFromRightDuration:(CFTimeInterval)duration
{
    @synchronized(self)
	{
        [UIView beginAnimations:@"flip"
                        context:nil];
        [UIView setAnimationDuration:duration];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight
                               forView:self
                                 cache:YES];
        
        [UIView commitAnimations];
    }
}

- (void)curlUpDuration:(CFTimeInterval)duration
{
    @synchronized(self)
	{
        [UIView beginAnimations:@"curl"
                        context:nil];
        [UIView setAnimationDuration:duration];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp
                               forView:self
                                 cache:YES];
        
        [UIView commitAnimations];
    }
}

- (void)curlDownDuration:(CFTimeInterval)duration
{
    @synchronized(self)
	{
        [UIView beginAnimations:@"curl"
                        context:nil];
        [UIView setAnimationDuration:duration];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown
                               forView:self
                                 cache:YES];
        
        [UIView commitAnimations];
    }
}

- (void)pushInAnimationDuration:(CFTimeInterval)duration
{
    @synchronized(self)
    {
        CATransition* pushAnimation = [CATransition animation];
        [pushAnimation setType:kCATransitionPush];
        [pushAnimation setSubtype:kCATransitionFromRight];
        [pushAnimation setDuration:duration];
        [pushAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [[self layer] addAnimation:pushAnimation forKey:nil];
    }
}

- (void)pushOutAnimationDuration:(CFTimeInterval)duration
{
    @synchronized(self)
    {
        CATransition* pushAnimation = [CATransition animation];
        [pushAnimation setType:kCATransitionPush];
        [pushAnimation setSubtype:kCATransitionFromLeft];
        [pushAnimation setDuration:duration];
        [pushAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [[self layer] addAnimation:pushAnimation forKey:nil];
    }
}

- (void)pulseAnimationRepeat:(int)repeat Value:(float)value Reverse:(BOOL)reverse Duration:(CFTimeInterval)duration
{
    @synchronized(self)
	{
		CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        pulseAnimation.duration = duration;
        pulseAnimation.toValue = [NSNumber numberWithFloat:value];
        pulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pulseAnimation.autoreverses = reverse;
        pulseAnimation.repeatCount = repeat;
        [self.layer addAnimation:pulseAnimation forKey:@"pulse"];	
    }
}

- (void)rotationAnimationRepeat:(int)repeat Value:(float)value Reverse:(BOOL)reverse Duration:(CFTimeInterval)duration
{
    @synchronized(self)
	{
        CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        rotation.duration = duration;
        rotation.autoreverses = reverse;
        rotation.fromValue = 0;
        rotation.toValue = [NSNumber numberWithFloat:value];
        rotation.repeatCount = repeat;
        [self.layer addAnimation:rotation forKey:@"rot"];
    }
}

- (void)moveAnimationTo:(CGPoint)toValue Duration:(CFTimeInterval)duration
{
    @synchronized(self)
	{
        CGRect moveRect = CGRectMake(toValue.x, toValue.y, self.frame.size.width, self.frame.size.height);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:duration];   
        [UIView setAnimationDelegate:self];
        [self setFrame:moveRect];
        [UIView commitAnimations];
    }
}

//- (void)imageAnimationFileName:(NSString*)name Start:(int)start End:(int)end Repeat:(int)repeat Point:(CGPoint)point Duration:(NSTimeInterval)duration
//{
//    @synchronized(self)
//	{
//        UIImageView* animationImageView = [[UIImageView alloc] init];
//        
//        NSMutableArray* imageArray = [[NSMutableArray alloc] init];
//        for(unsigned int i=start; i <= end; i++)
//        {
//            if([FileUtil fileExistsAtPath:[FileUtil pathOfFile:[NSString stringWithFormat:@"%@%d.png",name, i] withPathType:PathTypeResource]]){
//                UIImage* animImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@%d.png",name, i] ofType:nil]];{
//                    [imageArray addObject: animImage];
//                    [animationImageView setFrame:CGRectMake(point.x, point.y, animImage.size.width, animImage.size.height)]; 
//                }
//            }
//        }
//        animationImageView.animationImages = imageArray;
//        animationImageView.animationRepeatCount = repeat;
//        animationImageView.animationDuration = duration;
//        
//        animationImageView.center = point;
//        [animationImageView startAnimating];
//        [self addSubview:animationImageView];
//        [self bringSubviewToFront:animationImageView];
//        
//        [imageArray release];
//        imageArray = nil;
//        
//        [self performSelector:@selector(animationDone:) withObject:animationImageView afterDelay:animationImageView.animationDuration];
//    }
//}
//
//- (void)animationDone:(UIImageView*)animationImageView
//{
//	[animationImageView removeFromSuperview];
//    [animationImageView release];
//    animationImageView = nil;
//}
@end
