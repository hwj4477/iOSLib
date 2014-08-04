//
//  UIView+BasicAnimation.h
//
//  Created by hwj4477 on 12. 5. 11..
//
//  Last Update 12. 11. 7

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface UIView (UIViewBasicAnimation)

- (void)fadeInDuration:(CFTimeInterval)duration;
- (void)fadeOutDuration:(CFTimeInterval)duration;

- (void)flipFromLeftDuration:(CFTimeInterval)duration;
- (void)flipFromRightDuration:(CFTimeInterval)duration;

- (void)curlUpDuration:(CFTimeInterval)duration;
- (void)curlDownDuration:(CFTimeInterval)duration;

- (void)pushInAnimationDuration:(CFTimeInterval)duration;
- (void)pushOutAnimationDuration:(CFTimeInterval)duration;

- (void)rotationAnimationRepeat:(int)repeat Value:(float)value Reverse:(BOOL)reverse Duration:(CFTimeInterval)duration;
- (void)pulseAnimationRepeat:(int)repeat Value:(float)value Reverse:(BOOL)reverse Duration:(CFTimeInterval)duration;
- (void)moveAnimationTo:(CGPoint)toValue Duration:(CFTimeInterval)duration;

//- (void)imageAnimationFileName:(NSString*)name Start:(int)start End:(int)end Repeat:(int)repeat Point:(CGPoint)point Duration:(NSTimeInterval)duration;
@end
