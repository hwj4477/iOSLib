//
//  UITextFiled+PaddingText.m
//
//  Created by hwj4477 on 2014. 7. 14..
//

#import "UITextFiled+PaddingText.h"

@implementation UITextField (UITextFiledPadding)

- (void)setLeftPadding:(int)value
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, value, self.frame.size.height)];
    self.leftView = paddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (void)setRightPadding:(int)value
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, value, self.frame.size.height)];
    self.rightView = paddingView;
    self.rightViewMode = UITextFieldViewModeAlways;
}

@end
