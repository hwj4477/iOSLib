//
//  ZoomImageView.m
//
//  Created by hwj4477 on 2014. 3. 18..
//

#import "ZoomImageView.h"

@implementation ZoomImageView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setView];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
       [self setView];
    }
    return self;
}

- (void)setView
{
    imgView = [[[UIImageView alloc] init] autorelease];
    [self addSubview:imgView];
}

- (void)setZoomImage:(UIImage*)image WithFrame:(CGRect)frame
{
    [imgView setImage:image];
    
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    
    imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [imgView setFrame:frame];
    
    imgView.center = self.center;

    self.delegate = self;
    self.maximumZoomScale = 3.0f;
    self.minimumZoomScale = 1.0f;
    
    [self setContentSize:CGSizeMake(self.frame.size.width, self.frame.size.height)];
    [self setZoomScale:self.minimumZoomScale];
}

#pragma UIScrollView Delegate
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return imgView;
}

@end
