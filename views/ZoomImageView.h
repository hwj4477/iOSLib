//
//  ZoomImageView.h
//
//  Created by hwj4477 on 2014. 3. 18..
//

#import <Foundation/Foundation.h>

@interface ZoomImageView : UIScrollView <UIScrollViewDelegate>{
    UIImageView *imgView;
}

- (void)setZoomImage:(UIImage*)image WithFrame:(CGRect)frame;

@end
